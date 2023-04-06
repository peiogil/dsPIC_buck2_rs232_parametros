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

.equ __33FJ16GS502, 1
.include "p33FJ16GS502.inc"




; Buck 2 Minimum Duty cycle for voltage mode control
.equ Buck2MinDC, 72




.equ    offsetabcCoefficients, 0
.equ    offsetcontrolHistory, 2
.equ    offsetcontrolOutput, 4
.equ    offsetmeasuredOutput, 6
.equ    offsetcontrolReference, 8

.data

.text
; a partir de aqui a la memoria de programa


.global __ADCP1Interrupt




__ADCP1Interrupt:
    push w0
    push w1 
	push w2  

    mov #_BuckVoltagePID, w0			
    ;mov #617, w1 ;PARA PROBAR 
	mov ADCBUF3, w1
    sl  w1, #2, w1 					;escalado en 2 bits hacia la izquierda para adecuarlo a 12 bits de
									;de 16Q12 ¿Q3.12?

    mov w1, [w0+#offsetmeasuredOutput]
    call _PIDBUCK2 						; Call PIDBUCK2 routine
    mov.w [w0+#offsetcontrolOutput], w1 ; Clamp PID output to allowed limits
   
    mov.w #Buck2MinDC, w0				; saturate to minimum duty cycle
	cpsgt w1, w0
	mov.w w0, w1
	asr w1, #3, w0 	
	
;mov #617, w0 ;PARA PROBAR 
	mov.w w0, PDC2						; Update new Duty Cycle

   ;mov.w w0, TRIG2						; Update new trigger value to correspond to new duty cycle

    bclr	ADSTAT,	#1					; Clear Pair 1 conversion status bit
	bclr	IFS6, #15					; Clear Pair 1 Interrupt Flag

    pop w2
    pop w1
    pop w0
	retfie			 					; Return from interrupt
    

	.end



