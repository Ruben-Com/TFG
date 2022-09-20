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


start0_W:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0x00010000
	SBBO	&R13, R10, 0, 4
	QBEQ	pwm_1, R14, 1
	QBEQ	pwm_2, R14, 2
	QBEQ	pwm_3, R14, 3
	HALT

pwm_1:
	LDI	R26, 0xFFF
	LDI	R27, 0x000
	LDI	R28, 0x000
	LDI	R29, 0x000
	XOUT	0x0a, &R26.b0, 16
	XOUT	0x0b, &R26.b0, 16
	XOUT	0x0c, &R26.b0, 16
	JMP	R3.w2

pwm_2:
	LDI	R26, 0xFFF
	LDI	R27, 0xFFF
	LDI	R28, 0x000
	LDI	R29, 0x000
	XOUT	0x0a, &R26.b0, 16
	XOUT	0x0b, &R26.b0, 16
	XOUT	0x0c, &R26.b0, 16
	JMP	R3.w2

pwm_3:
	LDI	R26, 0xFFF
	LDI	R27, 0xFFF
	LDI	R28, 0xFFF
	LDI	R29, 0x000
	XOUT	0x0a, &R26.b0, 16
	XOUT	0x0b, &R26.b0, 16
	XOUT	0x0c, &R26.b0, 16
	JMP	R3.w2


start0_F:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0x00020000
	SBBO	&R13, R10, 0, 4
	MOV	R29, R14
	XOUT	0x0b, &R29.b0, 0x04
	JMP	R3.w2
	HALT


start0_P:
	LDI32	R10, 0x00010000
	LDI32 	R13, 0x00030000
	SBBO	&R13, R10, 0, 4
	MOV	R29, R14
	XOUT	0x0b, &R29.b0, 0x04
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


start0_D:
	LDI32	R10, 0x00010000
	LDI32	R18, 0x0FF0
	QBNE	aux_D1, R14, 1
	LDI32 	R9, 1024
aux_D1:	QBNE	aux_D2, R14, 2
	LDI32 	R9, 2048
aux_D2:	QBNE	aux_D3, R14, 3
	LDI32 	R9, 3072
aux_D3:	SBBO	&R9, R10, 0, 4
	LDI32 	R15, 0xFFFFFFF0
	LDI32 	R17, 4
aux_D4:	LDI32 	R16, 0
	ADD	R15, R15, 0x10
aux_D5:	SBBO	&R15, R10, R17, 4
	ADD	R16, R16, 1
	ADD	R17, R17, 4
	QBLT	aux_D5, R14, R16
	QBLT	aux_D4, R15, R18
	JMP	R3.w2


start0_T:
	LDI32	R10, 0x00010000
	LDI32	R18, 0x0FF0
	QBNE	aux_T1, R14, 1
	LDI32 	R9, 2040
aux_T1:	QBNE	aux_T2, R14, 2
	LDI32 	R9, 4080
aux_T2:	QBNE	aux_T3, R14, 3
	LDI32 	R9, 6120
aux_T3:	SBBO	&R9, R10, 0, 4
	LDI32 	R15, 0xFFFFFFF0
	LDI32 	R17, 4
aux_T4:	LDI32 	R16, 0
	ADD	R15, R15, 0x10
aux_T5:	SBBO	&R15, R10, R17, 4
	ADD	R16, R16, 1
	ADD	R17, R17, 4
	QBLT	aux_T5, R14, R16
	QBNE	aux_T4, R15, R18
aux_T6:	LDI32 	R16, 0
	SUB	R15, R15, 0x10
aux_T7:	SBBO	&R15, R10, R17, 4
	ADD	R16, R16, 1
	ADD	R17, R17, 4
	QBLT	aux_T7, R14, R16
	QBNE	aux_T6, R15, 0x10
	JMP	R3.w2


