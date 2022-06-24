The executable "connector" is the C program used to access the file /dev/rpmsg_30 in order to send and receive messages from PRU0 through a more friendly interface. Using that program, the user will be able to select between different options of signals with some parameters in each one through an interactive menu. The possible signals and possible customizable parameters are:

	Nombre			Abreviacion		Parametros				Codigo en 2 MS bytes
	---------------------------------------------------------------------------------------------------------------

	Diente de sierra	   (D)			[Velocidad=1]
	Senoidal		   (S)			[Velocidad=1]
	Triangular		   (T)			[Velocidad=1]
	PWM			   (W)			[Velocidad=1]					0x0001
	Valor fijo		   (F)			[Valor=0x0F]					0x0002
	Pulso			   (P)			[Valor=0xFF]					0x0003

	Personalizado		   (C)
	Interrumpir señal	   (I)									0xFF00
	Apagar PRU		   (H)									0x00FF


For PRU communication, I will use the first 4 bytes of SRAM (starting at 0x0001_0000). The 2 less significant bytes contain the number of bytes that will be stored in SRAM. If this value is 0x0000, the PRU will check for the 2 most significant bytes (they contain the code for the signal/action). If their [2 MS bytes] value is 0x00FF it will stop the current signal and if it is 0xFF00 it will turn off the PRU. There will also exist the posibility of the value being 0x0001 (PWM), 0x0002 (Valor fijo) and 0x0003 (Pulso). 
For PWM, RELLENAR.
For Valor fijo, we will store the value passed as a parameter in R30.
For Pulso, we will store the value passed as a parameter in R30 and we will call Valor fijo with 0x0000 as parameter.

# 7 cycles
NOT WORKING. The representation of the signals will use 7 PRU cycles. The first one will add 4 bytes to R12 (keeps count of bytes loaded from SRAM + 4 (initial number of bytes)). The second one checks if R12 has reached the number of samples + 4 to show (stored in R11). The third one gets the value to represent from SRAM (3 cycles). The fourth one resets the counter of bytes represented if the limit has been reached or checks if there has been an interrumption from PRU0 if it hasn't reached the limit. If so, it will jump back to main. The last one adds 1<<16 to R30 so the clock signal is high.


# 6 cycles
It can also be accomplished using only 6 cycles. For it the order should be (supposing it needs 3 cycles to read 8 bytes):

1, 2, 3 y 4)	Read 8 bytes from SRAM (R29 and R30)
5)		Add 1<<8 to R30
6)		Add 8 bytes to counter (R12)
7)		Check R31
8)		MOV R29 to R30
9)		Jump if 0 bytes left to read (compare with number of bytes to be read (R11))
10)		Jump if 4 bytes left to read (compare with R11 - 4)
11)		Add 1<<8 to R30
12)		Jump to 1)


If condition in 9) meets:
10)		Reset the count
11)		Add 1<<8to R30
12)		Jump to 1)


If condition in 10) meets:
11)		Add 1<<8 to R30
12)		Jump to 1b)

1b)		NOP
2b, 3b, y 4b)	Read 4 bytes from SRAM
5b)		Add 1<<8 to R30

Segunda ronda:
6b)		Add 4 bytes to contador
7b)		Check R31
8b)		Move R29 to R30
9b)		Jump if 0 bytes left to read (compare with number of bytes to be read (R11))
10b)		NOP
11b)		Add 1<<8 to R30
12b)		Jump to 1)


# 5 cycles
NOT WORKING (Reading 8 bytes requires 4 cycle, not 3). R9 for SRAM address (0x0001_0000), R10 for bytes to get, R11 for bytes to get - 4 and R12 for count of bytes taken
For 5 cycles it could be (THE SIGNAL NEEDS AT LEAST 3 (12 bytes) SAMPLES):

1, 2, y 3)	Read 8 bytes from SRAM (R29 and R30)
4)		Add 1<<8 to R30
5)		Add 8 bytes to counter (R12)
6)		Jump if 4 bytes or less left to read (compare with R11 - 4)
7)		MOV R29 to R30
8)		Check R31
9)		Add 1<<8 to R30
10)		Jump to 1)


If condition in 6) meets:

7b)		MOV R29 to R30
8b)		Jump if 4 bytes left to read
9b)		Add 1<<8 to R30
10b)		Resets counter
1, 2, y 3)	Read 8 bytes from SRAM (R29 and R30)
4)		Add 1<<8 to R30
5)		Add 8 bytes to counter (R12)
6)		Jump if 4 bytes or less left to read (compare with R11 - 4)
7)		MOV R29 to R30
8)		Check R31
9)		Add 1<<8 to R30
10)		Jump to 1)


If condition in 8b) meets:

9c)		Add 1<<8 to R30
10c)		Check R31
1, 2, y 3)	Read 4 bytes from SRAM (R30)
4)		Add 1<<8 to R30
5)		Reset counter
1, 2, y 3)	Read 8 bytes from SRAM (R29 and R30)
4)		Add 1<<8 to R30
5)		Add 8 bytes to counter (R12)
6)		Jump if 4 bytes or less left to read (compare with R11 - 4)
7)		MOV R29 to R30
8)		Check R31
9)		Add 1<<8 to R30
10)		Jump to 1)
