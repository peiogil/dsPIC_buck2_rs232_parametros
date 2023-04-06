/****************************************************************************
*
* functions.h
* Interface to the DSP Library for the dsPIC30F.
*
****************************************************************************/
#include "dsp.h"

void Buck1Drive(void);
void Buck2Drive(void);
void BoostDrive(void);
void CurrentVoltageMeasurements(void);
void Buck1VoltageLoop(void);
void Buck2VoltageLoop(void);
void BoostVoltageLoop(void);
void Buck1SoftStartRoutine(void);
void Buck2ReferenceRoutine(void);
void BoostSoftStartRoutine(void);
void Delay_ms(unsigned int);
void PIDInitBuck2(tPID *);
void Buck2RefVoltValPotIntr(void);
void InitUART1(void);

