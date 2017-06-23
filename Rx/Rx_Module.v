module Rx_Module (CLK, reset, Start, iRX_BUF_FRAME_TYPE, iALERT, iRECEIVE_DETECT, iRECEIVE_BYTE_COUNT, 
					Tx_State_Machine_ACTIVE, Unexpected_GoodCRC, CC_Busy, CC_IDLE, Data_In, oALERT, 
					oRECEIVE_BYTE_COUNT, oGoodCRC_to_PHY, oDIR_WRITE, oDATA_to_Buffer);

//inputs declaration
input wire CC_Busy, CC_IDLE;
input wire CLK;
input wire [7:0] Data_In;
input wire [15:0] iALERT; //B3 Hard Reset 
input wire [7:0] iRECEIVE_BYTE_COUNT;
input wire [7:0] iRECEIVE_DETECT;
input wire [7:0] iRX_BUF_FRAME_TYPE; //B2..0   110b: Received Cable Reset
input wire reset;
input wire Start;
input wire Tx_State_Machine_ACTIVE;
input wire Unexpected_GoodCRC;

//outputs declaration
output reg [15:0] oALERT;
output reg [7:0] oDATA_to_Buffer;
output reg [7:0] oDIR_WRITE;
output reg oGoodCRC_to_PHY;
output reg [7:0] oRECEIVE_BYTE_COUNT;

//variables
reg [15:0] nxt_oALERT;
reg [7:0] nxt_oDATA_to_Buffer;
reg [7:0] nxt_oDIR_WRITE;
reg nxt_oGoodCRC_to_PHY;
reg [7:0] nxt_oRECEIVE_BYTE_COUNT;
reg [5:0] nxt_State;
wire PHY_Reset;
reg [5:0] state;

