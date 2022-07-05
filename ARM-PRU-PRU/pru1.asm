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

start1:
	LDI32	R10, 0x00010000
	LBBO	&R11, R10, 0, 4
	QBEQ	scratch_pad, R11.w0, 0
	ADD	R11, R11, 4	;hay que tener en cuenta los 4 primeros bytes para el tamano de la senal
	LDI	R12, 4
	JMP	sram
	HALT

volver:
	JMP	R3.w2
	HALT

sram:
	LBBO	&R30, R10, R12, 4 
	ADD	R12, R12, 4
	SET	R30, R30, 8
	QBBS	volver, R31, 31
	DELAY	10000000
	QBEQ	cond7, R11, R12
	LBBO	&R30, R10, R12, 4 
	DELAY	10000000
	ADD	R12, R12, 4
	QBEQ	cond12, R11, R12
ci13:	SET	R30, R30, 8
	JMP	sram

cond7:
	MOV	R27, R30	;para comprobar que funciona bien
	LBBO	&R30, R10, 4, 4
	MOV	R28, R30	;para comprobar que funciona bien
	DELAY	10000000
	LDI	R12, 8
	JMP	ci13

cond12:
	MOV	R25, R30	;para comprobar que funciona bien
	SET	R30, R30, 8
	LDI	R12, 4
	LBBO	&R30, R10, R12, 4
	MOV	R26, R30	;para comprobar que funciona bien
	DELAY	10000000
	ADD	R12, R12, 4
	SET	R30, R30, 8
	QBBS	volver, R31, 31
	DELAY	10000000
	QBEQ	cond7, R11, R12
	LBBO	&R30, R10, R12, 4 
	DELAY	10000000
	ADD	R12, R12, 4
	QBEQ	cond12, R11, R12
	SET	R30, R30, 8
	JMP	sram


scratch_pad:
	QBEQ	apagar, R11.b3, 0xFF
	QBEQ	parar, R11.b2, 0xFF
	QBEQ	pwm, R11.w2, 1
	QBEQ	valor_fijo, R11.w2, 2
	QBEQ	pulso, R11.w2, 3
	HALT

pwm:
	XIN	0x0b, &R27, 0x0C
vol_tH:	LDI	R26, 0
	NOP
pwm_tH:	MOV	R30, R29
	ADD	R26, R26, 1
	NOP
	DELAY	50000000
	SET	R30, R30, 8
	DELAY	50000000
	QBBS	volver, R31, 31
	NOP
	QBNE	pwm_tH, R26, R27
pwm_tL:	MOV	R30, R28
	ADD	R26, R26, 1
	DELAY	50000000
	QBBS	volver, R31, 31
	SET	R30, R30, 8
	DELAY	50000000
	QBEQ	vol_tH, R26, 4
	NOP
	JMP	pwm_tL
	

valor_fijo:
	XIN	0x0b, &R29.b0, 0x04
	MOV	R30, R29
aux_F:	SET	R30, R30, 8
	NOP
	QBBS	volver, R31, 31
	NOP
	CLR	R30, R30, 8
	NOP
	JMP	aux_F

pulso:
	XIN	0x0b, &R29.b0, 0x04
	MOV	R30, R29
	SET	R30, R30, 8
	NOP
	QBBS	volver, R31, 31
	NOP
	DELAY	100000000
	LDI	R30, 0
	NOP
	NOP
aux_P:	SET	R30, R30, 8
	NOP
	QBBS	volver, R31, 31
	NOP
	CLR	R30, R30, 8
	NOP
	JMP	aux_P

parar:
	JMP r3.w2

apagar:
	HALT	