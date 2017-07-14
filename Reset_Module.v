//UNIVERSIDAD DE COSTA RICA
//FACULTAD DE INGENIERIA 
//ESCUELA DE INGENIERIA ELECTRICA

//IE0523 - Circuitos Digitales II
//I - 2017

//Proyecto Final:
//Controlador de puerto USB tipo C

//Estudiantes:
//Luis Diego Fernandez, B22492
//Lennon Nunez, B34943
//Bernardo Zúñiga, B27445

//Profesor:
//Enrique Coen Alfaro

//14/07/17

`include "timer.v"
`timescale 10ns/1ps

module Reset_Module (CLK, 
					reset, 
					ioTRANSMIT, 
					iAlert, 
					oTRANSMIT, 
					ALERT, 
					oRECEIVE_DETECT, 
					oRECEIVE_BYTE_COUNT,
					PHY_Stop_Attempting_Reset
);

//inputs declaration
input wire CLK;
input wire [15:0]iAlert; //register from memory
input wire [7:0] ioTRANSMIT; //register from memory
input wire reset; //internal reset

//outputs declaration
output reg [15:0] ALERT; //register from memory
output reg PHY_Stop_Attempting_Reset;
output reg [7:0] oRECEIVE_BYTE_COUNT; //register from memory
output reg [7:0] oRECEIVE_DETECT; //register from memory
output reg [7:0] oTRANSMIT; //register from memory

//variables
wire [9:0] nanos;
reg [15:0] nxt_ALERT;
reg nxt_PHY_Stop_Attempting_Reset;
reg [7:0] nxt_oRECEIVE_BYTE_COUNT;
reg [7:0] nxt_oRECEIVE_DETECT;
reg nxt_timer_Reset;
reg [6:0] nxt_State;
reg [7:0] nxt_oTRANSMIT;
reg [1:0] nxt_transmit_counter;
wire PHY_reset;
reg [6:0] state;
integer timeLapse = 900; //for the counter
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

//machine states declaration
localparam IDLE = 								7'b0000001;
localparam PRL_HR_Wait_for_Hard_Reset_Request = 7'b0000010;
localparam PRL_HR_Construct_Message = 			7'b0000100;
localparam PRL_HR_Success = 					7'b0001000;
localparam PRL_HR_Failure = 					7'b0010000;
localparam PRL_HR_Report = 						7'b0100000;

//reset interno
always @(posedge CLK) begin
	if (reset) begin
		state <= IDLE; //initial state
		PHY_Stop_Attempting_Reset <= 0;
		oTRANSMIT <= 8'b0;
		ALERT <= 16'b0;
		oRECEIVE_DETECT <= 8'b0;
		oRECEIVE_BYTE_COUNT <= 8'b0;
		timer_Reset <= 1;
	end else begin
		state <= nxt_State;
		PHY_Stop_Attempting_Reset <= nxt_PHY_Stop_Attempting_Reset;
		oTRANSMIT <= nxt_oTRANSMIT;
		ALERT <= nxt_ALERT;
		oRECEIVE_DETECT <= nxt_oRECEIVE_DETECT;
		oRECEIVE_BYTE_COUNT <= nxt_oRECEIVE_BYTE_COUNT;
		timer_Reset <= nxt_timer_Reset;
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
			nxt_State <= PRL_HR_Report;
			PHY_Stop_Attempting_Reset <= 1;
		end //PRL_HR_Failure

		//----------THIRTYTWOTH STATE----------
		PRL_HR_Report: begin
			if (nanos == 0) begin //si el timer esta en 0 hubo exito
				nxt_ALERT <= 16'b1000000; //ALERT.TransmitSuccesful
			end else begin
				nxt_ALERT <= 16'b10000; //ALERT.TransmitSOP*MessageFailed
			end
			nxt_State <= PRL_HR_Wait_for_Hard_Reset_Request;
		end //PRL_HR_Report
	endcase
end //end always @ (*) begin

endmodule