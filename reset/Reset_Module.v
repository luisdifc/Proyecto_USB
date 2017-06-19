module Reset_Module (CLK, reset, PHY_Reset, tHardResetCompleteTimer, TRANSMIT, SOPMessage, ALERT);
//outputs declaration
output reg [3:0] TRANSMIT; //es un registro de la memoria
output reg [2:0] SOPMessage;  
output reg [15:0] ALERT;

//inputs declaration
input wire CLK;
input wire reset;
input wire tHardResetCompleteTimer;

//variables
reg [6:0] state;
reg [6:0] nxtState;
int timeLapse = 200; //por decir algo, algun tiempo

//macchine states
localparam IDLE = 7'b0000001;
localparam PRL_HR_Wait_for_Hard_Reset_Request = 7'b0000010;
localparam PRL_HR_Construct_Message = 7'b0000100;
localparam PRL_HR_Success = 7'b0001000;
localparam PRL_HR_Failure = 7'b0010000;
localparam PRL_HR_Report = 7'b0100000;
localparam FATAL = 7'b1000000;

//reset 
always @(posedge CLK) begin 
	if (reset) begin
		state <= IDLE; //initial state
	end else begin
		state <= nxtState;
	end //end else
end //always @(posedge CLK)


//STATE MACHINE
always @ (*) begin
	nxtState = state;
	TRANSMIT = 3'b000;	

	case (state)
		//----------FIRST STATE----------
		IDLE: begin
			nxtState <= PRL_HR_Wait_for_Hard_Reset_Request;
		end //IDLE

		//----------SECOND STATE----------
		PRL_HR_Wait_for_Hard_Reset_Request: begin
			nxtState <= PRL_HR_Construct_Message;
			TRANSMIT <= 4'b0101; // usamos 101 no 110
			tHardResetCompleteTimer <= 0;
		end //PRL_HR_Wait_for_Hard_Reset_Request

		//----------THIRD STATE----------
		PRL_HR_Construct_Message: begin
			if (tHardResetCompleteTimer < timeLapse) begin
				if (PHY_Reset) begin
					SOPMessage <= 3'b110; //hubo cable reset o hard reset
					nxtState <= PRL_HR_Success;
				end else begin
					nxtState <= PRL_HR_Construct_Message;
				end
			end else begin
				nxtState <= PRL_HR_Failure;
			end
		end //PRL_HR_Construct_Message

		//----------FOURTH STATE----------
		PRL_HR_Success: begin
			nxtState <= PRL_HR_Report;
		end //PRL_HR_Success

		PRL_HR_Failure: begin
			
		end //PRL_HR_Failure

		PRL_HR_Report: begin
			ALERT <= ALERT | 16'b1000000; //ALERT.TransmitSuccesful 
			ALERT <= ALERT | 16'b10000; //ALERT.TransmitSOP*MessageFailed
			nxtState <= PRL_HR_Wait_for_Hard_Reset_Request;
		end //PRL_HR_Report

		// FATAL: begin
			
		// end // FATAL
	endcase 	
end //end always @ (*) begin

endmodule