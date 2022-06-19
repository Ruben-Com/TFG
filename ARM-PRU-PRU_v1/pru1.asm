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
	LDI32	R10, 0x00010000
	LDI32	R11, 
	LBBO	&R15, R10, 0, 4
	QBEQ	scratch_pad, R15.w0, 0
	JMP	sram


sram:
	


scratch_pad:
	QBEQ	apagar, R15.w2, 0xFFFF
	QBEQ	parar, R15.w2, 0xFF00
	MOV	R11, R16
	HALT

parar:
	JMP r3.w2

apagar:
	HALT	
