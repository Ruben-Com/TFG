The executable "connector" is the C program used to access the file /dev/rpmsg_30 in order to send and receive messages from PRU0 through a more friendly interface. Using that program, the user will be able to select between different options of signals with some parameters in each one through an interactive menu. The possible signals and possible customizable parameters are:

	Nombre			Abreviacion		Parametros				Codigo en 2 MS bytes
	---------------------------------------------------------------------------------------------------------------

	Diente de sierra	   (D)			[Velocidad=1]
	Senoidal		   (S)			[Velocidad=1]
	Triangular		   (T)			[Velocidad=1]
	PWM			   (W)			[Tiempo en alto=2]				0x0001
	Valor fijo		   (F)			[Valor=0x0F]					0x0002
	Pulso			   (P)			[Valor=0xFF]					0x0003

	Pulso de radiacion	   (R)			[Unico (1) o solapado (2)]			0xFFFF
	Interrumpir senal	   (I)									0xFF00
	Apagar PRU		   (H)									0x00FF

IMPORTANT: The byte limit should be 4 bytes higher than communicated as the first 4 bytes are used for signal size			<br />
For PRU communication, I will use the first 4 bytes of SRAM (starting at 0x0001_0000). The 2 less significant bytes contain the number of bytes that will be stored in SRAM. If this value is 0x0000, the PRU will check for the 2 most significant bytes (they contain the code for the signal/action). If their [2 MS bytes] value is 0x00FF it will stop the current signal and if it is 0xFF00 it will turn off the PRU. There will also exist the posibility of the value being 0x0001 (PWM), 0x0002 (Valor fijo) and 0x0003 (Pulso). 
For PWM, I will store both values in R28 (low) and R29 (high). It will also store the time percentage in R27 (only 3 possible values (1==25%, 2==50%, 3==75%)). In addition, I will try to set an example of a high speed signal with a 50 MHz clock. For it, the sequence should be:				<br />
1)	XIN 0x0a, &R26, 16														<br />
2)	MOV R30, R26															<br />
3)	NOP																<br />
4)	SET R30.t13															<br />
5)	Check R31															<br />
6)	MOV R30, R27															<br />
7)	NOP																<br />
8)	SET R30.t13															<br />
9)	NOP																<br />
10)	MOV R30, R28															<br />
11)	NOP																<br />
12)	SET R30.t13															<br />
13)	NOP																<br />
14)	MOV R30, R29															<br />
15)	NOP																<br />
16)	SET R30.t13															<br />
17)	XIN 0x0b, &R26, 16														<br />
18)	MOV R30, R26															<br />
19)	NOP																<br />
20)	SET R30.t13															<br />
21)	NOP																<br />
22)	MOV R30, R27															<br />
23)	NOP																<br />
24)	SET R30.t13															<br />
25)	NOP																<br />
26)	MOV R30, R28															<br />
27)	NOP																<br />
28)	SET R30.t13															<br />
28)	NOP																<br />
29)	MOV R30, R29															<br />
30)	NOP																<br />
31)	SET R30.t13															<br />
32)	XIN 0x0c, &R26, 16														<br />
33)	MOV R30, R26															<br />
34)	NOP																<br />
35)	SET R30.t13															<br />
36)	NOP																<br />
37)	MOV R30, R27															<br />
38)	NOP																<br />
39)	SET R30.t13															<br />
40)	NOP																<br />
41)	MOV R30, R28															<br />
42)	NOP																<br />
43)	SET R30.t13															<br />
44)	NOP																<br />
45)	MOV R30, R29															<br />
46)	NOP																<br />
47)	SET R30.t13															<br />
48)	XIN 0x0a, &R26, 16														<br />
49)	MOV R30, R26															<br />
50)	JMP 4)																<br />
<br />
For Valor fijo, I will store the value passed as a parameter in R30.									<br />
For Pulso, I will store the value passed as a parameter in R30 and we will call Valor fijo with 0x0000 as parameter.			<br />

For option R, I will specify the number of bytes to read and, when finished reading them. It will wait until 6 ms have passed in order to read them again.																			<br />

# 8 cycles
R10 for beginning of the SRAM, R11 for number of bytes to read and R12 as counter.							<br />
The sequence should be the next one:													<br />
1, 2, y 3)	Read 4 bytes														<br />
4)		NOP															<br />
5)		Add 4 to counter													<br />
6)		Check R31														<br />
7)		Set R30.t13														<br />
8)		QBEQ contador, cantidad													<br />
9, 10 y 11)	Read 4 bytes														<br />
12)		NOP															<br />
13)		Add 4 to counter													<br />
14)		QBEQ contador, cantidad													<br />
15)		Set R30.t13														<br />
16)		JMP 1)															<br />
<br />
If condition in 8 is met:														<br />
9, 10 y 11)	Read 4 bytes from beginning												<br />
12)		Counter = 8														<br />
13)		JMP 15)															<br />
<br />
If condition in 14 is met:														<br />
15)		Set R30.t13														<br />
16)		Counter = 4														<br />
1, 2 y 3)	Read 4 bytes														<br />
4)		JMP 5)															<br />	



