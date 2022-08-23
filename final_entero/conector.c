#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void clear(void);

void main()
{
  int opcion=0, parametro=0, i=0;
  char valores[50], respuesta[20], codigo[1000];
  FILE *file;
  do{
    do{
    	printf("\n\nSeleccione una opcion:\n"
		"\t1) Diente de sierra\n" 
		"\t2) Senoidal\n" 
		"\t3) Triangular\n" 
		"\t4) PWM\n" 
		"\t5) Valor fijo\n" 
		"\t6) Pulso de radiación\n" 
		"\t7) Interrumpir senal\n" 
		"\t8) Apagar PRUs y terminar el programa\n\n");
    	scanf("%d", &opcion);
	clear();
    }while(opcion<1 || opcion>8);

    switch(opcion){
    	case 1:
		strcpy(codigo, "D");
		printf("\n\nIntroduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%c", &codigo[1]);
		clear();
		break;    
    	case 2:
		strcpy(codigo, "S");
		printf("\n\nIntroduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%c", &codigo[1]);
		clear();
		break;    
    	case 3:
		strcpy(codigo, "T");
		printf("\n\nIntroduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%c", &codigo[1]);
		clear();
		break;    
    	case 4:
		strcpy(codigo, "W");
		printf("\n\nIntroduzca un valor para tiempo en alto (1 (25%), 2 (50%) o 3 (75%)):\n\n");
    		scanf("%c", &codigo[1]);
		clear();
		break;    
    	case 5:
		strcpy(codigo, "F");
		printf("\n\nIntroduzca un valor entre 0 y 4095:\n\n");
    		scanf("%s", &codigo[1]);
		for(i=1; i<5 && codigo[i]!='\n'; i++){
		  if(codigo[i]=='\n')
			codigo[i]="";
		}
		clear();
		break;    
    	case 6:
		strcpy(codigo, "R");
		break;    
    	case 7:
		strcpy(codigo, "I");
		break;    
    	case 8:
		strcpy(codigo, "H");
		break;    
    }

    file = fopen("/dev/rpmsg_pru30","w");
    if(file == NULL)
    {
      printf("Error! Archivo rpmsg_pru30 no encontrado.\n");   
      exit(1);             
    }
    fprintf(file,"%s", codigo);
    fclose(file);

    if ((file = fopen("/dev/rpmsg_pru30","r")) == NULL){
      printf("Error! Archivo rpmsg_pru30 no encontrado.\n");

       exit(1);
    }

    fscanf(file,"%s", &respuesta);

    printf("\n%s\n\n\n", respuesta);
    fclose(file);

  }while(opcion!=9);
}


void clear(void){
  while((getchar()) != '\n');
}
