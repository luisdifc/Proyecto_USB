`timescale 1ns/1ps

module probador_I2C (CLK, iSDA, SCL);

    output reg CLK, iSDA, SCL;

    // Configuracion del reloj
		initial begin
				CLK = 0;
		end

		always begin
				#5 CLK = ~CLK;
		end

    initial begin

        SCL <= 1;
        iSDA <= 1;
        #30
        iSDA <= 0;
        SCL <= 0;
        //ID malo
        #30
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        //No tocar SDA
        #20
        SCL <= 1;
        #20
        SCL <= 0;
        //ID bueno
        #30
        SCL <= 1;
        iSDA <= 0;
        #20
        SCL <= 0;
        iSDA <= 0;
        #20
        SCL <= 1;
        iSDA <= 0;
        #20
        SCL <= 0;
        iSDA <= 0;
        #20
        SCL <= 1;
        iSDA <= 0;
        #20
        SCL <= 0;
        iSDA <= 0;
        #20
        SCL <= 1;
        iSDA <= 0;
        #20
        SCL <= 0;
        iSDA <= 0;
        #20
        SCL <= 1;
        iSDA <= 0;
        #20
        SCL <= 0;
        iSDA <= 0;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        #20
        SCL <= 1;
        iSDA <= 0;
        #20
        SCL <= 0;
        iSDA <= 0;
        #20
        SCL <= 1;
        iSDA <= 1;
        #20
        SCL <= 0;
        iSDA <= 1;
        //No tocar SDA
        #20
        SCL <= 1;
        #20
        SCL <= 0;
        #90 $finish;
    end

endmodule
