module Rx_Module (CLK, Start, reset, cableReset, hardReset, Byte_Count, Tx_State_Machine_ACTIVE, Unexpected_GoodCRC, 
					CC_Busy, CC_IDLE, ALERT, RECEIVE_BYTE_COUNT, GoodCRC_to_PHY;

//outputs declaration
output reg [15:0] ALERT;
output reg [7:0] RECEIVE_BYTE_COUNT;
output reg GoodCRC_to_PHY;

//inputs declaration
input wire CLK;
input wire Start;
input wire reset;
input wire cableReset, hardReset;
input wire [7:0] Byte_Count;
input wire Tx_State_Machine_ACTIVE;
input wire Unexpected_GoodCRC;
input wire CC_Busy, CC_IDLE;


//variables
reg [5:0] state;
reg [5:0] nxtState;
reg nxt_GoodCRC_to_PHY;
wire PHY_Reset;

assign PHY_Reset = cableReset || hardReset;

//macchine states
localparam IDLE = 6'b000001;
localparam PRL_Rx_Wait_for_PHY_message = 6'b000010;
localparam PRL_Rx_Message_Discard = 6'b000100;
localparam PRL_RX_Send_GoodCRC = 6'b001000;
localparam PRL_RX_Report_SOP = 6'b010000;
localparam FATAL = 6'b100000;
		

//reset 
always @(posedge CLK) begin 
	if (~reset) begin
		state <= IDLE; //initial state
		GoodCRC_to_PHY <= 0;
	end else begin
		state <= nxtState;
	end //end else
end //always @(posedge CLK)


//STATE MACHINE
always @ (*) begin
	nxtState <= state;
	nxt_GoodCRC_to_PHY <= GoodCRC_to_PHY;

	case (state)
		IDLE: begin
			if (!PHY_Reset && !Start) begin
				nxtState <= IDLE;
			end else begin
				nxtState <= PRL_Rx_Wait_for_PHY_message;
			end
		end //IDLE

		PRL_Rx_Wait_for_PHY_message: begin
			if (Byte_Count == 8'b00011100) begin
				nxtState <= PRL_Rx_Wait_for_PHY_message;
			end else begin
				nxtState <= PRL_Rx_Message_Discard;
			end
			
		end //PRL_Rx_Wait_for_PHY_message

		PRL_Rx_Message_Discard: begin
			if (Tx_State_Machine_ACTIVE) begin
				ALERT <= ALERT | 16'b100000;
				RECEIVE_BYTE_COUNT <= 0;
			end else begin
				ALERT <= ALERT | 16'b000000;
			end

			if (Unexpected_GoodCRC) begin
				nxtState <= PRL_RX_Report_SOP;
			end else begin
				nxtState <= PRL_RX_Send_GoodCRC;
			end
		end //PRL_Rx_Message_Discard

		PRL_RX_Send_GoodCRC: begin
			GoodCRC_to_PHY <= 1;

			if (CC_Busy || CC_IDLE) begin
				nxtState <= PRL_Rx_Wait_for_PHY_message;	
			end else begin //measn goodCRC transmission complete
				nxtState <= PRL_RX_Report_SOP;	
			end
		end //PRL_RX_Send_GoodCRC

		PRL_RX_Report_SOP: begin
			ALERT <= ALERT | 16'b000100;

			nxtState <= PRL_Rx_Wait_for_PHY_message;
		end //PRL_RX_Report_SOP

	endcase 	
end //end always @ (*) begin

endmodule