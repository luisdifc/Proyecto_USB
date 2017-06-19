module Reset_Module (CLK, reset);
//outputs declaration


//inputs declaration
input wire CLK;
input wire reset;

//variables
reg [1:0] state;
reg [1:0] nxtState;

//macchine states
localparam IDLE = 6'b000001;
localparam PRL_Rx_Wait_for_PHY_message = 6'b000010;
localparam PRL_Rx_Message_Discard = 6'b000100;
localparam PRL_RX_Send_GoodCRC = 6'b001000;
localparam PRL_RX_Report_SOP = 6'b010000;
localparam FATAL = 6'b100000;
		

//reset 
always @(posedge CLK) begin 
	if (reset) begin
		state <= PRL_Rx_Wait_for_PHY_message; //initial state
	end else begin
		state <= nxtState;
	end //end else
end //always @(posedge CLK)


//STATE MACHINE
always @ (*) begin
	nxtState <= state;
	case (state)
		IDLE: begin
			
		end //IDLE

		PRL_Rx_Wait_for_PHY_message: begin
			
		end //PRL_Rx_Wait_for_PHY_message

		PRL_Rx_Message_Discard: begin
			
		end //PRL_Rx_Message_Discard

		PRL_RX_Send_GoodCRC: begin
			
		end //PRL_RX_Send_GoodCRC

		PRL_RX_Report_SOP: begin
			
		end //PRL_RX_Report_SOP

		FATAL: begin
			
		end // FATAL
	endcase 	
end //end always @ (*) begin

endmodule