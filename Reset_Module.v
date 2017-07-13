// `include "reset/timer.v"
`include "timer.v"
`timescale 10ns/1ps

module Reset_Module (CLK, reset, ioTRANSMIT, iAlert, oTRANSMIT, ALERT, oRECEIVE_DETECT, oRECEIVE_BYTE_COUNT,
						PHY_Stop_Attempting_Reset);

//inputs declaration
input wire CLK;
input wire [7:0] ioTRANSMIT;
input wire reset;
input wire [15:0]iAlert;

//outputs declaration
output reg [15:0] ALERT;
output reg PHY_Stop_Attempting_Reset;
output reg [7:0] oRECEIVE_BYTE_COUNT;
output reg [7:0] oRECEIVE_DETECT;
output reg [7:0] oTRANSMIT; //es un registro de la memoria

//variables
wire [9:0] nanos;
reg [15:0] nxt_ALERT;
reg nxt_PHY_Stop_Attempting_Reset;
reg [7:0] nxt_oRECEIVE_BYTE_COUNT;
reg [7:0] nxt_oRECEIVE_DETECT;
reg nxt_timer_Reset;
reg [6:0] nxt_State;
reg [7:0] nxt_oTRANSMIT;
//reg [1:0] transmit_counter;
reg [1:0] nxt_transmit_counter;
wire PHY_reset;
reg [6:0] state;
integer timeLapse = 900; //por decir algo, algun tiempo
reg timer_Reset;

//PHY_reset me dice si hubo un cable reset o un hard reset
assign PHY_reset = iAlert[3];

//instancia del timer, me va a contar ns
timer t1(.CLK(CLK),
			.nanos(nanos),
			.micros(),
			.milis(),
			.segs(),
			.reset(timer_Reset)
);

//machine states
localparam IDLE = 								7'b0000001;
localparam PRL_HR_Wait_for_Hard_Reset_Request = 7'b0000010;
localparam PRL_HR_Construct_Message = 			7'b0000100;
localparam PRL_HR_Success = 					7'b0001000;
localparam PRL_HR_Failure = 					7'b0010000;
localparam PRL_HR_Report = 						7'b0100000;

//reset
always @(posedge CLK) begin
	if (reset) begin
		state <= IDLE; //initial state
		PHY_Stop_Attempting_Reset <= 0;
		oTRANSMIT <= 8'b0;
		ALERT <= 16'b0;
		oRECEIVE_DETECT <= 8'b0;
		oRECEIVE_BYTE_COUNT <= 8'b0;
		timer_Reset <= 1;
		//transmit_counter <= 0;
	end else begin
		state <= nxt_State;
		PHY_Stop_Attempting_Reset <= nxt_PHY_Stop_Attempting_Reset;
		oTRANSMIT <= nxt_oTRANSMIT;
		ALERT <= nxt_ALERT;
		oRECEIVE_DETECT <= nxt_oRECEIVE_DETECT;
		oRECEIVE_BYTE_COUNT <= nxt_oRECEIVE_BYTE_COUNT;
		timer_Reset <= nxt_timer_Reset;
		//transmit_counter <= nxt_transmit_counter;
	end //end else
end //always @(posedge CLK)

//STATE MACHINE
always @ (*) begin
	nxt_State <= state;
	nxt_PHY_Stop_Attempting_Reset <= PHY_Stop_Attempting_Reset;
	nxt_oTRANSMIT <= oTRANSMIT;
	nxt_ALERT <= ALERT;
	nxt_oRECEIVE_DETECT <= oRECEIVE_DETECT;
	nxt_oRECEIVE_BYTE_COUNT <= oRECEIVE_BYTE_COUNT;

	//nxt_transmit_counter <= transmit_counter;
	nxt_timer_Reset <= timer_Reset;

	case (state)
		//----------FIRST STATE----------
		IDLE: begin
			nxt_State <= PRL_HR_Wait_for_Hard_Reset_Request;
		end //IDLE

		//----------SECOND STATE----------
		PRL_HR_Wait_for_Hard_Reset_Request: begin
			nxt_State <= PRL_HR_Construct_Message;
			timer_Reset <= 1;
		end //PRL_HR_Wait_for_Hard_Reset_Request

		//----------FOURTH STATE----------
		PRL_HR_Construct_Message: begin
			timer_Reset = 0; //Start tHardResetComplete timer
			if (nanos < timeLapse) begin
				if (PHY_reset) begin //Request PHY to send Hard Reset or Cable Reset
					//nxt_transmit_counter <= transmit_counter + 1;
					if (ioTRANSMIT[2:0] == 3'b110) begin
						nxt_oTRANSMIT <= oTRANSMIT | 7'b110; //cable reset
						nxt_oRECEIVE_BYTE_COUNT <= 1;
					end else begin //si no hay cable reset, 100% hubo hard reset
						nxt_oTRANSMIT <= oTRANSMIT | 7'b101; //hard reset
						nxt_oRECEIVE_BYTE_COUNT <= 0;
					end
					nxt_oRECEIVE_DETECT <= 8'b0;
					nxt_State <= PRL_HR_Success;
				end else begin
					nxt_State <= PRL_HR_Construct_Message;
				end
			end else begin
				nxt_State <= PRL_HR_Failure;
			end
		end //PRL_HR_Construct_Message

		//----------EIGHT STATE----------
		PRL_HR_Success: begin
			timer_Reset = 1; //paro el timer
			nxt_State <= PRL_HR_Report;
		end //PRL_HR_Success

		//----------SIXTEENTHSTATE----------
		PRL_HR_Failure: begin
			//timer_Reset = 1; //paro el timer
			nxt_State <= PRL_HR_Report;
			PHY_Stop_Attempting_Reset <= 1;
		end //PRL_HR_Failure

		//----------THIRTYTWOTH STATE----------
		PRL_HR_Report: begin
			if (nanos == 0) begin //si el timer esta en 0 hubo exito
				nxt_ALERT <= 16'b1000000; //ALERT.TransmitSuccesfu
			end else begin
				nxt_ALERT <= 16'b10000; //ALERT.TransmitSOP*MessageFailed
			end
			nxt_State <= PRL_HR_Wait_for_Hard_Reset_Request;
		end //PRL_HR_Report
	endcase
end //end always @ (*) begin

endmodule
