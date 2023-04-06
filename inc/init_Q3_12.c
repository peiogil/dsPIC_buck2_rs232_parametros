


/**********************************************************************
* © 2008 Microchip Technology Inc.
*
* SOFTWARE LICENSE AGREEMENT:
* Microchip Technology Incorporated ("Microchip") retains all ownership and 
* intellectual property rights in the code accompanying this message and in all 
* derivatives hereto.  You may use this code, and any derivatives created by 
* any person or entity by or on your behalf, exclusively with Microchip's
* proprietary products.  Your acceptance and/or use of this code constitutes 
* agreement to the terms and conditions of this notice.
*
* CODE ACCOMPANYING THIS MESSAGE IS SUPPLIED BY MICROCHIP "AS IS".  NO 
* WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED 
* TO, IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A 
* PARTICULAR PURPOSE APPLY TO THIS CODE, ITS INTERACTION WITH MICROCHIP'S 
* PRODUCTS, COMBINATION WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION. 
*
* YOU ACKNOWLEDGE AND AGREE THAT, IN NO EVENT, SHALL MICROCHIP BE LIABLE, WHETHER 
* IN CONTRACT, WARRANTY, TORT (INCLUDING NEGLIGENCE OR BREACH OF STATUTORY DUTY), 
* STRICT LIABILITY, INDEMNITY, CONTRIBUTION, OR OTHERWISE, FOR ANY INDIRECT, SPECIAL, 
* PUNITIVE, EXEMPLARY, INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, FOR COST OR EXPENSE OF 
* ANY KIND WHATSOEVER RELATED TO THE CODE, HOWSOEVER CAUSED, EVEN IF MICROCHIP HAS BEEN 
* ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE.  TO THE FULLEST EXTENT 
* ALLOWABLE BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN ANY WAY RELATED TO 
* THIS CODE, SHALL NOT EXCEED THE PRICE YOU PAID DIRECTLY TO MICROCHIP SPECIFICALLY TO 
* HAVE THIS CODE DEVELOPED.
*
* You agree that you are solely responsible for testing the code and 
* determining its suitability.  Microchip has no obligation to modify, test, 
* certify, or support the code.
*
*******************************************************************************/

#include "p33FJ16GS502.h"
#include "dsp.h"
#include "Functions.h"
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~  PID Variable Definitions  ~~~~~~~~~~~~~~~~~~~~~~~ */

/* Variable Declaration required for each PID controller in the application. */

tPID BuckVoltagePID;


/* These data structures contain a pointer to derived coefficients in X-space and 
   pointer to controler state (history) samples in Y-space. So declare variables 
   for the derived coefficients and the controller history samples 
*/

/*1) C attributes, designated by the __attribute__ keyword, provide a *
* means to specify various characteristics of a variable or *
* function, such as where a particular variable should be placed *
* in memory, whether the variable should be aligned to a certain *
* address boundary, whether a function is an Interrupt Service *
* Routine (ISR), etc. If no special characteristics need to be *
* specified for a variable or function, then attributes are not *
* required. For more information about attributes, refer to the *
* C30 User's Guide. *
* *
* 2) The __section__(".xbss") and __section__(".ybss") attributes are *
* used to place a variable in X data space and Y data space, *
* respectively. Variables accessed by dual-source DSP instructions *
* must be defined using these attributes.
* 3) The aligned(k) attribute, used in variable definitions, is used *
* to align a variable to the nearest higher 'k'-byte address *
* boundary. 'k' must be substituted with a suitable constant *
* number when the ModBuf_X(k) or ModBuf_Y(k) macro is invoked. *
* In most cases, variables are aligned either to avoid potential *
* misaligned memory accesses, or to configure a modulo buffer. *
* *
* 4) The __interrupt__ attribute is used to qualify a function as an *
* interrupt service routine. An interrupt routine can be further *
* configured to save certain variables on the stack, using the *
* __save__(var-list) directive. *
* *
* 5) The __shadow__ attribute is used to set up any function to *
* perform a fast context save using shadow registers. *
* *
* 6) Note the use of double-underscores (__) at the start and end of *
* all the keywords mentioned above. *
* *
**********************************************************************/



/*reserva de memoria en zona x, donde se ubicaran los coeficientes de la fdt*/
fractional Buck2VoltageABC[5] __attribute__ ((section (".xbss, bss, xmemory")));
/*reserva de memoria en zona y, donde se ubicaran error y d actual y anteriores*/
fractional Buck2VoltageHistory[5] __attribute__ ((section (".ybss, bss, ymemory")));
/*el tamaño depende del tipo de regulador a implementar, en este caso tipo3*/



//Buck2 is the 3.3V output with Voltage Mode Control implemented 


/*coeficientes del denominador de la FDT,
 en formato Q3.12 expresada en decimal 
 parte entera +fraqcción con signo cambiado*/

