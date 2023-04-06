; ******************************************************************************
; * © 2008 Microchip Technology Inc.
; *
; SOFTWARE LICENSE AGREEMENT:
; Microchip Technology Incorporated ("Microchip") retains all ownership and 
; intellectual property rights in the code accompanying this message and in all 
; derivatives hereto.  You may use this code, and any derivatives created by 
; any person or entity by or on your behalf, exclusively with Microchip's
; proprietary products.  Your acceptance and/or use of this code constitutes 
; agreement to the terms and conditions of this notice.
;
; CODE ACCOMPANYING THIS MESSAGE IS SUPPLIED BY MICROCHIP "AS IS".  NO 
; WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED 
; TO, IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A 
; PARTICULAR PURPOSE APPLY TO THIS CODE, ITS INTERACTION WITH MICROCHIP'S 
; PRODUCTS, COMBINATION WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION. 
;
; YOU ACKNOWLEDGE AND AGREE THAT, IN NO EVENT, SHALL MICROCHIP BE LIABLE, WHETHER 
; IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE OR BREACH OF STATUTORY DUTY), 
; STRICT LIABILITY, INDEMNITY, CONTRIBUTION, OR OTHERWISE, FOR ANY INDIRECT, SPECIAL, 
; PUNITIVE, EXEMPLARY, INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, FOR COST OR EXPENSE OF 
; ANY KIND WHATSOEVER RELATED TO THE CODE, HOWSOEVER CAUSED, EVEN IF MICROCHIP HAS BEEN 
; ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE.  TO THE FULLEST EXTENT 
; ALLOWABLE BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO 
; THIS CODE, SHALL NOT EXCEED THE PRICE YOU PAID DIRECTLY TO MICROCHIP SPECIFICALLY TO 
; HAVE THIS CODE DEVELOPED.
;
; You agree that you are solely responsible for testing the code and 
; determining its suitability.  Microchip has no obligation to modify, test, 
; certify, or support the code.
;
; *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


        ; Local inclusions.
        .nolist
        .include        "dspcommon.inc"         ; fractsetup
        .list

        .equ    offsetabcCoefficients, 0
        .equ    offsetcontrolHistory, 2
        .equ    offsetcontrolOutput, 4
        .equ    offsetmeasuredOutput, 6
        .equ    offsetcontrolReference, 8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        .section .libdsp, code 	; la libreria dsp se añade

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; _PIDInit:
;
; Prototype:
; void PIDInit ( tPID *fooPIDStruct )
;
; Operation: This routine clears the delay line elements in the array
;            _ControlHistory, as well as clears the current PID output
;            element, _ControlOutput
;
; Input:
;       w0 = Address of data structure tPID (type defined in dsp.h)
;
; Return:
;       (void)
;
; System resources usage:
;       w0             used, restored
;
; DO and REPEAT instruction usage.
;       0 level DO instruction
;       0 REPEAT intructions
;
; Program words (24-bit instructions):
;       11
;
; Cycles (including C-function call and return overheads):
;       13
;............................................................................

