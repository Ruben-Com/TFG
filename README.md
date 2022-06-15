In this repository I will upload some working examples using the PRU modules in th BeagleBone Black.

ASM			-> Loads a program that uses a function in PRU assembly language
C			-> Loads a program using only C language
rpmsg_ARM-PRU_1_mess	-> Uses 1 PRU to receive messages and send them back only once whenever they are received
rpmsg_both_PRU		-> Both PRU are available for receiving messages and sending them back only once (not working)
ex_ARM-PRU-PRU		-> One PRU listens to the commands sent by the ARM and sends values to the other PRU
xin-xout		-> Tries to send values from one PRU to another using XIN and XOUT commands (not working)