start0_R:
	LDI32	R10, 0x00010000
	LDI32	R11, 0x00010130	;244+60 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32	R12, 0x0001025C	;R11+300 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32 	R9, 0x0000FFFF
	LDI	R9.w2, 800
	SBBO	&R9, R10, 0, 4
	LDI	R15, 0x2b7
	LDI	R16, 0x50d
	LDI	R17, 0x70e
	LDI	R18, 0x8c4
	LDI	R19, 0xac8
	LDI	R20, 0xb72
	LDI	R21, 0xc79
	LDI	R22, 0xd53
	LDI	R23, 0xe07
	LDI	R24, 0xe98
	LDI	R25, 0xf0a
	LDI	R26, 0xf63
	LDI	R27, 0xfa5
	LDI	R28, 0xfd3
	LDI	R29, 0xfef
	SBBO	&R15, R10, 4, 60

	LDI	R15, 0xffd
	LDI	R16, 0xffd
	LDI	R17, 0xff2
	LDI	R18, 0xfde
	LDI	R19, 0xfc1
	LDI	R20, 0xf9d
	LDI	R21, 0xf73
	LDI	R22, 0xf44
	LDI	R23, 0xf11
	LDI	R24, 0xeda
	LDI	R25, 0xea1
	LDI	R26, 0xe65
	LDI	R27, 0xe27
	LDI	R28, 0xde7
	LDI	R29, 0xda7
	SBBO	&R15, R10, 64, 60

	LDI	R15, 0xd66
	LDI	R16, 0xd24
	LDI	R17, 0xce2
	LDI	R18, 0xca0
	LDI	R19, 0xc5f
	LDI	R20, 0xc1d
	LDI	R21, 0xbdc
	LDI	R22, 0xb9c
	LDI	R23, 0xb5c
	LDI	R24, 0xb1d
	LDI	R25, 0xadf
	LDI	R26, 0xaa2
	LDI	R27, 0xa66
	LDI	R28, 0xa2b
	LDI	R29, 0x9f0
	SBBO	&R15, R10, 124, 60

	LDI	R15, 0x9b7
	LDI	R16, 0x97f
	LDI	R17, 0x947
	LDI	R18, 0x911
	LDI	R19, 0x8dc
	LDI	R20, 0x8a8
	LDI	R21, 0x875
	LDI	R22, 0x843
	LDI	R23, 0x812
	LDI	R24, 0x7e2
	LDI	R25, 0x7b3
	LDI	R26, 0x786
	LDI	R27, 0x759
	LDI	R28, 0x72d
	LDI	R29, 0x702
	SBBO	&R15, R10, 184, 60

	LDI	R15, 0x6d8
	LDI	R16, 0x6af
	LDI	R17, 0x687
	LDI	R18, 0x660
	LDI	R19, 0x63a
	LDI	R20, 0x614
	LDI	R21, 0x5f0
	LDI	R22, 0x5cc
	LDI	R23, 0x5a9
	LDI	R24, 0x587
	LDI	R25, 0x566
	LDI	R26, 0x545
	LDI	R27, 0x526
	LDI	R28, 0x507
	LDI	R29, 0x4e8
	SBBO	&R15, R10, 244, 60

	LDI	R15, 0x4cb
	LDI	R16, 0x4ae
	LDI	R17, 0x492
	LDI	R18, 0x476
	LDI	R19, 0x45b
	LDI	R20, 0x441
	LDI	R21, 0x427
	LDI	R22, 0x40e
	LDI	R23, 0x3f6
	LDI	R24, 0x3de
	LDI	R25, 0x3c6
	LDI	R26, 0x3b0
	LDI	R27, 0x399
	LDI	R28, 0x384
	LDI	R29, 0x36e
	SBBO	&R15, R11, 0, 60

	LDI	R15, 0x35a
	LDI	R16, 0x345
	LDI	R17, 0x332
	LDI	R18, 0x31e
	LDI	R19, 0x30b
	LDI	R20, 0x2f9
	LDI	R21, 0x2e7
	LDI	R22, 0x2d6
	LDI	R23, 0x2c4
	LDI	R24, 0x2b4
	LDI	R25, 0x2a3
	LDI	R26, 0x293
	LDI	R27, 0x284
	LDI	R28, 0x275
	LDI	R29, 0x266
	SBBO	&R15, R11, 60, 60

	LDI	R15, 0x257
	LDI	R16, 0x249
	LDI	R17, 0x23b
	LDI	R18, 0x22e
	LDI	R19, 0x221
	LDI	R20, 0x214
	LDI	R21, 0x207
	LDI	R22, 0x1fb
	LDI	R23, 0x1ef
	LDI	R24, 0x1e3
	LDI	R25, 0x1d8
	LDI	R26, 0x1cd
	LDI	R27, 0x1c2
	LDI	R28, 0x1b7
	LDI	R29, 0x1ad
	SBBO	&R15, R11, 120, 60

	LDI	R15, 0x1a3
	LDI	R16, 0x199
	LDI	R17, 0x18f
	LDI	R18, 0x186
	LDI	R19, 0x17d
	LDI	R20, 0x174
	LDI	R21, 0x16b
	LDI	R22, 0x162
	LDI	R23, 0x15a
	LDI	R24, 0x152
	LDI	R25, 0x14a
	LDI	R26, 0x142
	LDI	R27, 0x13a
	LDI	R28, 0x133
	LDI	R29, 0x12c
	SBBO	&R15, R11, 180, 60

	LDI	R15, 0x125
	LDI	R16, 0x11e
	LDI	R17, 0x117
	LDI	R18, 0x110
	LDI	R19, 0x10a
	LDI	R20, 0x104
	LDI	R21, 0x0fd
	LDI	R22, 0x0f7
	LDI	R23, 0x0f2
	LDI	R24, 0x0ec
	LDI	R25, 0x0e6
	LDI	R26, 0x0e1
	LDI	R27, 0x0dc
	LDI	R28, 0x0d6
	LDI	R29, 0x0d1
	SBBO	&R15, R11, 240, 60

	LDI	R15, 0x0cc
	LDI	R16, 0x0c7
	LDI	R17, 0x0c3
	LDI	R18, 0x0be
	LDI	R19, 0x0ba
	LDI	R20, 0x0b5
	LDI	R21, 0x0b1
	LDI	R22, 0x0ad
	LDI	R23, 0x0a9
	LDI	R24, 0x0a5
	LDI	R25, 0x0a1
	LDI	R26, 0x09d
	LDI	R27, 0x099
	LDI	R28, 0x096
	LDI	R29, 0x092
	SBBO	&R15, R12, 0, 60

	LDI	R15, 0x08f
	LDI	R16, 0x08b
	LDI	R17, 0x088
	LDI	R18, 0x085
	LDI	R19, 0x082
	LDI	R20, 0x07f
	LDI	R21, 0x07c
	LDI	R22, 0x079
	LDI	R23, 0x076
	LDI	R24, 0x073
	LDI	R25, 0x070
	LDI	R26, 0x06e
	LDI	R27, 0x06b
	LDI	R28, 0x068
	LDI	R29, 0x066
	SBBO	&R15, R12, 60, 60

	LDI	R15, 0x064
	LDI	R16, 0x061
	LDI	R17, 0x05f
	LDI	R18, 0x05d
	LDI	R19, 0x05a
	LDI	R20, 0x058
	LDI	R21, 0x056
	LDI	R22, 0x054
	LDI	R23, 0x052
	LDI	R24, 0x050
	LDI	R25, 0x04e
	LDI	R26, 0x04c
	LDI	R27, 0x04b
	LDI	R28, 0x049
	LDI	R29, 0x047
	SBBO	&R15, R12, 120, 60

	LDI	R15, 0x045
	LDI	R16, 0x044
	LDI	R17, 0x042
	LDI	R18, 0x041
	LDI	R19, 0x03f
	SBBO	&R15, R12, 180, 20

	JMP	r3.w2


