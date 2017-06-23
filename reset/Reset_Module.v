`include "timer.v"

module Reset_Module (CLK, reset, cableReset, hardReset, TRANSMIT, ALERT, RECEIVE_DETECT, RECEIVE_BYTE_COUNT, PHY_Stop_Attempting_Reset);

//outputs declaration
output reg [7:0] TRANSMIT; //es un registro de la memoria
output reg [15:0] ALERT;
output reg [7:0] RECEIVE_DETECT;
output reg [7:0] RECEIVE_BYTE_COUNT;
output reg PHY_Stop_Attempting_Reset;

//inputs declaration
input wire CLK;
input wire reset;
input wire cableReset, hardReset;

//variables
wire PHY_reset;
reg [6:0] state;
reg [6:0] nxtState;
integer timeLapse = 10; //por decir algo, algun tiempo
wire [9:0] nanos;
reg nxt_PHY_Stop_Attempting_Reset;
reg timer_Reset;
reg nxt_timer_Reset;

assign PHY_reset = cableReset || hardReset;

// //instancia del timer
timer t1(.CLK(CLK),
			.nanos(nanos), 
			.micros(),
			.milis(),
			.segs(),
			.reset(timer_Reset)
);

//macchine states
localparam IDLE = 								7'b0000001;
localparam PRL_HR_Wait_for_Hard_Reset_Request = 7'b0000010;
localparam PRL_HR_Construct_Message = 			7'b0000100;
localparam PRL_HR_Success = 					7'b0001000;
localparam PRL_HR_Failure = 					7'b0010000;
localparam PRL_HR_Report = 						7'b0100000;
localparam FATAL = 								7'b1000000;

//reset 
always @(posedge CLK) begin 
	if (reset) begin
		state <= IDLE; //initial state
		PHY_Stop_Attempting_Reset <= 0;
		timer_Reset <= 1;
	end else begin
		state <= nxtState;
		PHY_Stop_Attempting_Reset <= nxt_PHY_Stop_Attempting_Reset;
		timer_Reset <= nxt_timer_Reset;
	end //end else
end //always @(posedge CLK)

//STATE MACHINE
always @ (*) begin
	nxtState <= state;
	nxt_PHY_Stop_Attempting_Reset <= PHY_Stop_Attempting_Reset;
	nxt_timer_Reset <= timer_Reset;	
	// TRANSMIT = 0; 
	// ALERT = 0;
	// RECEIVE_DETECT = 0;
	// RECEIVE_BYTE_COUNT = 0;

	case (state)
		//----------FIRST STATE----------
		IDLE: begin
			nxtState <= PRL_HR_Wait_for_Hard_Reset_Request;
		end //IDLE

		//----------SECOND STATE----------
		PRL_HR_Wait_for_Hard_Reset_Request: begin
			nxtState <= PRL_HR_Construct_Message;
		end //PRL_HR_Wait_for_Hard_Reset_Request

		//----------FOURTH STATE----------
		PRL_HR_Construct_Message: begin
			timer_Reset = 0; //Start tHardResetComplete timer
			if (nanos < timeLapse) begin
				if (PHY_reset) begin //Request PHY to send Hard Reset or Cable Reset
					if (cableReset) begin
						TRANSMIT = TRANSMIT | 7'b110; //cable reset
						RECEIVE_BYTE_COUNT <= 1;
					end else begin //si no hay cable reset, 100% hubo hard reset
						TRANSMIT = TRANSMIT | 7'b101; //hard reset
						RECEIVE_BYTE_COUNT <= 0;				
					end
					RECEIVE_DETECT <= 8'b0;
					nxtState <= PRL_HR_Success;	
				end else begin
					nxtState <= PRL_HR_Construct_Message;
				end
			end else begin
				nxtState <= PRL_HR_Failure;
			end
		end //PRL_HR_Construct_Message

		//----------EIGHT STATE----------
		PRL_HR_Success: begin
			timer_Reset = 1; //paro el timer 
			nxtState <= PRL_HR_Report;
		end //PRL_HR_Success

		//----------SIXTEENTHSTATE----------
		PRL_HR_Failure: begin
			timer_Reset = 1; //paro el timer 	
			nxtState <= PRL_HR_Report;
			PHY_Stop_Attempting_Reset <= 1;
		end //PRL_HR_Failure

		//----------THIRTYTWOTH STATE----------
		PRL_HR_Report: begin
			if (cableReset || hardReset) begin 
				ALERT <= ALERT | 16'b1000000; //ALERT.TransmitSuccesful 
			end else begin
				ALERT <= ALERT | 16'b10000; //ALERT.TransmitSOP*MessageFailed
			end
			nxtState <= PRL_HR_Wait_for_Hard_Reset_Request;
		end //PRL_HR_Report
	endcase 	
end //end always @ (*) begin

endmodule