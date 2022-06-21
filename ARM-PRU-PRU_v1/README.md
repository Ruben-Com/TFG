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
#	Personalizado largo	   (L)			POSIBLE NO IMPLEMENTACION
	Interrumpir señal	   (I)									0xFF00
	Apagar PRU		   (H)									0x00FF


For PRU communication, I will use the first 4 bytes of SRAM (starting at 0x0001_0000). The 2 less significant bytes contain the number of bytes that will be stored in SRAM. If this value is 0x0000, the PRU will check for the 2 most significant bytes (they contain the code for the signal/action). If their [2 MS bytes] value is 0x00FF it will stop the current signal and if it is 0xFF00 it will turn off the PRU. There will also exist the posibility of the value being 0x0001 (PWM), 0x0002 (Valor fijo) and 0x0003 (Pulso). 
For PWM, RELLENAR.
For Valor fijo, we will store the value passed as a parameter in R30.
For Pulso, we will store the value passed as a parameter in R30 and we will call Valor fijo with 0x0000 as parameter.

The representation of the signals will use 7 PRU cycles. The first one will add 4 bytes to R12 (keeps count of bytes loaded from SRAM + 4 (initial number of bytes)). The second one checks if R12 has reached the number of samples + 4 to show (stored in R11). The third one gets the value to represent from SRAM (3 cycles). The fourth one resets the counter of bytes represented if the limit has been reached or checks if there has been an interrumption from PRU0 if it hasn't reached the limit. If so, it will jump back to main. The last one adds 1<<16 to R30 so the clock signal is high.
