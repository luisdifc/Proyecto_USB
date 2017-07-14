`include "I2C/I2C_Module.v"
`include "Probadores/probador_Reset.v"
`include "Registros/Registers_Module.v"
`include "Reset/Reset_Module.v"
`timescale 1ns/1ps

module test_bench ();

  wire wCLK, wiSDA, wOSDA, wSCL, wReset, wRNW, wGoodCRC, wReq, wMaq_est_req;
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

  probador_Reset probador (
    .CLK(wCLK),
    .iSDA(wiSDA),
    .SCL(wSCL),
    .Reset(wReset),
    .Request(wMaq_est_req)
  );

  Registros MiRegistro (
    .CLK(wCLK),
    .ADDR(wADD),
    .RNW(wRNW),
    .reset(wReset),
    .WR_DATA(wWR_DATA),
    .RD_DATA(wRD_DATA),
    .req(wReq),
    .maq_est_req(wMaq_est_req),
    .ACK(),
    .cc_status(),
    .power_status(),
    .USBproduct_id_i(),
    .bcdDEVICE_i(),
    .alert_i(wAlert),
    .alert_mask_i(),
    .vendor_id_i(),
    .receive_detect_i(rec_Det),
    .receive_byte_count_i(rec_Det_count),
    .transmit_i(trans),
    .transmit_byte_count_i(),
    .ALERT(wAlert_i),
    .TRANSMIT(Wtrans)
  );

  Reset_Module MiReset (
    .CLK(wCLK),
    .reset(wReset),
    .ioTRANSMIT(Wtrans),
    .iAlert(wAlert_i),
    .oTRANSMIT(trans),
    .ALERT(wAlert),
    .oRECEIVE_DETECT(rec_Det),
    .oRECEIVE_BYTE_COUNT(rec_Det_count),
    .PHY_Stop_Attempting_Reset()
  );

  wire [15:0] wAlert;
  wire [15:0] wAlert_i;
  wire [7:0] Wtrans;
  wire [7:0] trans;
  wire [7:0] rec_Det;
  wire [7:0] rec_Det_count;


	initial
	    begin
		    $dumpfile("Reset.vcd");
			$dumpvars;
		end

endmodule
