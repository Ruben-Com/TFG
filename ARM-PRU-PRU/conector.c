#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void clear(void);

void main()
{
  int opcion=0, parametro=0;
  char valores[50], respuesta[20], codigo[1000];
  FILE *file;
  while(opcion!=9){

    do{
    	printf("\n\nSeleccione una opcion:\n"
		"\t1) Diente de sierra\n" 
		"\t2) Senoidal\n" 
		"\t3) Triangular\n" 
		"\t4) PWM\n" 
		"\t5) Valor fijo\n" 
		"\t6) Pulso\n"
		"\t7) Senal personalizada\n" 
		"\t8) Interrumpir senal\n" 
		"\t9) Apagar PRUs y terminar el programa\n\n");
    	scanf("%d", &opcion);
	clear();
    }while(opcion<1 || opcion>9);

    file = fopen("/dev/rpmsg_pru30","w");

    if(file == NULL)
    {
      printf("Error!");   
      exit(1);             
    }
 
    switch(opcion){
    	case 1:
		strcpy(codigo, "");
		codigo[0]="D";
		printf("\n\nIntroduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%c", codigo[1]);
		if(codigo[1] < "1" || codigo[1] > "3")
			codigo[1]="1";
		//strcpy(valores, "");
		break;    
    	case 2:
		strcpy(codigo, "");
		codigo[0]="S";
		printf("\n\nIntroduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		//scanf("%c", codigo[1]);
		clear();
		//if(codigo[1] < "1" || codigo[1] > "3")
		//	codigo[1]="1";
		//strcpy(valores, "");
		printf("\n\n%s\n\n", codigo);
		break;    
    	case 3:
		strcpy(codigo, "");
		codigo[0]="T";
		printf("\n\nIntroduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%c", &codigo[1]);
		if(codigo[1] < "1" || codigo[1] > "3")
			codigo[1]="1";
		//strcpy(valores, "");
		break;    
    	case 4:
		strcpy(codigo, "");
		codigo[0]="W";
		printf("\n\nIntroduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%c", &codigo[1]);
		if(codigo[1] < "1" || codigo[1] > "3")
			codigo[1]="1";
		//strcpy(valores, "");
		break;    
    	case 5:
		strcpy(codigo, "");
		codigo[0]="F";
		printf("\n\nIntroduzca un valor entre 0 y 255:\n\n");
    		scanf("%c", &codigo[1]);
		if(codigo[1] < "1" || codigo[1] > "3")
			codigo[1]="1";
		//strcpy(valores, "");
		break;    
    	case 6:
		strcpy(codigo, "");
		codigo[0]="P";
		printf("\n\nIntroduzca un valor entre 0 y 255:\n\n");
    		scanf("%s", &codigo[1]);
		if(codigo[1] < "1" || codigo[1] > "3")
			codigo[1]="1";
		//strcpy(valores, "");
		break;    
    	case 7:
		strcpy(codigo, "");
		codigo[0]="C";
    		scanf("%s", &codigo[1]);
		if(codigo[1] < "1" || codigo[1] > "3")
			codigo[1]="1";
		//strcpy(valores, "");
		break;    
    	case 8:
		strcpy(codigo, "");
		codigo[0]="I";
		break;    
    	case 9:
		strcpy(codigo, "");
		codigo[0]="H";
		break;    
    }
    fprintf(file,"%s", codigo);
//    if(parametro!=-1)
//	    fprintf(file, "%d", parametro);
//    if(strcmp(valores, "")!=0)
//	    fprintf(file, "%s", valores);
    fclose(file);

    if ((file = fopen("/dev/rpmsg_pru30","r")) == NULL){
      printf("Error! Archivo rpmsg_pru30 no encontrado.\n");

       exit(1);
    }

    fscanf(file,"%s", &respuesta);

    printf("\n%s\n\n\n", respuesta);
    fclose(file);

  }
}


void clear(void){
  while((getchar()) != '\n');
}
