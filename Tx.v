module Tx(CLK, TRANSMIT, TRANSMIT_BYTE_COUNT, TRANSMIT_HEADER_LOW, TRANSMIT_HEADER_HIGH, TRANSMIT_DATA_OBJECTS, TRANSMIT_DATA_OUTPUT, GoodCRC_Response,
 ALERT_TransmitSOP_MessageFailed, ALERT_TransmitSOP_MessageSuccessful, TX_BUF_HEADER_BYTE_1, RX_BUF_HEADER_BYTE_1, RX_BUF_FRAME_TYPE);


input [15:0] TRANSMIT;
input [7:0] TRANSMIT_BYTE_COUNT, TRANSMIT_HEADER_LOW, TRANSMIT_HEADER_HIGH, TX_BUF_HEADER_BYTE_1, 
			RX_BUF_HEADER_BYTE_1, RX_BUF_FRAME_TYPE;
input [223:0] TRANSMIT_DATA_OBJECTS;
input GoodCRC_Response;
input CLK;


//wire valor_BYTE_COUNT = TRANSMIT_BYTE_COUNT[0] + TRANSMIT_BYTE_COUNT[1]*2 + TRANSMIT_BYTE_COUNT[2]*4 + TRANSMIT_BYTE_COUNT[3]*8 + TRANSMIT_BYTE_COUNT[4]*16
	//					 + TRANSMIT_BYTE_COUNT[5]*32 + TRANSMIT_BYTE_COUNT[6]*64 + TRANSMIT_BYTE_COUNT[7]*128;
							 





parameter 	estado_PRL_Tx_Wait_for_Transmit_Request = 4'b0000,
			estado_PRL_Reset_RetryCounter = 4'b0001,
			estado_PRL_Tx_Construct_Message = 4'b0011,
			estado_PRL_Tx_Wait_for_PHY_response = 4'b1101,
			estado_PRL_Tx_Match_MessageID = 4'b1001,
			estado_PRL_Tx_Check_RetryCounter = 4'b0101,
			estado_PRL_Tx_Report_Failure = 8'b0100,
			estado_PRL_Tx_Report_Success = 8'b1000;

//Para uso interno
reg[3:0] estado_actual;
reg[3:0] proximo_estado;
reg [1:0] CRCReceiveTimer;
reg Habilitarcontador;


//Contadores (de momento se manejarán como registros)
reg [1:0] RetryCounter;




parameter dimension_real = 239;

//Salidas
output [dimension_real:0] TRANSMIT_DATA_OUTPUT;
reg [dimension_real:0] TRANSMIT_DATA_OUTPUT;

output ALERT_TransmitSOP_MessageFailed;
reg ALERT_TransmitSOP_MessageFailed;

output ALERT_TransmitSOP_MessageSuccessful;
reg ALERT_TransmitSOP_MessageSuccessful;

reg bandera;



//Estado inicial
initial
begin
	estado_actual = estado_PRL_Tx_Wait_for_Transmit_Request;
	RetryCounter = 'b00;
	ALERT_TransmitSOP_MessageSuccessful = 0;
	ALERT_TransmitSOP_MessageFailed = 0;
	CRCReceiveTimer = 'b00;
	Habilitarcontador = 0;
	bandera = 0;
	TRANSMIT_DATA_OUTPUT = 0;
	
end 


//Lógica de próximo estado (combinacional)
always @*
begin



case(estado_actual)

	estado_PRL_Tx_Wait_for_Transmit_Request:
	begin
	if(TRANSMIT[2:0] <= 3'b101 && bandera == 0)
		begin
		proximo_estado = estado_PRL_Reset_RetryCounter;
		
		end //end if
	else
		begin
		proximo_estado = estado_PRL_Tx_Wait_for_Transmit_Request; //se queda en el mismo estado
		end //end else
	
	end //end para este valor del case
	
	estado_PRL_Reset_RetryCounter:
	begin
		RetryCounter = 'b00;
		proximo_estado = estado_PRL_Tx_Construct_Message;
		bandera = 1;
	end //end para este caso del case
	
	estado_PRL_Tx_Construct_Message:
	begin
		TRANSMIT_DATA_OUTPUT [239:232] = TRANSMIT_HEADER_HIGH;
		TRANSMIT_DATA_OUTPUT [231:224] = TRANSMIT_HEADER_LOW;
		TRANSMIT_DATA_OUTPUT [223:0] = TRANSMIT_DATA_OBJECTS;
		proximo_estado = estado_PRL_Tx_Wait_for_PHY_response;
	end //end para ese caso del case
	
	estado_PRL_Tx_Wait_for_PHY_response:
	begin
		
	if (CRCReceiveTimer == 'b11) //Esto es para cuando ya llegó al tiempo límite de espera
		begin
		Habilitarcontador = 0;
		proximo_estado = estado_PRL_Tx_Check_RetryCounter;
		end
			
		//Si este contador ya está en su valor máximo
	else
			
		begin
		if (GoodCRC_Response == 1)
			begin
			proximo_estado = estado_PRL_Tx_Match_MessageID;
			Habilitarcontador = 0; //este contador lo único que hace es habilitar el conteo o deshabilitarlo
			end 
			
		else
			begin
			proximo_estado = estado_PRL_Tx_Wait_for_PHY_response;
			Habilitarcontador = 1;
			end
					
		end //end else
		
		
		
	end // en para este caso del case
	
	estado_PRL_Tx_Match_MessageID:
	begin
	
	if (TX_BUF_HEADER_BYTE_1 != RX_BUF_HEADER_BYTE_1 || TRANSMIT[2:0] != RX_BUF_FRAME_TYPE)
	begin
	proximo_estado = estado_PRL_Tx_Check_RetryCounter;
	end //end if
	
	else
	begin
	proximo_estado = estado_PRL_Tx_Report_Success;
	end //end else
	
	
	
	end //end para este caso
	
	estado_PRL_Tx_Check_RetryCounter:
	begin
		
	if(RetryCounter == 'b11 )
		begin
		proximo_estado = estado_PRL_Tx_Report_Failure;
		end
		
		else
			begin
			proximo_estado = estado_PRL_Tx_Construct_Message;
			end
			
		RetryCounter = RetryCounter + 1; //aumenta el contador
	end //end para este caso del case
	
	estado_PRL_Tx_Report_Failure:
	begin
	ALERT_TransmitSOP_MessageFailed = 1;
	proximo_estado = estado_PRL_Tx_Wait_for_Transmit_Request;	
	end //end para este caso del case
	
	estado_PRL_Tx_Report_Success:
	begin
	ALERT_TransmitSOP_MessageSuccessful = 1;
	proximo_estado = estado_PRL_Tx_Wait_for_Transmit_Request;
	end
	
	


endcase


end //end always

//Parte secuencial

always @(posedge CLK)
begin
estado_actual <= proximo_estado;

//Lógica para CRCReceiveTimer

if (Habilitarcontador == 1)
	begin

	CRCReceiveTimer <= CRCReceiveTimer+ 1;
	end

else
begin
CRCReceiveTimer <= 0;
end
	


end //end always

endmodule
