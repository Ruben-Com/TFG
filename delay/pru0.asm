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

	XIN	0x0b, &R29, 0x08
	LBBO	&R14, R10, 12, 4

	LBBO	&R20, R9, 0, 4
	LBBO	&R15, R10, 12, 4

	LBBO	&R20, R9, 0, 40
	LBBO	&R16, R10, 12, 4

	HALT
