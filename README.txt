En este entragable se contienen diferentes carpetas que contienen cada módulo que se requería hacer.
Para correr la prueba del reset se creo un Makefile con las instrucciones all, build, run y clean.
En la carpeta Docs se incluye documentación del proyecto, incluyendo la Presentación Final y el 
Reporte Final.
A continuación se presenta la forma de correr la prueba:
	
	OPCION 1
	
	#compila el programa, lo ejecuta, genera el .vcd, abre gtkwave con el archivo cargado y borra
	#los archivos creados
	$ make


	OPCION2

	#solo compila
	$ make build

	#solo corre
	$ make run

	#borra los archivos creados
	$ make clean