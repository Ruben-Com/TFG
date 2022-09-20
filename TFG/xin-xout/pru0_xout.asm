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
	.global start0
start0:
	LDI32 	R9, 0x00ABCDEF
	LDI32 	R2, 0x00ABCDEF
	XOUT	0x0b, &R2.b0, 0x08
	LDI32	R10, 0x00010200
	SBBO	&R9, R10, 0, 4
	LDI32 	R30, 0xFFFFFFFF
	DELAY 	15000000
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFF3F
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFF2F
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFF0F
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFF0B
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFF03
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFF02
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFF00
	DELAY 	15000000
	JMP	start0	

	HALT
