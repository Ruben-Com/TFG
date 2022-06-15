#include <stdio.h>
#include <stdlib.h>

void main()
{
  char opcion[20], respuesta[20];
  FILE *file;
  while(1){

    printf("Introduzca una opción (R o L):\n");
    scanf("%s",&opcion);

    // use appropriate location if you are using MacOS or Linux
    file = fopen("/dev/rpmsg_pru30","w");

    if(file == NULL)
    {
      printf("Error!");   
      exit(1);             
    }
 
    fprintf(file,"%c", opcion[0]);
    fclose(file);

    if ((file = fopen("/dev/rpmsg_pru30","r")) == NULL){
      printf("Error! opening file");

       // Program exits if the file pointer returns NULL.
       exit(1);
    }

    fscanf(file,"%s", &respuesta);

    printf("\n%s\n\n\n", respuesta);
    fclose(file);

  }
}
