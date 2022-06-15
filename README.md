# BeagleBone-Black
In this repository I will upload some working examples using the PRU modules in th BeagleBone Black.

ASM                  &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&ensp;        -> &ensp; Loads a program that uses a function in PRU assembly language                                  <br />
C		                 &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;	 -> &ensp; Loads a program using only C language                                                          <br />
rpmsg_ARM-PRU_1_mess &ensp;                                                              -> &ensp; Uses 1 PRU to receive messages and send them back only once whenever they are received         <br />
rpmsg_both_PRU	     &emsp;&emsp;&emsp;&emsp;	                                           -> &ensp; Both PRU are available for receiving messages and sending them back only once (not working)    <br />
ex_ARM-PRU-PRU	     &emsp;&emsp;&emsp;&ensp;	                                           -> &ensp; One PRU listens to the commands sent by the ARM and sends values to the other PRU              <br />
xin-xout	           &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
