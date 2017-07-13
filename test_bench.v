`include "I2C/I2C_Module.v"
`include "Probadores/probador_Tx.v"
`include "Registers_Module.v"
`timescale 1ns/1ps

module test_bench ();

  wire wCLK, wiSDA, wOSDA, wSCL, wReset, wRNW, wGoodCRC, wReq;
  wire [15:0] wRD_DATA, wWR_DATA;
  wire [7:0] wADD;

  I2C_Module i2c (
  	.SCL(wSCL),
  	.CLK(wCLK),
  	.iSDA(wiSDA),
  	.oSDA(woSDA),
    .Reset(wReset),
    .RD_DATA(wRD_DATA),
  	.WR_DATA(wWR_DATA),
  	.ADDR(wADD),
  	.RNW(wRNW),
  	.goodCRC(wGoodCRC),
  	.req(wReq)
  );

  probador_TX probador (
    .CLK(wCLK),
    .iSDA(wiSDA),
    .SCL(wSCL),
    .Reset(wReset)
  );

  Registros MiRegistro (
    .CLK(wCLK),
    .ADDR(wADD),
    .RNW(wRNW),
    .reset(wReset),
    .WR_DATA(wWR_DATA),
    .RD_DATA(wRD_DATA),
    .req(wReq)
  );

	initial
	    begin
		    $dumpfile("I2C.vcd");
			$dumpvars;
		end

endmodule
