#include <p33FJ16GS502.h>
#include "uart.h"
//#include "pps.h"

enum  {		NO_ORDEN		= 0x00,
			ON_BUCK2		= 0XA0, 	
			OFF_BUCK2		= 0XA1,
			REF_BUCK2   	= 0XA2,
			TENSION_SALIDA_BUCK2	=0XA3
}numeroOrden;

int cont_RX_bits=0,cont_TX_bits=0,outputVoltage;
char outputVoltageH,referenciaVoltageL,receivedchar;
char outputVoltageL;
extern unsigned int Buck2_reference;
void __attribute__ ((interrupt, no_auto_psv)) _U1RXInterrupt(void) {
			
if (numeroOrden == 0)
numeroOrden=U1RXREG;

switch (numeroOrden)
{
case NO_ORDEN:
break;
case ON_BUCK2:
PTCONbits.PTEN = 1;	
numeroOrden=NO_ORDEN;					//Enable the PWM 
break;
case OFF_BUCK2:
PTCONbits.PTEN = 0;
numeroOrden=NO_ORDEN;					//Enable the PWM 
break;
case REF_BUCK2:

U1TXREG=REF_BUCK2; //orden para que el 18F mande el byte L de la referencia
while (DataRdyUART1()!=1);
referenciaVoltageL=U1RXREG;
numeroOrden=NO_ORDEN;


if (cont_RX_bits==0)
{ //..recibir primer byte
	IFS0bits.U1RXIF = 0; //para poder recibir de nuevo la interrupción
U1TXREG=REF_BUCK2; //orden para que el 18F mande el byte L de la referencia
while (DataRdyUART1()!=1);
referenciaVoltageL=U1RXREG;
cont_RX_bits=1;	// así sabe que el siguiente dato es el byte H de la referencia
U1TXREG=REF_BUCK2;//orden para que el 18F mande el byte H de la referencia
}
else
{
Buck2_reference=U1RXREG;
Buck2_reference=Buck2_reference<<8;
Buck2_reference=(Buck2_reference||referenciaVoltageL);
cont_RX_bits=0;
numeroOrden=NO_ORDEN;
}

break;

case TENSION_SALIDA_BUCK2:
//primer acceso
if (cont_TX_bits==0){
cont_TX_bits=1;
if (PTCONbits.PTEN == 1){
while (ADSTATbits.P1RDY ==0); 	//Mientras no hay dato de la tension de salida espera (se supone que poco tiempo)			
outputVoltage = ADCBUF3;						// Read input Voltage 16 bits
outputVoltageL=(char)outputVoltage; 			//2 de 8 bits para enviar al 18F2450
outputVoltageH=(char)(outputVoltage>>8);
}
else
{

outputVoltageL=0;
outputVoltageH=0;

}
//manda el byte bajo y en la siguiente int el byte alto 					
while(BusyUART1());
U1TXREG=outputVoltageL;
}
else //segundo acceso
{
while(BusyUART1());
U1TXREG=outputVoltageH;
cont_TX_bits=0;
numeroOrden=NO_ORDEN;
ADSTATbits.P2RDY = 0;
}
						// Clear the ADC pair ready bit	
break;
default:

break;
}

	IFS0bits.U1RXIF = 0;
}
void __attribute__ ((interrupt, no_auto_psv)) _U1TXInterrupt(void) {
	IFS0bits.U1TXIF = 0;

}	
void InitUART1() {
	// This is an EXAMPLE, so brutal typing goes into explaining all bit sets

	// The HPC16 board has a DB9 connector wired to UART1, so we will
	// be configuring this port only
	// configure U1MODE


	U1MODEbits.UARTEN = 0;	// Bit15 TX, RX DISABLED, ENABLE at end of func
	//U2MODEbits.notimplemented;	// Bit14
	U1MODEbits.USIDL = 0;	// Bit13 Continue in Idle
	U1MODEbits.IREN = 0;	// Bit12 No IR translation
	U1MODEbits.RTSMD = 0;	// Bit11 Simplex Mode
	U1MODEbits.UEN = 0;		// Bits8,9 TX,RX enabled, CTS,RTS not
	U1MODEbits.WAKE = 0;	// Bit7 No Wake up (since we don't sleep here)
	U1MODEbits.LPBACK = 0;	// Bit6 No Loop Back
	U1MODEbits.ABAUD = 0;	// Bit5 No Autobaud (would require sending '55')
	U1MODEbits.URXINV=0; 		//Bit5 idle state is 1
	U1MODEbits.BRGH = 0;	// Bit3 16 clocks per bit period
	U1MODEbits.PDSEL = 0;	// Bits1,2 8bit, No Parity
	U1MODEbits.STSEL = 0;	// Bit0 One Stop Bit
	
	// Load a value into Baud Rate Generator.  Example is for 9600.
	// See section 19.3.1 of datasheet.
	//  U1BRG = (Fcy/(16*BaudRate))-1
	//  U1BRG = (40M/(16*9600))-1 259
	//  U1BRG = 259
//realemente el usart del 18f4550 esta trabajando a 11494 baudios
//con U1BRG = 216; comprobado que lee bien el dato de 8 bits
	U1BRG = 216;	// 40Mhz osc, 9600 Baud

	// Load all values in for U1STA SFR
	U1STAbits.UTXISEL1 = 1;	//Bit15 Int when Char is transferred (1/2 config!)
	U1STAbits.UTXINV = 1;	//Bit14 U1TX Nivel alto en estado de reposos
	U1STAbits.UTXISEL0 = 0;	//Bit13 Other half of Bit15
	U1STAbits.UTXBRK = 0;	//Bit11 Disabled
	U1STAbits.UTXEN = 0;	//Bit10 TX pins  controlled by GIO
	U1STAbits.UTXBF = 0;	//Bit9 *Read Only Bit*
	U1STAbits.TRMT = 0;		//Bit8 *Read Only bit*
	U1STAbits.URXISEL = 0;	//Bits6,7 Int. on character recieved
	U1STAbits.ADDEN = 0;	//Bit5 Address Detect Disabled
	U1STAbits.RIDLE = 0;	//Bit4 *Read Only Bit*
	U1STAbits.PERR = 0;		//Bit3 *Read Only Bit*
	U1STAbits.FERR = 0;		//Bit2 *Read Only Bit*
	U1STAbits.OERR = 0;		//Bit1 *Read Only Bit*
	U1STAbits.URXDA = 0;	//Bit0 *Read Only Bit*

	IPC7 = 0x4400;	// Mid Range Interrupt Priority level, no urgent reason

	IFS0bits.U1TXIF = 0;	// Clear the Transmit Interrupt Flag
	IEC0bits.U1TXIE = 0;	// Disable Transmit Interrupts
	IFS0bits.U1RXIF = 0;	// Clear the Recieve Interrupt Flag
	IEC0bits.U1RXIE = 1;	// Enable Recieve Interrupts

//	RPOR9bits.RP101R = 3;		//RF5 as U2TX
//Pin 18 LINKED WITH UART1 RECEIVE

//PPSOutput(PPS_U1TX,PPS_RP6); /*U1TX on RP5*/
//TRISBbits.TRISB6=0;// pin 7 salida digital
//__builtin_write_OSCCONL(OSCCON & ~(1<<6));	//unLOCK peripheral Pin Select ds70190E PAGE 30.12	
//__builtin_write_OSCCONL(OSCCON & 0XDF);
//__builtin_write_OSCCONL(OSCCON & 0X46);
//__builtin_write_OSCCONL(OSCCON|0XDF);
RPINR18bits.U1RXR=7;
RPOR3bits.RP6R=3;// RB6 (pin 17)  U1TX

//__builtin_write_OSCCONL(OSCCON|0X40);  //LOCK peripheral Pin Select


U1MODEbits.UARTEN = 1;	// And turn the  on
	U1STAbits.UTXEN = 1;


}