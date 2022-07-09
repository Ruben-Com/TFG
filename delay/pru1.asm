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


;* We define the function start that will be called from the main
	.clink
	.global start1
start1:
	LDI32	R10, 0x00024000
	LDI32	R9, 0x00010200
	LDI32	R11, 0x00000002
	LDI32	R28, 0x0000000F

	LBBO	&R11, R10, 12, 4
	LBBO	&R12, R10, 12, 4

	XOUT	0x0b, &R29, 0x04
	LBBO	&R13, R10, 12, 4

	XOUT	0x0b, &R20, 0x20
	LBBO	&R14, R10, 12, 4

	SBBO	&R20, R9, 0, 4
	LBBO	&R15, R10, 12, 4

	SBBO	&R28, R9, 4, 8
	LBBO	&R16, R10, 12, 4

	SBBO	&R20, R9, 12, 40
	LBBO	&R17, R10, 12, 4

	LBBO	&R29, R9, 52, 8
	LBBO	&R18, R10, 12, 4


;caso en el que quedan mas de 8 bytes
	LBBO	&R29, R9, 0, 8
	SET	R30, R30, 8
	ADD	R12, R12, 8
	QBEQ	medir, R31, 123
	MOV	R30, R29
	QBEQ	medir, R11, 123
	QBEQ	medir, R11, 119
	SET	R30, R30, 8
	JMP	medir
medir:	LBBO	&R19, R10, 12, 4


;caso en el que quedan 0 bytes por leer
	LBBO	&R29, R9, 0, 8
	SET	R30, R30, 8
	ADD	R12, R12, 8
	QBEQ	medir, R31, 123
	MOV	R30, R29
	QBEQ	aux1, R11, 2
aux1:	LDI	R11, 4
	SET	R30, R30, 8
	JMP	medir2
medir2:	LBBO	&R20, R10, 12, 4


;caso en el que quedan 4 bytes por leer (2 ciclos)
	LBBO	&R29, R9, 0, 8
	SET	R30, R30, 8
	ADD	R12, R12, 8
	QBEQ	medir, R31, 123
	MOV	R30, R29
	QBEQ	medir, R11, 123
	QBEQ	aux2, R11, 4
aux2:	NOP
	SET	R30, R30, 8
	LBBO	&R30, R9, 0, 4
	LDI	R11, 4
	SET	R30, R30, 8
	ADD	R12, R12, 4
	LBBO	&R30, R9, 0, 4
	QBEQ	medir, R31, 123
	SET	R30, R30, 8
	JMP	medir3
medir3:	LBBO	&R21, R10, 12, 4


	LDI32	R6, 4			;tarda un ciclo mas que LDI
	LBBO	&R22, R10, 12, 4

	MOV	R30, R29	;PWM TH
	ADD	R26, R26, 1
	NOP
	SET	R30, R30, 8
	QBBS	medir4, R31, 31
	NOP
	JMP	medir4
medir4:	LBBO	&R24, R10, 12, 4

	MOV	R30, R28	;PWM TL
	ADD	R26, R26, 1
	QBBS	medir5, R31, 31
	SET	R30, R30, 8
	QBEQ	medir5, R26, 4
	NOP
	JMP	medir5
medir5:	LBBO	&R25, R10, 12, 4

	LBBO	&R30, R9, 0, 4	;ciclo normal 
	ADD	R12, R12, 4
	QBBS	medir6, R31, 31
	SET	R30, R30, 8
	QBEQ	medir6, R11, R12
	LBBO	&R30, R9, 0, 4 
	ADD	R12, R12, 4
	QBEQ	medir6, R11, R12
	SET	R30, R30, 8
	JMP	medir6
medir6:	LBBO	&R26, R10, 12, 4

	LBBO	&R30, R9, 0, 4	;ciclo con cond7 
	ADD	R12, R12, 4
	QBBS	medir7, R31, 31
	SET	R30, R30, 8
	QBEQ	medir7, R11, R12
	LBBO	&R30, R9, 4, 4
	LDI	R12, 8
	JMP	ci13
ci13:	SET	R30, R30, 8
	JMP	medir7
medir7:	LBBO	&R27, R10, 12, 4

	LBBO	&R30, R9, 0, 4	;ciclo con cond12
	ADD	R12, R12, 4
	QBBS	medir8, R31, 31
	SET	R30, R30, 8
	QBEQ	medir8, R11, R12
	LBBO	&R30, R9, 0, 4 
	ADD	R12, R12, 4
	QBEQ	medir8, R11, R12

	SET	R30, R30, 8
	LDI	R12, 4
	LBBO	&R30, R9, R12, 4
	ADD	R12, R12, 4
	SET	R30, R30, 8
	QBBS	medir8, R31, 31
	QBEQ	medir8, R11, R12
	LBBO	&R30, R9, R12, 4 
	ADD	R12, R12, 4
	QBEQ	medir8, R11, R12
	SET	R30, R30, 8
	JMP	medir8

medir8:	LBBO	&R28, R10, 12, 4

	QBEQ	medir9, R11, R12
medir9:	LBBO	&R29, R10, 12, 4


	HALT
