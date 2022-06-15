;* Source Modified by Rubén Comerón Galán < Batuecas12 - rubencg2000@hotmail.es >
;*
;* Copyright (C) 2016 Zubeen Tolani <ZeekHuge - zeekhuge@gmail.com>
;*
;* This file is as an example to show how to develope
;* and compile inline assembly code for PRUs
;*
;* This program is free software; you can redistribute it and/or modify
;* it under the terms of the GNU General Public License version 2 as
;* published by the Free Software Foundation.


	.cdecls "main_pru0.c"

DELAY	.macro time
	LDI32	R0, time
	QBEQ	$E?, R0, 0
$M?:	SUB	R0, R0, 1
	QBNE	$M?, R0, 0
$E?:	
	.endm
	

	.clink
	.global start0_R
start0_R:
;* We store this values in order to check that they change before getting stored
	LDI32 	R15, 0xFFFFFFFF
	LDI32 	R16, 0xFFFFFFFF
	LDI32 	R17, 0xFFFFFFFF
	LDI32 	R18, 0xFFFFFFFF
	LDI32 	R19, 0xFFFFFFFF
	LDI32 	R20, 0xFFFFFFFF
	LDI32 	R21, 0xFFFFFFFF
	LDI32 	R22, 0xFFFFFFFF
	LDI32 	R23, 0xFFFFFFFF
	
	LDI32	R10, 0x00010200
	LDI32 	R15, 0x000000FF
	LDI32 	R16, 0x000000BF
	LDI32 	R17, 0x0000003F
	LDI32 	R18, 0x0000002F
	LDI32 	R19, 0x0000000F
	LDI32 	R20, 0x0000000B
	LDI32 	R21, 0x00000003
	LDI32 	R22, 0x00000002
	LDI32 	R23, 0x00000000
	SBBO	&R15, R10, 0, 36

;* Return direction is stored in R3.w2 and return value is stored in R14
	JMP	R3.w2

	.global start0_L
start0_L:
	LDI32 	R15, 0xFFFFFFFF
	LDI32 	R16, 0xFFFFFFFF
	LDI32 	R17, 0xFFFFFFFF
	LDI32 	R18, 0xFFFFFFFF
	LDI32 	R19, 0xFFFFFFFF
	LDI32 	R20, 0xFFFFFFFF
	LDI32 	R21, 0xFFFFFFFF
	LDI32 	R22, 0xFFFFFFFF
	LDI32 	R23, 0xFFFFFFFF
	
	LDI32	R10, 0x00010200
	LDI32 	R15, 0x00000000
	LDI32 	R16, 0x00000002
	LDI32 	R17, 0x00000003
	LDI32 	R18, 0x0000000B
	LDI32 	R19, 0x0000000F
	LDI32 	R20, 0x0000002F
	LDI32 	R21, 0x0000003F
	LDI32 	R22, 0x000000BF
	LDI32 	R23, 0x000000FF
	SBBO	&R15, R10, 0, 36

	JMP	R3.w2
