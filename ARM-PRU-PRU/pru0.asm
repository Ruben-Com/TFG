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
	HALT


start0_I:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0x00FF0000
	SBBO	&R13, R10, 0, 4
	JMP	R3.w2
	HALT


start0_H:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0xFF000000
	SBBO	&R13, R10, 0, 4
	JMP	R3.w2
	HALT


start0_S:
	QBEQ	sen1, R14, 1
	QBEQ	sen2, R14, 2
	;QBEQ	sen3, R14, 3
	HALT

sen1:
	LDI32	R10, 0x00010000
	LDI32	R11, 0x00010130	;244+60 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32 	R13, 400
	SBBO	&R13, R10, 0, 4
	LDI	R15, 0x7f
	LDI	R16, 0x87
	LDI	R17, 0x8f
	LDI	R18, 0x97
	LDI	R19, 0x9f
	LDI	R20, 0xa6
	LDI	R21, 0xae
	LDI	R22, 0xb5
	LDI	R23, 0xbc
	LDI	R24, 0xc3
	LDI	R25, 0xca
	LDI	R26, 0xd0
	LDI	R27, 0xd6
	LDI	R28, 0xdc
	LDI	R29, 0xe1
	SBBO	&R15, R10, 4, 60

	LDI	R15, 0xe6
	LDI	R16, 0xeb
	LDI	R17, 0xef
	LDI	R18, 0xf2
	LDI	R19, 0xf6
	LDI	R20, 0xf8
	LDI	R21, 0xfa
	LDI	R22, 0xfc
	LDI	R23, 0xfd
	LDI	R24, 0xfe
	LDI	R25, 0xff
	LDI	R26, 0xfe
	LDI	R27, 0xfd
	LDI	R28, 0xfc
	LDI	R29, 0xfa
	SBBO	&R15, R10, 64, 60

	LDI	R15, 0xf8
	LDI	R16, 0xf6
	LDI	R17, 0xf2
	LDI	R18, 0xef
	LDI	R19, 0xeb
	LDI	R20, 0xe6
	LDI	R21, 0xe1
	LDI	R22, 0xdc
	LDI	R23, 0xd6
	LDI	R24, 0xd0
	LDI	R25, 0xca
	LDI	R26, 0xc3
	LDI	R27, 0xbc
	LDI	R28, 0xb5
	LDI	R29, 0xae
	SBBO	&R15, R10, 124, 60

	LDI	R15, 0xa6
	LDI	R16, 0x9f
	LDI	R17, 0x97
	LDI	R18, 0x8f
	LDI	R19, 0x87
	LDI	R20, 0x7f
	LDI	R21, 0x77
	LDI	R22, 0x6f
	LDI	R23, 0x67
	LDI	R24, 0x5f
	LDI	R25, 0x58
	LDI	R26, 0x50
	LDI	R27, 0x49
	LDI	R28, 0x42
	LDI	R29, 0x3b
	SBBO	&R15, R10, 184, 60

	LDI	R15, 0x34
	LDI	R16, 0x2e
	LDI	R17, 0x28
	LDI	R18, 0x22
	LDI	R19, 0x1d
	LDI	R20, 0x18
	LDI	R21, 0x13
	LDI	R22, 0xf
	LDI	R23, 0xc
	LDI	R24, 0x8
	LDI	R25, 0x6
	LDI	R26, 0x4
	LDI	R27, 0x2
	LDI	R28, 0x1
	LDI	R29, 0x0
	SBBO	&R15, R10, 244, 60

	LDI	R15, 0x0
	LDI	R16, 0x0
	LDI	R17, 0x1
	LDI	R18, 0x2
	LDI	R19, 0x4
	LDI	R20, 0x6
	LDI	R21, 0x8
	LDI	R22, 0xc
	LDI	R23, 0xf
	LDI	R24, 0x13
	LDI	R25, 0x18
	LDI	R26, 0x1d
	LDI	R27, 0x22
	LDI	R28, 0x28
	LDI	R29, 0x2e
	SBBO	&R15, R11, 0, 60

	LDI	R15, 0x34
	LDI	R16, 0x3b
	LDI	R17, 0x42
	LDI	R18, 0x49
	LDI	R19, 0x50
	LDI	R20, 0x58
	LDI	R21, 0x5f
	LDI	R22, 0x67
	LDI	R23, 0x6f
	LDI	R24, 0x77
	SBBO	&R15, R11, 60, 40
	JMP	r3.w2


