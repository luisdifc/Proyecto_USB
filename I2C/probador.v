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
    //Reset
        #2
        Reset <= 0;
        iSDA <= 1;
        //START
        #98
        iSDA <= 0;
  /***************************************/
        //Prueba Write
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
        //Dirección R_TRANSMIT (50h)
        #149
        iSDA <= 0;
        #249
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
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        //Soltar la línea SDA
        #70
        iSDA <= 1;
        //Dato a escribir (1) en R_TRANSMIT
        #149
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #149
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        //Soltar la línea SDA
        #70
        iSDA <= 1;
        #249 $finish;
    end

endmodule