start0_S:
	QBEQ	sen1, R14, 1
	QBEQ	sen2, R14, 2
	QBEQ	sen3, R14, 3
	HALT

sen1:
	LDI32	R10, 0x00010000
	LDI32	R11, 0x00010130	;244+60 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32 	R9, 400
	SBBO	&R9, R10, 0, 4
	LDI	R15, 0x7ff
	LDI	R16, 0x880
	LDI	R17, 0x900
	LDI	R18, 0x97f
	LDI	R19, 0x9fc
	LDI	R20, 0xa78
	LDI	R21, 0xaf1
	LDI	R22, 0xb67
	LDI	R23, 0xbd9
	LDI	R24, 0xc48
	LDI	R25, 0xcb2
	LDI	R26, 0xd18
	LDI	R27, 0xd79
	LDI	R28, 0xdd4
	LDI	R29, 0xe29
	SBBO	&R15, R10, 4, 60

	LDI	R15, 0xe77
	LDI	R16, 0xec0
	LDI	R17, 0xf01
	LDI	R18, 0xf3c
	LDI	R19, 0xf6f
	LDI	R20, 0xf9a
	LDI	R21, 0xfbe
	LDI	R22, 0xfda
	LDI	R23, 0xfee
	LDI	R24, 0xffa
	LDI	R25, 0xfff
	LDI	R26, 0xffa
	LDI	R27, 0xfee
	LDI	R28, 0xfda
	LDI	R29, 0xfbe
	SBBO	&R15, R10, 64, 60

	LDI	R15, 0xf9a
	LDI	R16, 0xf6f
	LDI	R17, 0xf3c
	LDI	R18, 0xf01
	LDI	R19, 0xec0
	LDI	R20, 0xe77
	LDI	R21, 0xe29
	LDI	R22, 0xdd4
	LDI	R23, 0xd79
	LDI	R24, 0xd18
	LDI	R25, 0xcb2
	LDI	R26, 0xc48
	LDI	R27, 0xbd9
	LDI	R28, 0xb67
	LDI	R29, 0xaf1
	SBBO	&R15, R10, 124, 60

	LDI	R15, 0xa78
	LDI	R16, 0x9fc
	LDI	R17, 0x97f
	LDI	R18, 0x900
	LDI	R19, 0x880
	LDI	R20, 0x7ff
	LDI	R21, 0x77e
	LDI	R22, 0x6fe
	LDI	R23, 0x67f
	LDI	R24, 0x602
	LDI	R25, 0x586
	LDI	R26, 0x50d
	LDI	R27, 0x497
	LDI	R28, 0x425
	LDI	R29, 0x3b6
	SBBO	&R15, R10, 184, 60

	LDI	R15, 0x34c
	LDI	R16, 0x2e6
	LDI	R17, 0x285
	LDI	R18, 0x22a
	LDI	R19, 0x1d5
	LDI	R20, 0x187
	LDI	R21, 0x13e
	LDI	R22, 0x0fd
	LDI	R23, 0x0c2
	LDI	R24, 0x08f
	LDI	R25, 0x064
	LDI	R26, 0x040
	LDI	R27, 0x024
	LDI	R28, 0x010
	LDI	R29, 0x004
	SBBO	&R15, R10, 244, 60

	LDI	R15, 0x000
	LDI	R16, 0x004
	LDI	R17, 0x010
	LDI	R18, 0x024
	LDI	R19, 0x040
	LDI	R20, 0x064
	LDI	R21, 0x08f
	LDI	R22, 0x0c2
	LDI	R23, 0x0fd
	LDI	R24, 0x13e
	LDI	R25, 0x187
	LDI	R26, 0x1d5
	LDI	R27, 0x22a
	LDI	R28, 0x285
	LDI	R29, 0x2e6
	SBBO	&R15, R11, 0, 60

	LDI	R15, 0x34c
	LDI	R16, 0x3b6
	LDI	R17, 0x425
	LDI	R18, 0x497
	LDI	R19, 0x50d
	LDI	R20, 0x586
	LDI	R21, 0x602
	LDI	R22, 0x67f
	LDI	R23, 0x6fe
	LDI	R24, 0x77e
	SBBO	&R15, R11, 60, 40
	JMP	r3.w2


