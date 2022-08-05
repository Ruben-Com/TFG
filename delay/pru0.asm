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

	.clink
	.global start0
start0:
	LDI32	R10, 0x00022000
	LDI32	R9, 0x00010200
	LDI32	R29, 0xAAAAAAAA

	LBBO	&R11, R10, 12, 4
	LBBO	&R12, R10, 12, 4

	XIN	0x0b, &R29, 0x04
	LBBO	&R13, R10, 12, 4

	XIN	0x0b, &R20, 0x20
	LBBO	&R14, R10, 12, 4

	LBBO	&R20, R9, 0, 4
	LBBO	&R15, R10, 12, 4

	LBBO	&R20, R9, 0, 40
	LBBO	&R16, R10, 12, 4

	
	LBBO	&R30.w2, R9, 0, 2 
	NOP
ci5:	ADD	R12, R12, 2
	SET	R30, R30, 13
	QBBS	medir1, R31, 31
	QBEQ	medir1, R10, R12
	LBBO	&R30.w2, R9, 0, 2 
	NOP
	ADD	R12, R12, 2
	QBEQ	medir1, R10, R12
ci15:	SET	R30, R30, 13
	JMP	medir1
medir1:	LBBO	&R17, R10, 12, 4

	LBBO	&R30.w2, R9, 0, 2 
	NOP
	ADD	R12, R12, 2
	SET	R30, R30, 13
	QBBS	medir1, R31, 31
	JMP	aux1
aux1:	LBBO	&R30.w2, R9, 4, 2
	LDI	R12, 8
	JMP	aux2
aux2:	SET	R30, R30, 13
	JMP	aux3
aux3:	JMP	medir2
medir2:	LBBO	&R18, R10, 12, 4

	LBBO	&R30.w2, R9, 0, 2 
	NOP
	ADD	R12, R12, 2
	SET	R30, R30, 13
	QBBS	medir1, R31, 31
	QBEQ	medir1, R10, R12
	LBBO	&R30.w2, R9, 0, 2 
	NOP
	ADD	R12, R12, 2
	JMP	aux4
aux4:	SET	R30, R30, 13
	LDI	R12, 4
	LBBO	&R30.w2, R9, 0, 2
	JMP	aux5
aux5:	ADD	R12, R12, 2
	SET	R30, R30, 13
	QBBS	medir1, R31, 31
	QBEQ	medir1, R10, R12
	LBBO	&R30.w2, R9, 0, 2
	NOP
	ADD	R12, R12, 2
	QBEQ	medir1, R10, R12
	SET	R30, R30, 13
	JMP	medir3
medir3:	LBBO	&R19, R10, 12, 4

	LBBO	&R20, R9, 0, 2
	LBBO	&R20, R10, 12, 4

	HALT
