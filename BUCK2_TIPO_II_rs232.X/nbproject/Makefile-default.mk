#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../src/isr.c ../src/main.c pid_TIPO_II_Q3_12.s isr_asm_Q3_12.s D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/rs232_params_Q3_12.c D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/init_Q3_12.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1360937237/isr.o ${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/pid_TIPO_II_Q3_12.o ${OBJECTDIR}/isr_asm_Q3_12.o ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o ${OBJECTDIR}/_ext/592891521/init_Q3_12.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1360937237/isr.o.d ${OBJECTDIR}/_ext/1360937237/main.o.d ${OBJECTDIR}/pid_TIPO_II_Q3_12.o.d ${OBJECTDIR}/isr_asm_Q3_12.o.d ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.d ${OBJECTDIR}/_ext/592891521/init_Q3_12.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1360937237/isr.o ${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/pid_TIPO_II_Q3_12.o ${OBJECTDIR}/isr_asm_Q3_12.o ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o ${OBJECTDIR}/_ext/592891521/init_Q3_12.o

# Source Files
SOURCEFILES=../src/isr.c ../src/main.c pid_TIPO_II_Q3_12.s isr_asm_Q3_12.s D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/rs232_params_Q3_12.c D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/init_Q3_12.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33FJ16GS502
MP_LINKER_FILE_OPTION=,--script="..\h\p33FJ16GS502.gld"
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/pid_TIPO_II_Q3_12.o: pid_TIPO_II_Q3_12.s  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/pid_TIPO_II_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/pid_TIPO_II_Q3_12.o.ok ${OBJECTDIR}/pid_TIPO_II_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/pid_TIPO_II_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/pid_TIPO_II_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_AS} $(MP_EXTRA_AS_PRE)  pid_TIPO_II_Q3_12.s -o ${OBJECTDIR}/pid_TIPO_II_Q3_12.o -omf=elf -p=$(MP_PROCESSOR_OPTION) --defsym=__MPLAB_BUILD=1 --defsym=__MPLAB_DEBUG=1 --defsym=__ICD2RAM=1 --defsym=__DEBUG=1 --defsym=__MPLAB_DEBUGGER_ICD3=1 -g  -MD "${OBJECTDIR}/pid_TIPO_II_Q3_12.o.d" -I"../inc" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -g$(MP_EXTRA_AS_POST)
	
${OBJECTDIR}/isr_asm_Q3_12.o: isr_asm_Q3_12.s  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/isr_asm_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/isr_asm_Q3_12.o.ok ${OBJECTDIR}/isr_asm_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/isr_asm_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/isr_asm_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_AS} $(MP_EXTRA_AS_PRE)  isr_asm_Q3_12.s -o ${OBJECTDIR}/isr_asm_Q3_12.o -omf=elf -p=$(MP_PROCESSOR_OPTION) --defsym=__MPLAB_BUILD=1 --defsym=__MPLAB_DEBUG=1 --defsym=__ICD2RAM=1 --defsym=__DEBUG=1 --defsym=__MPLAB_DEBUGGER_ICD3=1 -g  -MD "${OBJECTDIR}/isr_asm_Q3_12.o.d" -I"../inc" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -g$(MP_EXTRA_AS_POST)
	
else
${OBJECTDIR}/pid_TIPO_II_Q3_12.o: pid_TIPO_II_Q3_12.s  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/pid_TIPO_II_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/pid_TIPO_II_Q3_12.o.ok ${OBJECTDIR}/pid_TIPO_II_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/pid_TIPO_II_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/pid_TIPO_II_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_AS} $(MP_EXTRA_AS_PRE)  pid_TIPO_II_Q3_12.s -o ${OBJECTDIR}/pid_TIPO_II_Q3_12.o -omf=elf -p=$(MP_PROCESSOR_OPTION) --defsym=__MPLAB_BUILD=1 -g  -MD "${OBJECTDIR}/pid_TIPO_II_Q3_12.o.d" -I"../inc" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -g$(MP_EXTRA_AS_POST)
	
