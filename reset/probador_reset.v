`include "reloj.v"

module probador_reset(CLK, reset, cableReset, hardReset, TRANSMIT, ALERT, RECEIVE_DETECT, RECEIVE_BYTE_COUNT, PHY_Stop_Attempting_Reset);
	//inputs
	input wire [7:0] TRANSMIT; //es un registro de la memoria
	input wire [15:0] ALERT;
	input wire [7:0] RECEIVE_DETECT;
	input wire [7:0] RECEIVE_BYTE_COUNT;
	input wire PHY_Stop_Attempting_Reset;

	//clock
	//wire CLK;
	output wire CLK;

	//outputs
	output reg reset; 
	output reg cableReset;
	output reg hardReset;

	relojito c1(CLK); //instancia del relojito

	initial begin
		$dumpfile("reset_output.vcd"); //genera el archivo .vcd
	  	$dumpvars;

		reset = 1; //reset puesto
		cableReset = 0; 
		hardReset = 0; 

		#2 reset = 0;
		
		#20 cableReset <= 1;

		#10 $finish;
	end
endmodule