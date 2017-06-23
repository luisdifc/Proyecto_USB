`include "reloj.v"

module probador_reset(CLK, reset, ioTRANSMIT, PHY_ACK, oTRANSMIT, ALERT, oRECEIVE_DETECT, oRECEIVE_BYTE_COUNT, 
						PHY_Stop_Attempting_Reset);
	//inputs
	input wire [7:0] oTRANSMIT; //es un registro de la memoria
	input wire [15:0] ALERT;
	input wire [7:0] oRECEIVE_DETECT;
	input wire [7:0] oRECEIVE_BYTE_COUNT;
	input wire PHY_Stop_Attempting_Reset;

	//clock
	//wire CLK;
	output wire CLK;

	//outputs
	output reg reset; 
	output reg PHY_ACK;
	output reg [7:0] ioTRANSMIT;


	relojito c1(CLK); //instancia del relojito

	initial begin
		$dumpfile("reset_output.vcd"); //genera el archivo .vcd
	  	$dumpvars;

		reset = 0; //reset puesto
		ioTRANSMIT = 8'b0;

		#2 reset = 1;
		
		#20 ioTRANSMIT[2:0] = 3'b110;

		#10 $finish;
	end
endmodule