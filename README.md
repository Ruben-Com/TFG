En primer lugar es necesario comentar las lineas "disable_uboot_video=1" y "disable_uboot_overlay_emmc=1" en el archivo uEnv.txt (necesario hacerlo en una tarjeta microSD) y reiniciar la BeagleBone.
El siguiente paso es instalar el compilador clpru. Tambien se puede instalar para prudebug desde GitHub para comprobar el correcto funcionamiento del trabajo.
Por ultimo, para compilar el proyecto y cargarlo en las PRUs se puede usar el comando "sudo make", para iniciar las PRUs el comando "sudo make start" y para pararlas el comando "sudo make stop".
