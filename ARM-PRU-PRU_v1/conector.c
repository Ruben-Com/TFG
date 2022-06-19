#include <stdio.h>
#include <stdlib.h>

void main()
{
  int opcion=0, parametro=0;
  char valores[50], respuesta[20], codigo;
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
    }while(opcion<1 || opcion>9)

    file = fopen("/dev/rpmsg_pru30","w");

    if(file == NULL)
    {
      printf("Error!");   
      exit(1);             
    }
 
    switch(opcion){
    	case 1:
		codigo="D";
		printf("Introduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%d", &parametro);
		if(parametro < 1 || parametro > 3)
			parametro=1;
		strcpy(valores, "");
		break;    
    	case 2:
		codigo="S";
		printf("Introduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%d", &parametro);
		if(parametro < 1 || parametro > 3)
			parametro=1;
		strcpy(valores, "");
		break;    
    	case 3:
		codigo="T";
		printf("Introduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%d", &parametro);
		if(parametro < 1 || parametro > 3)
			parametro=1;
		strcpy(valores, "");
		break;    
    	case 4:
		codigo="W";
		printf("Introduzca una velocidad (1 (mas rapida), 2 o 3 (mas lenta)):\n\n");
    		scanf("%d", &parametro);
		if(parametro < 1 || parametro > 3)
			parametro=1;
		strcpy(valores, "");
		break;    
    	case 5:
		codigo="F";
		printf("Introduzca un valor:\n\n");
    		scanf("%d", &parametro);
		if(parametro < 0 || parametro > 255)
			parametro=127;
		strcpy(valores, "");
		break;    
    	case 6:
		codigo="P";
		printf("Introduzca un valor:\n\n");
    		scanf("%d", &parametro);
		if(parametro < 0 || parametro > 255)
			parametro=127;
		strcpy(valores, "");
		break;    
    	case 7:
		codigo="C";
		parametro=-1;
		break;    
    	case 8:
		codigo="I";
		parametro=-1;
		strcpy(valores, "");
		break;    
    	case 9:
		codigo="H";
		parametro=-1;
		strcpy(valores, "");
		break;    
    }
    fprintf(file,"%c", codigo);
    if(parametro!=-1)
	    fprintf(file, "%d", parametro);
    if(strcmp(valores, "")!=0)
	    fprintf(file, "%s", valores);
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