sen2:
	LDI32	R10, 0x00010000
	LDI32	R11, 0x00010130	;244+60 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32	R12, 0x0001025C	;R11+300 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32 	R9, 800
	SBBO	&R9, R10, 0, 4
	LDI	R15, 0x7ff
	LDI	R16, 0x83f
	LDI	R17, 0x880
	LDI	R18, 0x8c0
	LDI	R19, 0x900
	LDI	R20, 0x93f
	LDI	R21, 0x97f
	LDI	R22, 0x9be
	LDI	R23, 0x9fc
	LDI	R24, 0xa3a
	LDI	R25, 0xa78
	LDI	R26, 0xab5
	LDI	R27, 0xaf1
	LDI	R28, 0xb2c
	LDI	R29, 0xb67
	SBBO	&R15, R10, 4, 60

	LDI	R15, 0xba1
	LDI	R16, 0xbd9
	LDI	R17, 0xc11
	LDI	R18, 0xc48
	LDI	R19, 0xc7e
	LDI	R20, 0xcb2
	LDI	R21, 0xce6
	LDI	R22, 0xd18
	LDI	R23, 0xd49
	LDI	R24, 0xd79
	LDI	R25, 0xda7
	LDI	R26, 0xdd4
	LDI	R27, 0xdff
	LDI	R28, 0xe29
	LDI	R29, 0xe51
	SBBO	&R15, R10, 64, 60

	LDI	R15, 0xe77
	LDI	R16, 0xe9c
	LDI	R17, 0xec0
	LDI	R18, 0xee1
	LDI	R19, 0xf01
	LDI	R20, 0xf1f
	LDI	R21, 0xf3c
	LDI	R22, 0xf56
	LDI	R23, 0xf6f
	LDI	R24, 0xf85
	LDI	R25, 0xf9a
	LDI	R26, 0xfad
	LDI	R27, 0xfbe
	LDI	R28, 0xfcd
	LDI	R29, 0xfda
	SBBO	&R15, R10, 124, 60

	LDI	R15, 0xfe5
	LDI	R16, 0xfee
	LDI	R17, 0xff5
	LDI	R18, 0xffa
	LDI	R19, 0xffd
	LDI	R20, 0xfff
	LDI	R21, 0xffd
	LDI	R22, 0xffa
	LDI	R23, 0xff5
	LDI	R24, 0xfee
	LDI	R25, 0xfe5
	LDI	R26, 0xfda
	LDI	R27, 0xfcd
	LDI	R28, 0xfbe
	LDI	R29, 0xfad
	SBBO	&R15, R10, 184, 60

	LDI	R15, 0xf9a
	LDI	R16, 0xf85
	LDI	R17, 0xf6f
	LDI	R18, 0xf56
	LDI	R19, 0xf3c
	LDI	R20, 0xf1f
	LDI	R21, 0xf01
	LDI	R22, 0xee1
	LDI	R23, 0xec0
	LDI	R24, 0xe9c
	LDI	R25, 0xe77
	LDI	R26, 0xe51
	LDI	R27, 0xe29
	LDI	R28, 0xdff
	LDI	R29, 0xdd4
	SBBO	&R15, R10, 244, 60

	LDI	R15, 0xda7
	LDI	R16, 0xd79
	LDI	R17, 0xd49
	LDI	R18, 0xd18
	LDI	R19, 0xce6
	LDI	R20, 0xcb2
	LDI	R21, 0xc7e
	LDI	R22, 0xc48
	LDI	R23, 0xc11
	LDI	R24, 0xbd9
	LDI	R25, 0xba1
	LDI	R26, 0xb67
	LDI	R27, 0xb2c
	LDI	R28, 0xaf1
	LDI	R29, 0xab5
	SBBO	&R15, R11, 0, 60

	LDI	R15, 0xa78
	LDI	R16, 0xa3a
	LDI	R17, 0x9fc
	LDI	R18, 0x9be
	LDI	R19, 0x97f
	LDI	R20, 0x93f
	LDI	R21, 0x900
	LDI	R22, 0x8c0
	LDI	R23, 0x880
	LDI	R24, 0x83f
	LDI	R25, 0x7ff
	LDI	R26, 0x7bf
	LDI	R27, 0x77e
	LDI	R28, 0x73e
	LDI	R29, 0x6fe
	SBBO	&R15, R11, 60, 60

	LDI	R15, 0x6bf
	LDI	R16, 0x67f
	LDI	R17, 0x640
	LDI	R18, 0x602
	LDI	R19, 0x5c4
	LDI	R20, 0x586
	LDI	R21, 0x549
	LDI	R22, 0x50d
	LDI	R23, 0x4d2
	LDI	R24, 0x497
	LDI	R25, 0x45d
	LDI	R26, 0x425
	LDI	R27, 0x3ed
	LDI	R28, 0x3b6
	LDI	R29, 0x380
	SBBO	&R15, R11, 120, 60

	LDI	R15, 0x34c
	LDI	R16, 0x318
	LDI	R17, 0x2e6
	LDI	R18, 0x2b5
	LDI	R19, 0x285
	LDI	R20, 0x257
	LDI	R21, 0x22a
	LDI	R22, 0x1ff
	LDI	R23, 0x1d5
	LDI	R24, 0x1ad
	LDI	R25, 0x187
	LDI	R26, 0x162
	LDI	R27, 0x13e
	LDI	R28, 0x11d
	LDI	R29, 0x0fd
	SBBO	&R15, R11, 180, 60

	LDI	R15, 0x0df
	LDI	R16, 0x0c2
	LDI	R17, 0x0a8
	LDI	R18, 0x08f
	LDI	R19, 0x079
	LDI	R20, 0x064
	LDI	R21, 0x051
	LDI	R22, 0x040
	LDI	R23, 0x031
	LDI	R24, 0x024
	LDI	R25, 0x019
	LDI	R26, 0x010
	LDI	R27, 0x009
	LDI	R28, 0x004
	LDI	R29, 0x001
	SBBO	&R15, R11, 240, 60

	LDI	R15, 0x000
	LDI	R16, 0x001
	LDI	R17, 0x004
	LDI	R18, 0x009
	LDI	R19, 0x010
	LDI	R20, 0x019
	LDI	R21, 0x024
	LDI	R22, 0x031
	LDI	R23, 0x040
	LDI	R24, 0x051
	LDI	R25, 0x064
	LDI	R26, 0x079
	LDI	R27, 0x08f
	LDI	R28, 0x0a8
	LDI	R29, 0x0c2
	SBBO	&R15, R12, 0, 60

	LDI	R15, 0x0df
	LDI	R16, 0x0fd
	LDI	R17, 0x11d
	LDI	R18, 0x13e
	LDI	R19, 0x162
	LDI	R20, 0x187
	LDI	R21, 0x1ad
	LDI	R22, 0x1d5
	LDI	R23, 0x1ff
	LDI	R24, 0x22a
	LDI	R25, 0x257
	LDI	R26, 0x285
	LDI	R27, 0x2b5
	LDI	R28, 0x2e6
	LDI	R29, 0x318
	SBBO	&R15, R12, 60, 60

	LDI	R15, 0x34c
	LDI	R16, 0x380
	LDI	R17, 0x3b6
	LDI	R18, 0x3ed
	LDI	R19, 0x425
	LDI	R20, 0x45d
	LDI	R21, 0x497
	LDI	R22, 0x4d2
	LDI	R23, 0x50d
	LDI	R24, 0x549
	LDI	R25, 0x586
	LDI	R26, 0x5c4
	LDI	R27, 0x602
	LDI	R28, 0x640
	LDI	R29, 0x67f
	SBBO	&R15, R12, 120, 60

	LDI	R15, 0x6bf
	LDI	R16, 0x6fe
	LDI	R17, 0x73e
	LDI	R18, 0x77e
	LDI	R19, 0x7bf
	SBBO	&R15, R12, 180, 20
	JMP	r3.w2

