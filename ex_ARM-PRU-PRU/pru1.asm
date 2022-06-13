;*
;* Copyright (C) 2016 Zubeen Tolani <ZeekHuge - zeekhuge@gmail.com>
;*
;* This file is as an example to show how to develope
;* and compile inline assembly code for PRUs
;*
;* This program is free software; you can redistribute it and/or modify
;* it under the terms of the GNU General Public License version 2 as
;* published by the Free Software Foundation.


	.cdecls "main_pru1.c"

DELAY	.macro time
	LDI32	R0, time
	QBEQ	$E?, R0, 0
$M?:	SUB	R0, R0, 1
	QBNE	$M?, R0, 0
$E?:	
	.endm
	

	.clink
	.global start1
start1:
	LDI32	R1, 0x00010200
	LBBO	&R2, R1, 0, 36
	DELAY 	150000000
	MOV 	R30, R2
	DELAY 	150000000
	MOV 	R30, R3
	DELAY 	150000000
	MOV 	R30, R4
	DELAY 	150000000
	MOV 	R30, R5
	DELAY 	150000000
	MOV 	R30, R6
	DELAY 	150000000
	MOV 	R30, R7
	DELAY 	150000000
	MOV 	R30, R8
	DELAY 	150000000
	MOV 	R30, R9
	DELAY 	150000000
	MOV 	R30, R10
