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

	.clink
	.global start0_F
start0_F:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0x00010000
	SBBO	&R13, R10, 0, 4
	MOV	R30, R14
	XOUT	0x0a, &R30, 0x04

;* Return direction is stored in R3.w2 and return value is stored in R14
	JMP	R3.w2


start0_I:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0xFF000000
	SBBO	&R13, R10, 0, 4
	JMP	R3.w2


start0_H:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0xFFFF0000
	SBBO	&R13, R10, 0, 4
	JMP	R3.w2
