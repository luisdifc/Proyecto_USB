`timescale 10ns/1ps

module probador_I2C (CLK, iSDA, SCL, Reset);

    output reg CLK, iSDA, SCL, Reset;

    // Configuracion del reloj
		initial begin
		CLK = 1;
        SCL = 1;
        Reset = 1;
		end

		always begin
				#1 CLK = ~CLK;
		end

    always begin
        #125 SCL = ~SCL;
    end

    initial begin
    //Prueba Read y ID
        #2
        Reset <= 0;
        iSDA <= 1;
        //START
        #98
        iSDA <= 0;
        //ID malo
        #149
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        //Soltar la línea SDA
        #75
        iSDA <= 1;
        #249
        //START
        iSDA <= 0;
        //ID bueno
        #149
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 1;//READ
        //Soltar la línea SDA
        #75
        iSDA <= 1;
        //Registro primer byte
        #149
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        //Soltar la línea SDA
        #75
        iSDA <= 1;
		//Registro segundo byte
        #149
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        //Soltar la línea SDA
        #75
        iSDA <= 1;
        //Esperando a recibir dato solicitado
        #1892  //8 ciclos
        //Soltar la línea SDA
        #75
        iSDA <= 1;
  /***************************************/
        //Prueba Write
        #100
        //START
        iSDA <= 0;
        //ID bueno
        #149
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;//WRITE
        //Soltar la línea SDA
        #75
        iSDA <= 1;
        //Registro
        #149
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        //Soltar la línea SDA
        #70
        iSDA <= 1;
        //Dato a escribir
        #149
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249 $finish;
    end

endmodule
