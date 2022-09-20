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

;* We define the function DELAY
	.cdecls "main_pru1.c"

DELAY	.macro time
	LDI32	R0, time
	QBEQ	$E?, R0, 0
$M?:	SUB	R0, R0, 1
	QBNE	$M?, R0, 0
$E?:	
	.endm
	

;* We define the function start that will be called from the main
	.clink
	.global start
start:
	LDI32 	R30, 0xFFFFFFFF
	LDI32	R0, 0xFFFF0000
	LDI32	R1, 0x0000FFFF
	DELAY 	15000000
	LDI32 	R30, 0xFFFFFFBF
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
	JMP	start	

	HALT
