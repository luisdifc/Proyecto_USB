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
        #2
        Reset <= 0;
        iSDA <= 1;
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
        #249
        iSDA <= 0;
        //No tocar SDA
        #249
        #249
        #249 $finish;
    end

endmodule
