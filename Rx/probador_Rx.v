`include "reloj.v"

module probador_Rx(CLK, reset, Start, iRX_BUF_FRAME_TYPE, iALERT, iRECEIVE_DETECT, iRECEIVE_BYTE_COUNT, Tx_State_Machine_ACTIVE, Unexpected_GoodCRC, 
					CC_Busy, CC_IDLE, Data_In, oALERT, oRECEIVE_BYTE_COUNT, oGoodCRC_to_PHY, oDIR_WRITE, oDATA_to_Buffer);

	//outputs declaration
	input wire [15:0] oALERT;
	input wire [7:0] oDATA_to_Buffer;
	input wire [7:0] oDIR_WRITE;
	input wire [7:0] oRECEIVE_BYTE_COUNT;
	input wire oGoodCRC_to_PHY;

	//inputs declaration
	output wire CLK;
	output reg reset;
	output reg Start;
	output reg [7:0] iRX_BUF_FRAME_TYPE; //B2..0   110b: Received Cable Reset
	output reg [15:0] iALERT; //B3 Hard Reset 
	output reg [7:0] iRECEIVE_DETECT;
	output reg [7:0] iRECEIVE_BYTE_COUNT;
	output reg Tx_State_Machine_ACTIVE;
	output reg Unexpected_GoodCRC;
	output reg CC_Busy, CC_IDLE;
	output reg [7:0] Data_In;

	relojito c1(CLK); //instancia del relojito

	initial begin
		$dumpfile("Rx_output.vcd"); //genera el archivo .vcd
	  	$dumpvars;

		reset = 0; //reset puesto
		Start = 1;
		CC_Busy = 0;
		CC_IDLE = 0;
		Unexpected_GoodCRC = 0;
		Data_In = 8'b10011001;
		Tx_State_Machine_ACTIVE = 0;
		iRX_BUF_FRAME_TYPE = 8'b0;
		iALERT = 16'b00000000000;
		iRECEIVE_DETECT = 8'b1;
		iRECEIVE_BYTE_COUNT = 8'b0101;

		#4 reset = 1;
		

		#20 $finish;
	end
endmodule