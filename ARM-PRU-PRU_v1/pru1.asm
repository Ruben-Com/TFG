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
	LBBO	&R11, R10, 0, 4
	QBEQ	scratch_pad, R11.w0, 0
	JMP	sram


sram:
	


scratch_pad:
	QBEQ	apagar, R11.b3, 0xFF
	QBEQ	parar, R11.b2, 0xFF
	QBEQ	pwm, R11.w2, 1
	QBEQ	valor_fijo, R11.w2, 2
	QBEQ	pulso, R11.w2, 3
	HALT


valor_fijo:
	XIN	0x0b, &R30, 0x04

parar:
	JMP r3.w2

apagar:
	HALT	
