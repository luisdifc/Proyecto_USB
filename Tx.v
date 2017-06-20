module Tx(TRANSMIT, TRANSMIT_BYTE_COUNT, TRANSMIT_HEADER_LOW, TRANSMIT_HEADER_HIGH, TRANSMIT_DATA_OBJECTS, TRANSMIT_DATA_OUTPUT, GoodCRC_Response);


parameter dimension_objects = 16;
parameter dimension_high = dimension_real-7;
parameter dimension_low = dimension_real-15;

input [2:0] TRANSMIT;
input [7:0] TRANSMIT_BYTE_COUNT, TRANSMIT_HEADER_LOW, TRANSMIT_HEADER_HIGH;
input [dimension_objects:0] TRANSMIT_DATA_OBJECTS;
input GoodCRC_Response;

//wire valor_BYTE_COUNT = TRANSMIT_BYTE_COUNT[0] + TRANSMIT_BYTE_COUNT[1]*2 + TRANSMIT_BYTE_COUNT[2]*4 + TRANSMIT_BYTE_COUNT[3]*8 + TRANSMIT_BYTE_COUNT[4]*16
	//					 + TRANSMIT_BYTE_COUNT[5]*32 + TRANSMIT_BYTE_COUNT[6]*64 + TRANSMIT_BYTE_COUNT[7]*128;
							 





parameter 	estado_PRL_Tx_Wait_for_Transmit_Request = 3'b000,
			estado_PRL_Reset_RetryCounter = 3'b001,
			estado_PRL_Tx_Construct_Message = 3'b011,
			estado_PRL_Tx_Wait_for_PHY_response = 3'b010,
			estado_PRL_Tx_Match_MessageID = 3'b110,
			estado_PRL_Tx_Check_RetryCounter = 3'b111,
			estado_PRL_Tx_Report_Failure = 3'b101,
			estado_PRL_Tx_Report_Success = 3'b100;

//Para uso interno
reg[2:0] estado_actual;
reg[2:0] proximo_estado;

//Contadores
reg RetryCounter, CRCReceiveTimer;



//Parámetros
parameter valor_RetryCounter = 6;
parameter valor_CRCReceiveTimer = 6;

parameter dimension_real = dimension_objects + 15;

//Única salida
output [dimension_real:0] TRANSMIT_DATA_OUTPUT;
reg [dimension_real:0] TRANSMIT_DATA_OUTPUT;
//Estado inicial
initial
begin
	estado_actual = estado_PRL_Tx_Wait_for_Transmit_Request;
end 


//Lógica de próximo estado (combinacional)
always @*
begin

case(estado_actual)

	estado_PRL_Tx_Wait_for_Transmit_Request:
	begin
	if(TRANSMIT <= 3'b101)
		begin
		proximo_estado = estado_PRL_Reset_RetryCounter;
		end //end if
	else
		begin
		proximo_estado = estado_actual;
		end //end else
	
	end //end para este valor del case
	
	estado_PRL_Reset_RetryCounter:
	begin
		RetryCounter = valor_RetryCounter;
		proximo_estado = estado_PRL_Tx_Construct_Message;
	end //end para este caso del case
	
	estado_PRL_Tx_Construct_Message:
	begin
		TRANSMIT_DATA_OUTPUT [dimension_real:dimension_high] = TRANSMIT_HEADER_HIGH;
		TRANSMIT_DATA_OUTPUT [dimension_high:dimension_low] = TRANSMIT_HEADER_LOW;
		TRANSMIT_DATA_OUTPUT [dimension_low:0] = TRANSMIT_DATA_OBJECTS;
		proximo_estado = estado_PRL_Tx_Wait_for_PHY_response;
	end //end para ese caso del case
	
	estado_PRL_Tx_Wait_for_PHY_response:
	begin
		CRCReceiveTimer = valor_CRCReceiveTimer;
		
		//logica para ir disminuyendo este contador (falta)
		
		
		//Logica para calcular el proximo estado
		
		if (CRCReceiveTimer != 0) //Esto es para el caso en que el contador no este en cero, habria que ver que pasa con la respuesta del PHY
			begin
			if (GoodCRC_Response == 1)
				begin
				proximo_estado = estado_PRL_Tx_Match_MessageID;
				end 
			
			else
				begin
				proximo_estado = estado_PRL_Tx_Wait_for_PHY_response;
				end
					
			end //end if más grande
			
		//Si este contador ya está en cero
		else
			begin
			proximo_estado = estado_PRL_Tx_Check_RetryCounter;
			end
		
		
	end // en para este caso del case
	
	
	


endcase


end //end always
endmodule