; definicion de la funcion _pidinit
.global _PIDInitBuck2
; inicio de la funcion
_PIDInitBuck2:
; se resetean las posiciones de memoria donde iran los errores y los d.
push w0
add #offsetcontrolOutput, w0
clr [w0]
pop w0
push w0
mov [w0 + #offsetcontrolHistory], w0
clr [w0++] ; E[n] = 0
clr [w0++] ; E[n-1] = 0
clr [w0++] ; E[n-2] = 0
clr [w0++] ; d[n-1]=0
clr [w0++] ; d[n-2] = 0
clr [w0++]  ; d[n-3] = 0
pop w0 
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 .global _PIDBUCK2                    ; provide global scope to routine
_PIDBUCK2:
        
        ; Save working registers.
        push.s
        push    w4
        push    w5        
        push    w8
        push    w10

        
        push    CORCON                  ; Prepare CORCON for fractional computation.


        fractsetup      w8	;
;***************Esta parte vale para los dos controles************************************

; se toman los valores de los campos de la variable tpid en los siguientes resitros de trabajo
        mov [w0 + #offsetabcCoefficients], w8    ; w8 = Base Address of _abcCoefficients array [(Kp+Ki+Kd), -(Kp+2Kd), Kd]
;w10 <----- puntero a la primera posicion de memoria con error o d (memoria y)      
 mov [w0 + #offsetcontrolHistory], w10    ; w10 = Address of _ControlHistory array (state/delay line)
;w1 <----- valor d antes de hacer el nuevo calculo
        mov [w0 + #offsetcontrolOutput], w1
;w2 <----- valor actual de la variable a controlar (vout del reductor 2)
        mov [w0 + #offsetmeasuredOutput], w2
;w3 <----- valor actual de la referencia a alcanzar
        mov [w0 + #offsetcontrolReference], w3
;recolocacion de las posiciones de error en sus nuevas posiciones
; dejando e[n] listo para actualizarlo con el valor nuevo de error.
		mov [w10 + #+4],w11
		mov w11, [w10 + #+6] ; E[n-3]<==E[n-2]
		mov [w10 + #+2],w11
		mov w11, [w10 + #+4] ; E[n-2]<==E[n-1]
		mov [w10],w11
		mov w11, [w10 + #+2] ; E[n-1]<==E[n]
		; ([W10])-->E[n]<== LIBRE
;**********************+Fin de Esta parte ************************

; Calculate most recent error with saturation, no limit checking required
		; acumulador a<-----w3(referencia), a = tpid.controlreference
		lac w3, a
		; acumulador b<-----w2(valor actual de la variable a controlar), b = tpid.measuredoutput
		lac w2, b
		; acumulador a<-----referencia-valor actual, error [n]
		sub a
		; se redondea sac.r(store acumulator with rounding) 
		;y se mete en [w10], e[n]
		; (se redondea, porque acc 40 bits y [w10], 16 bits)AclararComoRedondeadsPIC
		sac.r a, [w10]
		
		; se limpia el acumulador a, y se prepara en w4 y w5
		clr a, [w8]+=2, w4, [w10]+=2, w5 ; w4 = B0, w5 = E[n]
		; se multiplica y se prepara la siguiente multiplicacion
		; a = b0 * e[n]
		; w4 = b1, w5 = e[n-1]
		mac w4*w5, a, [w8]+=2, w4, [w10]+=2, w5
		; a = b0 * e[n] + b1 * e[n-1]
		; w4 = b2, w5 = e[n-2]
		mac w4*w5, a, [w8]+=2, w4, [w10]+=2, w5
		; a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2]
		; w4 = b3, w5 = e[n-3]
		mac w4*w5, a, [w8]+=2, w4, [w10]+=2, w5
		; a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2] + b3 * e[n-3]
		; w4 = a1, w5 = d[n-1]
		mac w4*w5, a, [w8]+=2, w4, [w10]+=2, w5
		; se mete d[n-1] en b
		lac w1, b
		;a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2] + b3 * e[n-3] + d[n-1]
		add a
		;a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2] + b3 * e[n-3] + 2 * d[n-1]
		add a
		; a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2] + b3 * e[n-3] + 2 * d[n-1] + a1 * d[n-1]
		; en este caso el coeficiente a1, tiene parte entera '2' y parte fraccionaria a1
		; w4 = a2, w5 = d[n-2]
		mac w4*w5, a, [w8]+=2, w4, [w10]+=2, w5
		; se mete d[n-2] en el registro intermedio del acumulador b (high)
		lac w5, b
		; a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2] + b3 * e[n-3] + (2+a1) * d[n-1] + d[n-2]
		; el este caso el coeficiente va restando
		sub a
		; a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2] + b3 * e[n-3] + (2 + a1) * d[n-1] + (1+a2) * d[n-2]
		; en este caso el coeficiente a2, tiene parte entera '1' y parte fraccionaria a2
		; w4 = a3, w5 = d[n-3]
		mac w4*w5, a, [w8], w4, [w10]-=4, w5
		; a = b0 * e[n] + b1 * e[n-1] + b2 * e[n-2] + b3 * e[n-3] + (2 + a1) * d[n-1] + (1+a2) * d[n-2] + a3 * d[n-3]
		mac w4*w5, a,
		; se tiene en a, el valor de la ecuacion en diferencias del regulador tipo3
		; se redondea el valor de d que hay en acc a (40 bits) y se mete la parte mas significativa en w1(16 bits)
		sac.r a, w1


mov [w10 + #+2],w11
mov w11, [w10 + #+4] ; d[n-2]==>d[n-3]
mov [w10],w11
mov w11, [w10 + #+2] ; d[n-1]==>d[n-2]
mov w1,[w10] 		;d[n]==>d[n-1]
mov w1, [w0 + #offsetcontrolOutput]
; se recupera de la pila lo que habia en los registros que han sido usados
pop CORCON
pop w10
pop w8
pop w5
pop w4
pop.s
return
.end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OEF