#define PID_BUCK2_A2 -344 //-2^4+...+=-0.083984375_>binario 1xxx.xxx...xxx
#define PID_BUCK2_A1 4440  //binario=1000101011000 &Q3.12=1.000101011000=1.083984375
/*coeficientes del numerador de la FDT, parte entera+decimal enn Q3.12*/
#define PID_BUCK2_B0 7778 //En Q3.12=1.89892578125
#define PID_BUCK2_B1 433
#define PID_BUCK2_B2 -7344


/*funcion de transferencia implementada
//		1.899 z^2 + 0.1057 z - 1.793
//	---------------------------------
//  	z^2 - 1.084 z + 0.08386
*/
/*referencia1=3.3v, del sensor (divisor de tension)*/
/*5/(5+3.3)*3.3=1.988v--->(1.988*1024)/3.3v=617*/
/*ADCres=10, Q15res=15--->617*32=19744 = 0x4D2*/
		 

#define PID_BUCK2_VOLTAGE_REFERENCE 0x9A4				/* Reference voltage is from resistor divider circuit R29 & R30
													    	Voltage FB2 = (5kOhm / (5kOhm + 3.3kOhm)) * 3.3V = 1.988V
														    Now calculate expected ADC value (1.988V * 1024)/3.3V = 617 
															Then left shift by 2 for Q3_12 format (617 * 4) = 2468 = 0x9A4 */
																	  
#define PID_BUCK2_VOLTAGE_REF_MIN 	  0x120			/* Minimum reference voltage is total dead time (72) left shifted by 2 bits*/


/* This is increment rate to give us desired PID_BUCK1VOLTAGE_REFERENCE, PID_BUCK2_VOLTAGE_REFERENCE, 
   and PID_BOOST_VOLTAGE_REFERENCE with 50ms soft start. */
 

#define BUCK2_SOFTSTART_INCREMENT	 0x10

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

extern unsigned int TimerInterruptCount;

unsigned int Buck2ReferenceNew,Buck2ReferenceOld ;


void Buck2Drive(void)
{

    /* Buck2 converter setup to output 3.3V */ 

    IOCON2bits.PENH = 1;               	/* PWM2H is controlled by PWM module */
 
 	//IOCON2bits.PENL = 0;              /* PWM2L is not controlled by PWM module */
    IOCON2bits.PENL = 1;                /* PWM2L is  controlled by PWM module */
    IOCON2bits.PMOD = 0;                /* Complementary Mode */
  
    IOCON2bits.POLH = 0;                /* Drive signals are active-high */
    IOCON2bits.POLL = 0;                /* Drive signals are active-high */

	IOCON2bits.OVRENH = 0;				  /* Disable Override feature for shutdown PWM */  
	IOCON2bits.OVRENL = 0;				  /* Disable Override feature for shutdown PWM */
	IOCON2bits.OVRDAT = 0b00;			  /* Shut down PWM with Over ride 0 on PWMH and PWML */	

            
    PWMCON2bits.DTC = 0;                /*  Positive Deadtime enabled */
    
    DTR2    = 0x18;                	  	/* DTR = (25ns / 1.04ns), where desired dead time is 25ns. 
									     Mask upper two bits since DTR<13:0> */
    ALTDTR2 = 0x30;            		  	/* ALTDTR = (50ns / 1.04ns), where desired dead time is 50ns. 
									     Mask upper two bits since ALTDTR<13:0> */
	   
    PWMCON2bits.IUE = 0;               	/* Disable Immediate duty cycle updates */
    PWMCON2bits.ITB = 0;              	/* Select Primary Timebase mode */
    
    FCLCON2bits.FLTMOD = 3; 			/* Fault Disabled */
           
    TRGCON2bits.TRGDIV = 0;             /* Trigger interrupt generated every PWM cycle*/
    TRGCON2bits.TRGSTRT = 1;            /* Trigger generated after waiting 1 PWM cycles */                  
                                                                  
    PDC2 = 72;                          /* Initial pulse-width = minimum deadtime required (DTR2 + ALDTR2)*/
    TRIG2 = 100;		                    /* Trigger generated at beginning of PWM active period */                                           
}