sen2:
	LDI32	R10, 0x00010000
	LDI32	R11, 0x00010130	;244+60 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32	R12, 0x0001025C	;R11+300 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32 	R13, 800
	SBBO	&R13, R10, 0, 4
	LDI	R15, 0x7f
	LDI	R16, 0x83
	LDI	R17, 0x87
	LDI	R18, 0x8b
	LDI	R19, 0x8f
	LDI	R20, 0x93
	LDI	R21, 0x97
	LDI	R22, 0x9b
	LDI	R23, 0x9f
	LDI	R24, 0xa3
	LDI	R25, 0xa6
	LDI	R26, 0xaa
	LDI	R27, 0xae
	LDI	R28, 0xb2
	LDI	R29, 0xb5
	SBBO	&R15, R10, 4, 60

	LDI	R15, 0xb9
	LDI	R16, 0xbc
	LDI	R17, 0xc0
	LDI	R18, 0xc3
	LDI	R19, 0xc7
	LDI	R20, 0xca
	LDI	R21, 0xcd
	LDI	R22, 0xd0
	LDI	R23, 0xd3
	LDI	R24, 0xd6
	LDI	R25, 0xd9
	LDI	R26, 0xdc
	LDI	R27, 0xdf
	LDI	R28, 0xe1
	LDI	R29, 0xe4
	SBBO	&R15, R10, 64, 60

	LDI	R15, 0xe6
	LDI	R16, 0xe8
	LDI	R17, 0xeb
	LDI	R18, 0xed
	LDI	R19, 0xef
	LDI	R20, 0xf1
	LDI	R21, 0xf2
	LDI	R22, 0xf4
	LDI	R23, 0xf6
	LDI	R24, 0xf7
	LDI	R25, 0xf8
	LDI	R26, 0xf9
	LDI	R27, 0xfa
	LDI	R28, 0xfb
	LDI	R29, 0xfc
	SBBO	&R15, R10, 124, 60

	LDI	R15, 0xfd
	LDI	R16, 0xfd
	LDI	R17, 0xfe
	LDI	R18, 0xfe
	LDI	R19, 0xfe
	LDI	R20, 0xff
	LDI	R21, 0xfe
	LDI	R22, 0xfe
	LDI	R23, 0xfe
	LDI	R24, 0xfd
	LDI	R25, 0xfd
	LDI	R26, 0xfc
	LDI	R27, 0xfb
	LDI	R28, 0xfa
	LDI	R29, 0xf9
	SBBO	&R15, R10, 184, 60

	LDI	R15, 0xf8
	LDI	R16, 0xf7
	LDI	R17, 0xf6
	LDI	R18, 0xf4
	LDI	R19, 0xf2
	LDI	R20, 0xf1
	LDI	R21, 0xef
	LDI	R22, 0xed
	LDI	R23, 0xeb
	LDI	R24, 0xe8
	LDI	R25, 0xe6
	LDI	R26, 0xe4
	LDI	R27, 0xe1
	LDI	R28, 0xdf
	LDI	R29, 0xdc
	SBBO	&R15, R10, 244, 60

	LDI	R15, 0xd9
	LDI	R16, 0xd6
	LDI	R17, 0xd3
	LDI	R18, 0xd0
	LDI	R19, 0xcd
	LDI	R20, 0xca
	LDI	R21, 0xc7
	LDI	R22, 0xc3
	LDI	R23, 0xc0
	LDI	R24, 0xbc
	LDI	R25, 0xb9
	LDI	R26, 0xb5
	LDI	R27, 0xb2
	LDI	R28, 0xae
	LDI	R29, 0xaa
	SBBO	&R15, R11, 0, 60

	LDI	R15, 0xa6
	LDI	R16, 0xa3
	LDI	R17, 0x9f
	LDI	R18, 0x9b
	LDI	R19, 0x97
	LDI	R20, 0x93
	LDI	R21, 0x8f
	LDI	R22, 0x8b
	LDI	R23, 0x87
	LDI	R24, 0x83
	LDI	R25, 0x7f
	LDI	R26, 0x7b
	LDI	R27, 0x77
	LDI	R28, 0x73
	LDI	R29, 0x6f
	SBBO	&R15, R11, 60, 60

	LDI	R15, 0x6b
	LDI	R16, 0x67
	LDI	R17, 0x63
	LDI	R18, 0x5f
	LDI	R19, 0x5b
	LDI	R20, 0x58
	LDI	R21, 0x54
	LDI	R22, 0x50
	LDI	R23, 0x4c
	LDI	R24, 0x49
	LDI	R25, 0x45
	LDI	R26, 0x42
	LDI	R27, 0x3e
	LDI	R28, 0x3b
	LDI	R29, 0x37
	SBBO	&R15, R11, 120, 60

	LDI	R15, 0x34
	LDI	R16, 0x31
	LDI	R17, 0x2e
	LDI	R18, 0x2b
	LDI	R19, 0x28
	LDI	R20, 0x25
	LDI	R21, 0x22
	LDI	R22, 0x1f
	LDI	R23, 0x1d
	LDI	R24, 0x1a
	LDI	R25, 0x18
	LDI	R26, 0x16
	LDI	R27, 0x13
	LDI	R28, 0x11
	LDI	R29, 0xf
	SBBO	&R15, R11, 180, 60

	LDI	R15, 0xd
	LDI	R16, 0xc
	LDI	R17, 0xa
	LDI	R18, 0x8
	LDI	R19, 0x7
	LDI	R20, 0x6
	LDI	R21, 0x5
	LDI	R22, 0x4
	LDI	R23, 0x3
	LDI	R24, 0x2
	LDI	R25, 0x1
	LDI	R26, 0x1
	LDI	R27, 0x0
	LDI	R28, 0x0
	LDI	R29, 0x0
	SBBO	&R15, R11, 240, 60

	LDI	R15, 0x0
	LDI	R16, 0x0
	LDI	R17, 0x0
	LDI	R18, 0x0
	LDI	R19, 0x1
	LDI	R20, 0x1
	LDI	R21, 0x2
	LDI	R22, 0x3
	LDI	R23, 0x4
	LDI	R24, 0x5
	LDI	R25, 0x6
	LDI	R26, 0x7
	LDI	R27, 0x8
	LDI	R28, 0xa
	LDI	R29, 0xc
	SBBO	&R15, R12, 0, 60

	LDI	R15, 0xd
	LDI	R16, 0xf
	LDI	R17, 0x11
	LDI	R18, 0x13
	LDI	R19, 0x16
	LDI	R20, 0x18
	LDI	R21, 0x1a
	LDI	R22, 0x1d
	LDI	R23, 0x1f
	LDI	R24, 0x22
	LDI	R25, 0x25
	LDI	R26, 0x28
	LDI	R27, 0x2b
	LDI	R28, 0x2e
	LDI	R29, 0x31
	SBBO	&R15, R12, 60, 60

	LDI	R15, 0x34
	LDI	R16, 0x37
	LDI	R17, 0x3b
	LDI	R18, 0x3e
	LDI	R19, 0x42
	LDI	R20, 0x45
	LDI	R21, 0x49
	LDI	R22, 0x4c
	LDI	R23, 0x50
	LDI	R24, 0x54
	LDI	R25, 0x58
	LDI	R26, 0x5b
	LDI	R27, 0x5f
	LDI	R28, 0x63
	LDI	R29, 0x67
	SBBO	&R15, R12, 120, 60

	LDI	R15, 0x6b
	LDI	R16, 0x6f
	LDI	R17, 0x73
	LDI	R18, 0x77
	LDI	R19, 0x7b
	SBBO	&R15, R12, 180, 20
	JMP	r3.w2

