`timescale 10ns/1ps

module probador_Reset (CLK, iSDA, SCL, Reset, Request);

    output reg CLK, iSDA, SCL, Reset, Request;

    // Configuracion del reloj
		initial begin
		    CLK = 0;
        SCL = 1;
        Reset = 1;
        Request = 0;
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
        #20 //Ciclos en espera para revisar que la Máquina del Reset esté en espera
  /***************************************/
        //Prueba Write
        //ID bueno
        #129
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
        Request <= 1; //Inhabilita acceso a registros
        //Dirección ALERT (10h)
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
        iSDA <= 1;
        #249
        iSDA <= 0;
        #249
        iSDA <= 1;
        #249
        iSDA <= 1;
        //Soltar la línea SDA
        #70
        Request <= 0; //Habilita acceso a registros porque se va a escribir
        iSDA <= 1;
        #249
        Request <= 1; //Inhabilita acceso a registros
        #249 $finish;
    end

endmodule
