# BeagleBone-Black
In this repository I will upload some working examples using the PRU modules in the BeagleBone Black.

ASM                  &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;        -> &ensp; Loads a program that uses a function in PRU assembly language                                  <br />
C		                 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;	 -> &ensp; Loads a program using only C language                                                          <br />
rpmsg_ARM-PRU_1_mess &ensp;                                                              -> &ensp; Uses 1 PRU to receive messages and send them back only once whenever they are received         <br />
rpmsg_both_PRU	     &emsp;&emsp;&emsp;&emsp;	                                           -> &ensp; Both PRU are available for receiving messages and sending them back only once (not working)    <br />
ex_ARM-PRU-PRU	     &emsp;&emsp;&emsp;&ensp;	                                           -> &ensp; One PRU listens to the commands sent by the ARM and sends values to the other PRU              <br />
xin-xout	           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;	                   -> &ensp; Tries to send values from one PRU to another using XIN and XOUT commands         <br />
ARM-PRU-PRU_v1	           &ensp;&emsp;&emsp;&emsp;	                   -> &ensp; The program connect gives a friendly UI through which signals can be selected/sent to PRU0 and it will communicate with PRU1 so it displays them         <br />
