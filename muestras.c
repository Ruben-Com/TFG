#include <stdio.h>
#include <math.h>

#define pi 3.1415926535

void main(){
	printf("Muestras de seno para velocidad 1:\n\n");
	for(int i=0; i<300; i++){
		printf("0x%x\n", (int)(255*(0.5+(0.5*sin(2*pi*i/300)))));
	}
}