void CurrentVoltageMeasurements(void)
{
    ADCONbits.FORM = 0;                   /* Integer data format */
    ADCONbits.EIE = 0;                    /* Early Interrupt disabled */
    ADCONbits.ORDER = 0;                  /* Convert even channel first */
    ADCONbits.SEQSAMP = 0;                /* Select simultaneous sampling */
    ADCONbits.ADCS = 5;                   /* ADC clock = FADC/6 = 120MHz / 6 = 20MHz, 
											12*Tad = 1.6 MSPS, two SARs = 3.2 MSPS */
    
    IFS6bits.ADCP1IF = 0;		    	  /* Clear ADC interrupt flag */ 
    IPC27bits.ADCP1IP = 5;			      /* Set ADC interrupt priority */ 
	IEC6bits.ADCP1IE = 1;			      /* Enable the ADC Pair 1 interrupt */
   
 	
    
	ADPCFGbits.PCFG2 = 0; 				  /* PinConCFigAnalog Current Measurement for Buck 2 */ 
    ADPCFGbits.PCFG3 = 0; 				  /* PinConCFigAnalog Voltage Measurement for Buck 2 */

    ADPCFGbits.PCFG4 = 0; 				  /* PinConCFigAnalog Voltage Measurement for input voltage source */	
    

 
    ADSTATbits.P1RDY = 0; 				  /* Clear Pair 1 data ready bit */
    ADCPC0bits.IRQEN1 = 1;                /* Enable ADC Interrupt for Buck 2 control loop */
    ADCPC0bits.TRGSRC1 = 4; 			  /* ADC Pair 1 triggered by PWM2 */


    ADSTATbits.P2RDY = 0; 				  /* Clear Pair 2 data ready bit */
    ADCPC1bits.IRQEN2 = 0;                /* Disable ADC Interrupt for input voltage measurment */
    ADCPC1bits.TRGSRC2 = 4; 			  /* ADC Pair 2 triggered by PWM1 */


}



void Buck2VoltageLoop(void)
{
    BuckVoltagePID.abcCoefficients = Buck2VoltageABC;     /* Set up pointer to derived coefficients */
    BuckVoltagePID.controlHistory = Buck2VoltageHistory;  /* Set up pointer to controller history samples */
    
    PIDInitBuck2(&BuckVoltagePID);                               


/* se llama a funcion pidinit, se le pasan las zonas de memoria x e y para inicializarlas
if ((PID_BUCK2_A1 == 0x7FFF || PID_BUCK2_A1 == 0x8000) ||
(PID_BUCK2_A2 == 0x7FFF || PID_BUCK2_A2 == 0x8000) ||
(PID_BUCK2_B0 == 0x7FFF || PID_BUCK2_B0 == 0x8000) ||
(PID_BUCK2_B1 == 0x7FFF || PID_BUCK2_B1 == 0x8000) ||
(PID_BUCK2_B2 == 0x7FFF || PID_BUCK2_B2 == 0x8000))
{
while(1);  comprobacion de coeficientes en q15, si alguno es q15 entra en bucle infinito
} 
*/
   // ubica los coeficientes en sus posiciones de memoria 

BuckVoltagePID.abcCoefficients[0] = PID_BUCK2_B0;
BuckVoltagePID.abcCoefficients[1] = PID_BUCK2_B1;
BuckVoltagePID.abcCoefficients[2] = PID_BUCK2_B2;
BuckVoltagePID.abcCoefficients[3] = PID_BUCK2_A1;
BuckVoltagePID.abcCoefficients[4] = PID_BUCK2_A2;
  
	BuckVoltagePID.controlReference = PID_BUCK2_VOLTAGE_REF_MIN;

    BuckVoltagePID.measuredOutput = 0;            

}


void Buck2ReferenceRoutine(void)
{
  /* This routine increments the control reference until the reference reaches 
     the desired output voltage reference. In this case the we have a softstart of 50ms 
also in this case controReference stars from 0. It is easier to calculate it than in the Boost case */
if (BuckVoltagePID.controlReference<Buck2ReferenceOld)
{
	while (BuckVoltagePID.controlReference <= Buck2ReferenceOld)
	{
		Delay_ms(1);
		BuckVoltagePID.controlReference += BUCK2_SOFTSTART_INCREMENT;
	}
}
else{
	while (BuckVoltagePID.controlReference > Buck2ReferenceOld)
	{
		Delay_ms(1);
		BuckVoltagePID.controlReference -= BUCK2_SOFTSTART_INCREMENT;
	}

	BuckVoltagePID.controlReference = Buck2ReferenceOld;
}
}

void Buck2RefVoltValInit(void)
{
/*Inicializa la interrupcion por cambio en el pin 14/RB para poder cambiar la referencia
con el potenciometro*/
TRISBbits.TRISB8=1; //Pin 14 conectado a sw1 es una entrada digital.
IEC1bits.CNIE = 1; //Permite las interrupciones por Change Notification//
CNEN1bits.CN8IE=1;  //Cuando se detecte una transicion en 8 se genera la interrupcion CN
CNPU1bits.CN8PUE=1; //PullUP activado (no hace falta con sw1)
IPC4bits.CNIP=4; //Prioridad 4, inferior a la de PMW y conv AD
IFS1bits.CNIF=0; 	//Habilita interrupciones tipo Change Notification
}

void Delay_ms (unsigned int delay)
{
	TimerInterruptCount = 0;		//Clear Interrupt counter flag 
PR1 = 0x9C40;						//(1ms / 25ns) = 40,000 = 0x9C40 
IPC0bits.T1IP = 4;				 	//Set Interrupt Priority lower then ADC
IEC0bits.T1IE = 1;					//Enable Timer1 interrupts 

T1CONbits.TON = 1;					//Enable Timer1 

while (TimerInterruptCount < delay); //Wait for Interrupt counts to equal delay

T1CONbits.TON = 0;					//Disable the Timer 
}
