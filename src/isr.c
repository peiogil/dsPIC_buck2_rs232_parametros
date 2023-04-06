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
#include "uart.h"
unsigned int TimerInterruptCount = 0; 
extern tPID BuckVoltagePID;

void __attribute__((__interrupt__, no_auto_psv)) _T1Interrupt()
{
  TimerInterruptCount ++; 	/* Increment interrupt counter */
  IFS0bits.T1IF = 0; 		/* Clear Interrupt Flag */
}

/*************************************************
this interrupt routine captures the
current voltage value present in the potentiometer and transmits it
by series communication. The interrupt function is activated
when de SW1 button is pushed.
**************************************************/
void  __attribute__((__interrupt__, no_auto_psv)) _CNInterrupt()
{
    int VPotRefence;
while (ADSTATbits.P2RDY ==0);
VPotRefence=ADCBUF5;
VPotRefence=VPotRefence<<5;
BuckVoltagePID.controlReference=VPotRefence;
IFS1bits.CNIF=0; 	//Habilita interrupcon de sw1
/*
int outputVoltage2;
char outputVoltageL2, outputVoltageH2;

if  (PTCONbits.PTEN == 1) 
{
while (ADSTATbits.P2RDY ==0);
outputVoltage2=ADCBUF5;
outputVoltageL2=(char)outputVoltage2; 
outputVoltageH2=(char)(outputVoltage2>>8);
}
else 
{
outputVoltageL2=0;
outputVoltageH2=0;
}

//while(U1STAbits.TRMT==0);
//U1TXREG=0xff;
//while(U1STAbits.TRMT==0);
//U1TXREG=0x55;
//while(U1STAbits.TRMT==0);

U1TXREG=0x55;

ADSTATbits.P2RDY = 0;						// Clear the ADC pair ready bit
IFS1bits.CNIF=0; 	//Habilita interrupcon de sw1
*/
}
