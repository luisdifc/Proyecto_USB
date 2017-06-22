`include "I2C_Module.v"
`include "probador_I2C.v"
`timescale 1ns/1ps

module test_bench ();

  wire wCLK, wiSDA, wOSDA, wSCL;

  I2C_Module i2c (
  	.SCL(wSCL),
  	.CLK(wCLK),
  	.iSDA(wiSDA),
  	.oSDA(woSDA)
  );

  probador_I2C probador (
    .CLK(wCLK),
    .iSDA(wiSDA),
    .SCL(wSCL)
  );

	initial
	    begin
		    $dumpfile("I2C.vcd");
			$dumpvars;
		end

endmodule