assign PHY_Reset = (iRX_BUF_FRAME_TYPE[2:0] == 3'b110) || (iALERT[3] == 1);

//macchine states
localparam IDLE = 6'b000001;
localparam PRL_Rx_Wait_for_PHY_message = 6'b000010;
localparam PRL_Rx_Message_Discard = 6'b000100;
localparam PRL_RX_Send_GoodCRC = 6'b001000;
localparam PRL_RX_Report_SOP = 6'b010000;
 
parameter max_iRECEIVE_BYTE_COUNT = 31; 
		

//reset 
always @(posedge CLK) begin 
	if (~reset) begin
		state <= IDLE; //initial state
		oDIR_WRITE <= 8'b0;
		oALERT <= 16'b0;
		oRECEIVE_BYTE_COUNT <= 0;
		oGoodCRC_to_PHY <= 0;
		oDATA_to_Buffer <= 8'b0;
	end else begin
		state <= nxt_State;
		oDIR_WRITE <= nxt_oDIR_WRITE;
		oALERT <= nxt_oALERT;
		oRECEIVE_BYTE_COUNT <= nxt_oRECEIVE_BYTE_COUNT;
		oGoodCRC_to_PHY <= nxt_oGoodCRC_to_PHY;
		oDATA_to_Buffer <= nxt_oDATA_to_Buffer;
	end //end else
end //always @(posedge CLK)


//STATE MACHINE
always @ (*) begin
	nxt_State <= state;
	nxt_oGoodCRC_to_PHY <= oGoodCRC_to_PHY;
	nxt_oDIR_WRITE <= oDIR_WRITE;
	nxt_oALERT <= oALERT;
	nxt_oRECEIVE_BYTE_COUNT <= oRECEIVE_BYTE_COUNT;
	nxt_oGoodCRC_to_PHY <= oGoodCRC_to_PHY;
	nxt_oDATA_to_Buffer <= oDATA_to_Buffer;

	case (state)
		//----------FIRST STATE----------
		IDLE: begin
			//logica de proximo estado
			if (!PHY_Reset && !Start) begin //solo en caso de recibir un hard/cable reset o start se pasa de estado
				nxt_State <= IDLE; 
			end else begin
				nxt_State <= PRL_Rx_Wait_for_PHY_message;
			end
		end //IDLE

		//----------SECOND STATE----------
		PRL_Rx_Wait_for_PHY_message: begin
			//logica de proximo estado
			if (iALERT[10]) begin //si hay buffer overflow, osea el buffer esta lleno
				nxt_State <= PRL_Rx_Wait_for_PHY_message; //esperamo a que el buffer se desocupe
			end else begin
				if (iRECEIVE_DETECT & 8'b1) begin //se detecta que hay un mensaje o un dato 
					nxt_State <= PRL_Rx_Message_Discard;
				end else begin
					nxt_State <= IDLE; //si no recibe mensaje entonces se va a IDLE
				end
			end
		end //PRL_Rx_Wait_for_PHY_message

		//----------FOURTH STATE----------
		PRL_Rx_Message_Discard: begin
			//logica de salida
			if (Tx_State_Machine_ACTIVE) begin //si la maquina de Tx esta activa se descarta el mensaje
				nxt_oALERT <= oALERT | 16'b100000; //bandera que indica que se descato el mensaje ALERT B5
				nxt_oRECEIVE_BYTE_COUNT <= 0; //se pone el BYTE_COUNT en 0 xq se descarto el mensaje
			end else begin
				nxt_oALERT <= oALERT;
			end

			//logica de proximo estado
			if (Unexpected_GoodCRC) begin //dependiendo del CRC se pasa al repor o a enviar un GoodCRC
				nxt_State <= PRL_RX_Report_SOP;
			end else begin
				nxt_State <= PRL_RX_Send_GoodCRC;
			end
		end //PRL_Rx_Message_Discard

		//----------EIGTH STATE----------
		PRL_RX_Send_GoodCRC: begin
			//logica de salida
			nxt_oGoodCRC_to_PHY <= 1; //se notifica al PHY que hubo un goodCRC

			//logica de proximo estado
			//si el CC esta ocupado o en IDLE se va a WAIT
			//si el Tx esta acitca se va a wait xq se descarto el mensaje
			if (CC_Busy || CC_IDLE || Tx_State_Machine_ACTIVE) begin
				nxt_State <= PRL_Rx_Wait_for_PHY_message;	
			end else begin //means goodCRC transmission complete
				nxt_State <= PRL_RX_Report_SOP;	
			end
		end //PRL_RX_Send_GoodCRC

		//----------SIXTEENTH STATE----------
		PRL_RX_Report_SOP: begin
			//logica de salida
			//update RECEIVE BUFFER
			nxt_oDATA_to_Buffer <= Data_In; //se copia el dato que va a ser transmitido a la salida

			//se calcula la direccion en el Rx_BUFFER donde se va a guardar el mensaje
			//a partir del BYTE_COUNT
			nxt_oDIR_WRITE <= iRECEIVE_BYTE_COUNT + 8'h31; //en h31 empieza el frame_type

			nxt_oRECEIVE_BYTE_COUNT <= iRECEIVE_BYTE_COUNT + 1; //se notifica que el BUFFER tiene 1 byte mas

			//BYTE_COUNT (1 Byte Frame, 2 Bytes Header, 28 Bytes Datos)
			if (oRECEIVE_BYTE_COUNT == 31) begin //si el BYTE_COUNT llega a 31, el Rx_BUFFER esta lleno
				nxt_oALERT <= oALERT | 16'b10000000000; //bandera de Overflow
			end else begin
				nxt_oALERT <= oALERT & 16'b1111101111111111; //se asegura que la bandera de overflow este en 0
			end

			nxt_oALERT <= oALERT | 16'b000100; //se notifica que el Rx_BUFFER cambio

			//logica de proximo estado
			nxt_State <= PRL_Rx_Wait_for_PHY_message;
		end //PRL_RX_Report_SOP

	endcase 	
end //end always @ (*) begin

endmodule