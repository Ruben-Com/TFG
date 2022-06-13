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
	LDI32 	R2, 0xFFFFFFFF
	LDI32 	R3, 0xFFFFFFFF
	LDI32 	R4, 0xFFFFFFFF
	LDI32 	R5, 0xFFFFFFFF
	LDI32 	R6, 0xFFFFFFFF
	LDI32 	R7, 0xFFFFFFFF
	LDI32 	R8, 0xFFFFFFFF
	LDI32 	R9, 0xFFFFFFFF
	LDI32 	R10, 0xFFFFFFFF
	
	LDI32	R1, 0x00010200
	LDI32 	R2, 0x000000FF
	LDI32 	R3, 0x000000BF
	LDI32 	R4, 0x0000003F
	LDI32 	R5, 0x0000002F
	LDI32 	R6, 0x0000000F
	LDI32 	R7, 0x0000000B
	LDI32 	R8, 0x00000003
	LDI32 	R9, 0x00000002
	LDI32 	R10, 0x00000000
	SBBO	&R2, R1, 0, 36


	.global start0_L
start0_L:
	LDI32 	R2, 0xFFFFFFFF
	LDI32 	R3, 0xFFFFFFFF
	LDI32 	R4, 0xFFFFFFFF
	LDI32 	R5, 0xFFFFFFFF
	LDI32 	R6, 0xFFFFFFFF
	LDI32 	R7, 0xFFFFFFFF
	LDI32 	R8, 0xFFFFFFFF
	LDI32 	R9, 0xFFFFFFFF
	LDI32 	R10, 0xFFFFFFFF
	
	LDI32	R1, 0x00010200
	LDI32 	R2, 0x00000000
	LDI32 	R3, 0x00000002
	LDI32 	R4, 0x00000003
	LDI32 	R5, 0x0000000B
	LDI32 	R6, 0x0000000F
	LDI32 	R7, 0x0000002F
	LDI32 	R8, 0x0000003F
	LDI32 	R9, 0x000000BF
	LDI32 	R10, 0x000000FF
	SBBO	&R2, R1, 0, 36