${OBJECTDIR}/isr_asm_Q3_12.o: isr_asm_Q3_12.s  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/isr_asm_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/isr_asm_Q3_12.o.ok ${OBJECTDIR}/isr_asm_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/isr_asm_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/isr_asm_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_AS} $(MP_EXTRA_AS_PRE)  isr_asm_Q3_12.s -o ${OBJECTDIR}/isr_asm_Q3_12.o -omf=elf -p=$(MP_PROCESSOR_OPTION) --defsym=__MPLAB_BUILD=1 -g  -MD "${OBJECTDIR}/isr_asm_Q3_12.o.d" -I"../inc" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -g$(MP_EXTRA_AS_POST)
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1360937237/isr.o: ../src/isr.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/isr.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/isr.o.ok ${OBJECTDIR}/_ext/1360937237/isr.o.err 
	@${RM} ${OBJECTDIR}/_ext/1360937237/isr.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360937237/isr.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/1360937237/isr.o.d" -o ${OBJECTDIR}/_ext/1360937237/isr.o ../src/isr.c    
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.ok ${OBJECTDIR}/_ext/1360937237/main.o.err 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360937237/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    
	
${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o: D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/rs232_params_Q3_12.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/592891521" 
	@${RM} ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.ok ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.d" -o ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/rs232_params_Q3_12.c    
	
${OBJECTDIR}/_ext/592891521/init_Q3_12.o: D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/init_Q3_12.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/592891521" 
	@${RM} ${OBJECTDIR}/_ext/592891521/init_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/_ext/592891521/init_Q3_12.o.ok ${OBJECTDIR}/_ext/592891521/init_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/_ext/592891521/init_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/592891521/init_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/592891521/init_Q3_12.o.d" -o ${OBJECTDIR}/_ext/592891521/init_Q3_12.o D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/init_Q3_12.c    
	
else
${OBJECTDIR}/_ext/1360937237/isr.o: ../src/isr.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/isr.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/isr.o.ok ${OBJECTDIR}/_ext/1360937237/isr.o.err 
	@${RM} ${OBJECTDIR}/_ext/1360937237/isr.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360937237/isr.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/1360937237/isr.o.d" -o ${OBJECTDIR}/_ext/1360937237/isr.o ../src/isr.c    
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.ok ${OBJECTDIR}/_ext/1360937237/main.o.err 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/1360937237/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    
	
${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o: D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/rs232_params_Q3_12.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/592891521" 
	@${RM} ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.ok ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o.d" -o ${OBJECTDIR}/_ext/592891521/rs232_params_Q3_12.o D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/rs232_params_Q3_12.c    
	
${OBJECTDIR}/_ext/592891521/init_Q3_12.o: D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/init_Q3_12.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/_ext/592891521" 
	@${RM} ${OBJECTDIR}/_ext/592891521/init_Q3_12.o.d 
	@${RM} ${OBJECTDIR}/_ext/592891521/init_Q3_12.o.ok ${OBJECTDIR}/_ext/592891521/init_Q3_12.o.err 
	@${RM} ${OBJECTDIR}/_ext/592891521/init_Q3_12.o 
	@${FIXDEPS} "${OBJECTDIR}/_ext/592891521/init_Q3_12.o.d" $(SILENT) -rsi ${MP_CC_DIR}../ -c ${MP_CC} $(MP_EXTRA_CC_PRE)  -g -omf=elf -x c -c -mcpu=$(MP_PROCESSOR_OPTION) -Wall -I"../h" -I"C:/Archivos de programa/Microchip/MPLAB C30/include" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/h" -I"C:/Documents and Settings/pgil/Mis documentos/Hezkuntza/DSP_18F/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_2/inc" -I"." -MMD -MF "${OBJECTDIR}/_ext/592891521/init_Q3_12.o.d" -o ${OBJECTDIR}/_ext/592891521/init_Q3_12.o D:/D/GARRANTZITSUENA/ESKOLAK/MASTER_EP/PRÁCTICAS/FLY-BACK/FBDig/Fb_dig_soft/DCDC_PTAIL_PC_18F2450_DSP/DSP33FJ/BUCK2_16BIT_28_PIN_TIPO_II_3/inc/init_Q3_12.c    
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../h/p33FJ16GS502.gld
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG -D__MPLAB_DEBUGGER_ICD3=1 -o dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}         -Wl,--defsym=__MPLAB_BUILD=1,--stack=16,-L"../h",-L"C:/Archivos de programa/Microchip/MPLAB C30/lib",-L".",-Map="${DISTDIR}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.map",--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_ICD3=1
else
dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   ../h/p33FJ16GS502.gld
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -omf=elf -mcpu=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}         -Wl,--defsym=__MPLAB_BUILD=1,--stack=16,-L"../h",-L"C:/Archivos de programa/Microchip/MPLAB C30/lib",-L".",-Map="${DISTDIR}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.map",--report-mem$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION)
	${MP_CC_DIR}\\pic30-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/BUCK2_TIPO_II_rs232.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -omf=elf
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