# 7 cycles
R10 for beginning of the SRAM, R11 for number of bytes to read and R12 as counter.							<br />
The sequence should be the next one:													<br />
1, 2, y 3)	Read 4 bytes														<br />
4)		Add 4 to counter													<br />
5)		Check R31														<br />
6)		Set R30.t8														<br />
7)		QBEQ contador, cantidad													<br />
8, 9 y 10)	Read 4 bytes														<br />
11)		Add 4 to counter													<br />
12)		QBEQ															<br />
13)		Set R30.t8														<br />
14)		JMP 1)															<br />
<br />
If condition in 7 is met:														<br />
8, 9 y 10)	Read 4 bytes from beginning												<br />
11)		Counter = 8														<br />
12)		JMP 13)															<br />
<br />
If condition in 12 is met:														<br />
13)		Set R30.t8														<br />
14)		Counter = 4														<br />
1, 2 y 3)	Read 4 bytes														<br />
4)		Add 4 to counter													<br />
5)		JMP 6)															<br />



# 6 cycles
The order of signal values should be: second, first, third, fourth, ...
It can also be accomplished using only 6 cycles. For it the order should be:								<br />
<br />
1, 2, 3 y 4)	Read 8 bytes from SRAM (R29 and R30)											<br />
5)		Add 1<<13 to R30														<br />
6)		Add 8 bytes to counter (R13)												<br />
7)		Check R31														<br />
8)		MOV R29 to R30														<br />
9)		Jump if 0 bytes left to read (compare with number of bytes to be read (R11))						<br />
10)		Jump if 4 bytes left to read (compare with R11 - 4 (R12))								<br />
11)		Add 1<<13 to R30														<br />
12)		Jump to 1)														<br />
<br /><br />
If condition in 9) meets:														<br />
10b)		Reset the count														<br />
11b)		Add 1<<13 to R30														<br />
12b)		Jump to 1)														<br />
<br /><br />
If condition in 10) meets:														<br />
10d)		NOP															<br />
11d)		Add 1<<13 to R30														<br />
1c, 2c y 3c)	Read 4 bytes from SRAM													<br />
4c)		Reset the count														<br />
5c)		Add 1<<13 to R30														<br />
<br />
Segunda ronda:																<br />
6c)		Add 4 bytes to contador													<br />
7c, 8c y 9c)	Read 4 bytes from SRAM													<br />
10c)		Check R31														<br />
11c)		Add 1<<13 to R30														<br />
12c)		Jump to 1)														<br />


# 5 cycles
NOT WORKING (Reading 8 bytes requires 4 cycle, not 3).											<br />
R9 for SRAM address (0x0001_0000), R10 for bytes to get, R11 for bytes to get - 4 and R12 for count of bytes taken			<br />
<br /><br />
For 5 cycles it could be (THE SIGNAL NEEDS AT LEAST 3 (12 bytes) SAMPLES):
<br />
1, 2, y 3)	Read 8 bytes from SRAM (R29 and R30)											<br />
4)		Add 1<<13 to R30														<br />
5)		Add 8 bytes to counter (R12)												<br />
6)		Jump if 4 bytes or less left to read (compare with R11 - 4)								<br />
7)		MOV R29 to R30														<br />
8)		Check R31														<br />
9)		Add 1<<13 to R30														<br />
10)		Jump to 1)														<br />
<br /><br />
If condition in 6) meets:														<br />
<br />
7b)		MOV R29 to R30														<br />
8b)		Jump if 4 bytes left to read												<br />
9b)		Add 1<<13 to R30														<br />
10b)		Resets counter														<br />
1, 2, y 3)	Read 8 bytes from SRAM (R29 and R30)											<br />
4)		Add 1<<13 to R30														<br />
5)		Add 8 bytes to counter (R12)												<br />
6)		Jump if 4 bytes or less left to read (compare with R11 - 4)								<br />
7)		MOV R29 to R30														<br />
8)		Check R31														<br />
9)		Add 1<<13 to R30														<br />
10)		Jump to 1)														<br />
<br /><br />
If condition in 8b) meets:														<br />
<br />
9c)		Add 1<<13 to R30														<br />
10c)		Check R31														<br />
1, 2, y 3)	Read 4 bytes from SRAM (R30)												<br />
4)		Add 1<<13 to R30														<br />
5)		Reset counter														<br />
1, 2, y 3)	Read 8 bytes from SRAM (R29 and R30)											<br />
4)		Add 1<<13 to R30														<br />
5)		Add 8 bytes to counter (R12)												<br />
6)		Jump if 4 bytes or less left to read (compare with R11 - 4)								<br />
7)		MOV R29 to R30														<br />
8)		Check R31														<br />
9)		Add 1<<13 to R30														<br />
10)		Jump to 1)														<br />