sen3:
	LDI32	R10, 0x00010000
	LDI32	R11, 0x00010130	;244+60 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32	R12, 0x0001025C	;R11+300 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32	R13, 0x00010388	;R12+300 (ultimo offset mas ultima cantidad de bytes escrita)
	LDI32 	R9, 1200
	SBBO	&R9, R10, 0, 4
	LDI	R15, 0x7ff
	LDI	R16, 0x82a
	LDI	R17, 0x855
	LDI	R18, 0x880
	LDI	R19, 0x8aa
	LDI	R20, 0x8d5
	LDI	R21, 0x900
	LDI	R22, 0x92a
	LDI	R23, 0x954
	LDI	R24, 0x97f
	LDI	R25, 0x9a9
	LDI	R26, 0x9d3
	LDI	R27, 0x9fc
	LDI	R28, 0xa26
	LDI	R29, 0xa4f
	SBBO	&R15, R10, 4, 60

	LDI	R15, 0xa78
	LDI	R16, 0xaa0
	LDI	R17, 0xac9
	LDI	R18, 0xaf1
	LDI	R19, 0xb18
	LDI	R20, 0xb40
	LDI	R21, 0xb67
	LDI	R22, 0xb8d
	LDI	R23, 0xbb4
	LDI	R24, 0xbd9
	LDI	R25, 0xbff
	LDI	R26, 0xc24
	LDI	R27, 0xc48
	LDI	R28, 0xc6c
	LDI	R29, 0xc90
	SBBO	&R15, R10, 64, 60

	LDI	R15, 0xcb2
	LDI	R16, 0xcd5
	LDI	R17, 0xcf7
	LDI	R18, 0xd18
	LDI	R19, 0xd39
	LDI	R20, 0xd59
	LDI	R21, 0xd79
	LDI	R22, 0xd98
	LDI	R23, 0xdb6
	LDI	R24, 0xdd4
	LDI	R25, 0xdf1
	LDI	R26, 0xe0d
	LDI	R27, 0xe29
	LDI	R28, 0xe44
	LDI	R29, 0xe5e
	SBBO	&R15, R10, 124, 60

	LDI	R15, 0xe77
	LDI	R16, 0xe90
	LDI	R17, 0xea8
	LDI	R18, 0xec0
	LDI	R19, 0xed6
	LDI	R20, 0xeec
	LDI	R21, 0xf01
	LDI	R22, 0xf16
	LDI	R23, 0xf29
	LDI	R24, 0xf3c
	LDI	R25, 0xf4d
	LDI	R26, 0xf5f
	LDI	R27, 0xf6f
	LDI	R28, 0xf7e
	LDI	R29, 0xf8d
	SBBO	&R15, R10, 184, 60

	LDI	R15, 0xf9a
	LDI	R16, 0xfa7
	LDI	R17, 0xfb3
	LDI	R18, 0xfbe
	LDI	R19, 0xfc8
	LDI	R20, 0xfd2
	LDI	R21, 0xfda
	LDI	R22, 0xfe2
	LDI	R23, 0xfe9
	LDI	R24, 0xfee
	LDI	R25, 0xff3
	LDI	R26, 0xff7
	LDI	R27, 0xffa
	LDI	R28, 0xffd
	LDI	R29, 0xffe
	SBBO	&R15, R10, 244, 60

	LDI	R15, 0xfff
	LDI	R16, 0xffe
	LDI	R17, 0xffd
	LDI	R18, 0xffa
	LDI	R19, 0xff7
	LDI	R20, 0xff3
	LDI	R21, 0xfee
	LDI	R22, 0xfe9
	LDI	R23, 0xfe2
	LDI	R24, 0xfda
	LDI	R25, 0xfd2
	LDI	R26, 0xfc8
	LDI	R27, 0xfbe
	LDI	R28, 0xfb3
	LDI	R29, 0xfa7
	SBBO	&R15, R11, 0, 60

	LDI	R15, 0xf9a
	LDI	R16, 0xf8d
	LDI	R17, 0xf7e
	LDI	R18, 0xf6f
	LDI	R19, 0xf5f
	LDI	R20, 0xf4d
	LDI	R21, 0xf3c
	LDI	R22, 0xf29
	LDI	R23, 0xf16
	LDI	R24, 0xf01
	LDI	R25, 0xeec
	LDI	R26, 0xed6
	LDI	R27, 0xec0
	LDI	R28, 0xea8
	LDI	R29, 0xe90
	SBBO	&R15, R11, 60, 60

	LDI	R15, 0xe77
	LDI	R16, 0xe5e
	LDI	R17, 0xe44
	LDI	R18, 0xe29
	LDI	R19, 0xe0d
	LDI	R20, 0xdf1
	LDI	R21, 0xdd4
	LDI	R22, 0xdb6
	LDI	R23, 0xd98
	LDI	R24, 0xd79
	LDI	R25, 0xd59
	LDI	R26, 0xd39
	LDI	R27, 0xd18
	LDI	R28, 0xcf7
	LDI	R29, 0xcd5
	SBBO	&R15, R11, 120, 60

	LDI	R15, 0xcb2
	LDI	R16, 0xc90
	LDI	R17, 0xc6c
	LDI	R18, 0xc48
	LDI	R19, 0xc24
	LDI	R20, 0xbff
	LDI	R21, 0xbd9
	LDI	R22, 0xbb4
	LDI	R23, 0xb8d
	LDI	R24, 0xb67
	LDI	R25, 0xb40
	LDI	R26, 0xb18
	LDI	R27, 0xaf1
	LDI	R28, 0xac9
	LDI	R29, 0xaa0
	SBBO	&R15, R11, 180, 60

	LDI	R15, 0xa78
	LDI	R16, 0xa4f
	LDI	R17, 0xa26
	LDI	R18, 0x9fc
	LDI	R19, 0x9d3
	LDI	R20, 0x9a9
	LDI	R21, 0x97f
	LDI	R22, 0x954
	LDI	R23, 0x92a
	LDI	R24, 0x900
	LDI	R25, 0x8d5
	LDI	R26, 0x8aa
	LDI	R27, 0x880
	LDI	R28, 0x855
	LDI	R29, 0x82a
	SBBO	&R15, R11, 240, 60

	LDI	R15, 0x7ff
	LDI	R16, 0x7d4
	LDI	R17, 0x7a9
	LDI	R18, 0x77e
	LDI	R19, 0x754
	LDI	R20, 0x729
	LDI	R21, 0x6fe
	LDI	R22, 0x6d4
	LDI	R23, 0x6aa
	LDI	R24, 0x67f
	LDI	R25, 0x655
	LDI	R26, 0x62b
	LDI	R27, 0x602
	LDI	R28, 0x5d8
	LDI	R29, 0x5af
	SBBO	&R15, R12, 0, 60

	LDI	R15, 0x586
	LDI	R16, 0x55e
	LDI	R17, 0x535
	LDI	R18, 0x50d
	LDI	R19, 0x4e6
	LDI	R20, 0x4be
	LDI	R21, 0x497
	LDI	R22, 0x471
	LDI	R23, 0x44a
	LDI	R24, 0x425
	LDI	R25, 0x3ff
	LDI	R26, 0x3da
	LDI	R27, 0x3b6
	LDI	R28, 0x392
	LDI	R29, 0x36e
	SBBO	&R15, R12, 60, 60

	LDI	R15, 0x34c
	LDI	R16, 0x329
	LDI	R17, 0x307
	LDI	R18, 0x2e6
	LDI	R19, 0x2c5
	LDI	R20, 0x2a5
	LDI	R21, 0x285
	LDI	R22, 0x266
	LDI	R23, 0x248
	LDI	R24, 0x22a
	LDI	R25, 0x20d
	LDI	R26, 0x1fa
	LDI	R27, 0x1d5
	LDI	R28, 0x1ba
	LDI	R29, 0x1a0
	SBBO	&R15, R12, 120, 60

	LDI	R15, 0x187
	LDI	R16, 0x16e
	LDI	R17, 0x156
	LDI	R18, 0x13e
	LDI	R19, 0x128
	LDI	R20, 0x112
	LDI	R21, 0x0fd
	LDI	R22, 0x0e8
	LDI	R23, 0x0d5
	LDI	R24, 0x0c2
	LDI	R25, 0x0b1
	LDI	R26, 0x09f
	LDI	R27, 0x08f
	LDI	R28, 0x080
	LDI	R29, 0x071
	SBBO	&R15, R12, 180, 60

	LDI	R15, 0x064
	LDI	R16, 0x057
	LDI	R17, 0x04b
	LDI	R18, 0x040
	LDI	R19, 0x036
	LDI	R20, 0x02c
	LDI	R21, 0x024
	LDI	R22, 0x01c
	LDI	R23, 0x015
	LDI	R24, 0x010
	LDI	R25, 0x00b
	LDI	R26, 0x007
	LDI	R27, 0x004
	LDI	R28, 0x001
	LDI	R29, 0x000
	SBBO	&R15, R12, 240, 60

	LDI	R15, 0x000
	LDI	R16, 0x000
	LDI	R17, 0x001
	LDI	R18, 0x004
	LDI	R19, 0x007
	LDI	R20, 0x00b
	LDI	R21, 0x010
	LDI	R22, 0x015
	LDI	R23, 0x01c
	LDI	R24, 0x024
	LDI	R25, 0x02c
	LDI	R26, 0x036
	LDI	R27, 0x040
	LDI	R28, 0x04b
	LDI	R29, 0x057
	SBBO	&R15, R13, 0, 60

	LDI	R15, 0x064
	LDI	R16, 0x071
	LDI	R17, 0x080
	LDI	R18, 0x08f
	LDI	R19, 0x09f
	LDI	R20, 0x0b1
	LDI	R21, 0x0c2
	LDI	R22, 0x0d5
	LDI	R23, 0x0e8
	LDI	R24, 0x0fd
	LDI	R25, 0x112
	LDI	R26, 0x128
	LDI	R27, 0x13e
	LDI	R28, 0x156
	LDI	R29, 0x16e
	SBBO	&R15, R13, 60, 60

	LDI	R15, 0x187
	LDI	R16, 0x1a0
	LDI	R17, 0x1ba
	LDI	R18, 0x1d5
	LDI	R19, 0x1f1
	LDI	R20, 0x20d
	LDI	R21, 0x22a
	LDI	R22, 0x248
	LDI	R23, 0x266
	LDI	R24, 0x285
	LDI	R25, 0x2a5
	LDI	R26, 0x2c5
	LDI	R27, 0x2e6
	LDI	R28, 0x307
	LDI	R29, 0x329
	SBBO	&R15, R13, 120, 60

	LDI	R15, 0x34c
	LDI	R16, 0x36e
	LDI	R17, 0x392
	LDI	R18, 0x3b6
	LDI	R19, 0x3da
	LDI	R20, 0x3ff
	LDI	R21, 0x425
	LDI	R22, 0x44a
	LDI	R23, 0x471
	LDI	R24, 0x497
	LDI	R25, 0x4be
	LDI	R26, 0x4e6
	LDI	R27, 0x50d
	LDI	R28, 0x535
	LDI	R29, 0x55e
	SBBO	&R15, R13, 180, 60

	LDI	R15, 0x586
	LDI	R16, 0x5af
	LDI	R17, 0x5d8
	LDI	R18, 0x602
	LDI	R19, 0x62b
	LDI	R20, 0x655
	LDI	R21, 0x67f
	LDI	R22, 0x6aa
	LDI	R23, 0x6d4
	LDI	R24, 0x6fe
	LDI	R25, 0x729
	LDI	R26, 0x754
	LDI	R27, 0x77e
	LDI	R28, 0x7a9
	LDI	R29, 0x7d4
	SBBO	&R15, R13, 240, 60

	JMP	r3.w2
