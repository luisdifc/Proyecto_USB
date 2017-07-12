module I2C_Module (
	input SCL,
	input CLK,
	input iSDA,
	input Reset,
	output oSDA
);
	//Defines
	parameter IDLE_ID 	 	=	1;
	parameter START	  	 	=	2;
	parameter WAIT_ID 	 	=	8;
	parameter SAVE_ID 	 	=	16;
	parameter ID_CYCLE   	= 32;
	parameter COMP_ID 	 	=	64;
	parameter ACK1	  	 	=	128;
	parameter START_REG  	=	256;
	parameter WAIT_REG   	=	512;
	parameter SAVE_REG   	=	1024;
	parameter REG_CYCLE  	= 2048;
	parameter ACK2		   	=	4096;
	parameter R_W			   	=	8192;
	parameter START_READ 	=	16384;
	parameter WAIT_SEND  	=	32768;
	parameter SEND		   	=	65536;
	parameter SEND_CYCLE 	= 131072;
	parameter START_WRITE	=	262144;
	parameter WAIT_WRITE 	=	524288;
	parameter SAVE_W		 	=	1048576;
	parameter WRITE_CYCLE = 2097152;
	parameter STOP			 	=	4194304;


//wires

//registers
	reg [4:0] 	count; 				 						//Contador de bits recibidos/enviados
	reg [3:0] 	byteCounter;							//Contador de Bytes recibidos
	reg [7:0] 	rByte; 				 						//Byte recibido
	reg [15:0]	rAdd,					 						//Dirección del registro solicitado por el maestro
			  			rSend,				 						//Byte con info a enviar al maestro
			  			rRec;											//Byte recibido a escribir en el registro solicitado por el maestro
	reg 	  		RW; 					 						//Indica si hay Read o Wirte solicitado
	reg [21:0]  currentState, 						//Registro del estado actual
			  			nextState;    		 			  //Registro de próximo estado
	reg 				Start; 	 									//Banderas para eventos en SDA y SCL
	reg 				woSDA;							 			//Registro a SDA como salida
	reg [6:0] 	DevID;				 						//Registro interno con el ID del dispositivo
	reg [31:0]  timeCounter;							//Contador de ciclos de CLK
	reg 				timeReset;								//Resets

//assign
	assign oSDA = woSDA;

//Negedge SDA
always @ ( negedge iSDA ) begin
	if (SCL) begin
		Start <= 1;
	end else begin
		Start <= 0;
	end
end

always @ (CLK, Reset ) begin
	if (Reset) begin
		DevID <= 5;
		currentState <= 1;
		nextState <= 1;
		count <= 5'b01000;
		rByte <= 8'b0;
		rAdd <= 16'b0;
		rSend <= 16'b1010101010101010;
		rRec <= 16'b0;
		RW <= 1;
		Start <= 0;
		timeCounter <= 32'b0;
		timeReset <= 0;
		woSDA <= 1;
		byteCounter <= 0;
	end
	else begin
		currentState <= nextState;
		if (timeReset) begin
			timeCounter <= 32'b0;
			timeReset <= 0;
		end
		else begin
			timeCounter <= timeCounter+1;
		end
	end
end

//State Machine
always @ ( posedge CLK ) begin

	case (currentState)
		IDLE_ID: begin //Inicializa máquina
			count <= count;
			rByte <= 8'b0;	//Limpiando basuras
			RW <= RW;
			rAdd <= 8'b0;
			rSend <= rSend;
			rRec <= 8'b0;
			byteCounter <= 0;

			if (Start) begin
				nextState <= START;
			end
			else begin
				nextState <= IDLE_ID;
			end
		end
/**********************************/
		START: begin //En espera de una señal de START
			count <= 5'd8;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (SCL) begin
				nextState <= START; //Permanece aquí mismo para no releer el mismo estado
			end											//inequívocamente, espera hasta asegurarse que SCL es bajo
			else begin
				nextState <= WAIT_ID;
			end
		end
/**********************************/
		WAIT_ID: begin //Espera recibir un bit
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (SCL) begin	//Espera hasta que SCL vuelva a estar en alto para ir a leer
				count <= count-1;
				nextState <= SAVE_ID;
			end
			else begin
				nextState <= WAIT_ID;
			end
		end
/**********************************/
		SAVE_ID: begin //Guarda el recibidosbit recibido en rByte
			count <= count;
			rByte <= rByte;
			rByte[count] <= iSDA;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			timeReset <= 1;
			nextState <= ID_CYCLE;
		end
/**********************************/
		ID_CYCLE: begin //Espera para no leer muchas veces la misma señal
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (count == 0) begin
				nextState <= COMP_ID;
			end
			else begin
				if (timeCounter <= 124) begin //Espera medio ciclo para caer en SCL bajo
					nextState <= ID_CYCLE;
				end
				else begin
					nextState <= WAIT_ID;
				end
			end //else contador
		end
/**********************************/
		COMP_ID: begin //Compara la ID recibida con la del dispositivo
			count <= count;
			rByte <= rByte;
			RW <= rByte[0];
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (rByte[7:1] == DevID) begin
				byteCounter <= byteCounter+1; //Se recibió un byte entero
				nextState <= ACK1;
			end
			else begin
				byteCounter <= 0;
				nextState <= IDLE_ID;
			end
		end
/**********************************/
		ACK1: begin //Envía ACK de que sí es el ID del dispositivo y se recibió el dato
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= 0; //Limpiar bytes recibidos para ir a registro

			woSDA <= 0; //ACK
			nextState <= START_REG;
		end
/**********************************/
		START_REG: begin //Inicia recepción de la dirección del regiistro
			count <= 5'b01000;
			rByte <= 8'b0;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (SCL) begin
				nextState <= START_REG;//Permanece aquí mismo para no releer el mismo estado
			end											//inequívocamente, espera hasta asegurarse que SCL es bajo
			else begin
				nextState <= WAIT_REG;
			end
		end
/**********************************/
		WAIT_REG: begin //Espera a recibir bit
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			woSDA <= 1; //Soltar línea SDA y quitar ACK
			byteCounter <= byteCounter;

			if (SCL) begin //Espera hasta que SCL vuelva a estar en alto para ir a leer
				count <= count-1;
				nextState <= SAVE_REG;
			end
			else begin
				nextState <= WAIT_REG;
			end
		end
/**********************************/
		SAVE_REG: begin //Guarda bit recibido
			count <= count;
			rByte <= rByte;
			rByte[count] <= iSDA;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			timeReset <= 1;
			nextState <= REG_CYCLE;
		end
/**********************************/
		REG_CYCLE: begin //Tempo de espera para no releer la información
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (count == 0) begin
				byteCounter <= byteCounter + 1; //Se recibió un byte entero
				nextState <= ACK2;
			end
			else begin
				byteCounter <= byteCounter;
				if (timeCounter <= 124) begin //Espera medio ciclo para caer en SCL bajo
					nextState <= REG_CYCLE;
				end
				else begin
					nextState <= WAIT_REG;
				end
			end //else contador
		end
/**********************************/
		ACK2: begin //ACK de que se recibió byte
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= 0;

			//Ver si ya recibió los dos bytes con la dirección del registro
			if (byteCounter == 2) begin
				rAdd[7:0] <= rByte; //Nibble bajo de la dirección recibida
				byteCounter <= 0; //limpiar contador de bytes
				nextState <= R_W; //Seguir a ver qué se hace con la dirección recibida
			end
			else begin
				rAdd[15:8] <= rByte; //Nibble alto de la dirección en recepción
				byteCounter <= byteCounter; //Mantenga los bytes contados
				nextState <= START_REG; //Va a esperar recibir otro byte

			end
		end
/**********************************/
		R_W: begin //Verifica si es read o Write
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (RW) begin
				nextState <= START_READ; //Es un READ solicitado
			end
			else begin
				nextState <= START_WRITE; //Es un WRITE solicitado
			end
		end
/**********************************/
/**********************************/
		START_READ: begin //Inicio del Read
			count <= 5'b10000; //16 bits por enviar
			rByte <= 8'b0;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend; //Cargar en rSend el contenido del registro a enviar (2 bytes)
			rRec <= rRec;
			byteCounter <= 0; //No se ha enviado byte

			woSDA <= 1; //Soltar línea SDA y quitar ACK
			if (SCL) begin
				nextState <= START_READ;//Permanece aquí mismo para no releer el mismo estado
			end											//inequívocamente, espera hasta asegurarse que SCL es bajo
			else begin
				nextState <= WAIT_SEND;
			end
		end
/**********************************/
		WAIT_SEND: begin //Espera a SCL para enviar bit
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (SCL) begin //Espera hasta que SCL vuelva a estar en alto para ir a leer
				count <= count-1;
				nextState <= SEND;
			end
			else begin
				nextState <= WAIT_SEND;
			end
		end
/**********************************/
		SEND: begin //Envía bit
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			woSDA <= rSend[count]; //Pasa bit a bit el contenido de rSend
			timeReset <= 1;
			nextState <= SEND_CYCLE;
		end
/**********************************/
		SEND_CYCLE: begin //Espera para no enviar muchas veces el mismo dato
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (count == 0) begin
				byteCounter <= byteCounter+1;
				timeReset <= 1;
				nextState <= STOP; //Envía a STOP para finalizar comunicación
			end
			else begin
				if (timeCounter <= 124) begin //Espera medio ciclo para caer en SCL bajo
					nextState <= SEND_CYCLE;
				end
				else begin
					nextState <= WAIT_SEND;
				end
			end //else contador
		end
/**********************************/
/**********************************/
		START_WRITE: begin //Inicio Write
			count <= 5'b10000; //16 bits
			rByte <= 8'b0;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			woSDA <= 1; //Soltar línea SDA y quitar ACK
			if (SCL) begin
				nextState <= START_WRITE;//Permanece aquí mismo para no releer el mismo estado
			end											//inequívocamente, espera hasta asegurarse que SCL es bajo
			else begin
				nextState <= WAIT_WRITE;
			end
		end
/**********************************/
		WAIT_WRITE: begin //Espera SCL para recibir bit
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (SCL) begin //Espera hasta que SCL vuelva a estar en alto para ir a leer
				count <= count-1;
				nextState <= SAVE_W;
			end
			else begin
				nextState <= WAIT_WRITE;
			end
		end
/**********************************/
		SAVE_W: begin //Guarda bit recibido
			count <= count;
			rByte <= rByte;
			rByte[count] <= iSDA;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			timeReset <= 1;
			nextState <= WRITE_CYCLE;
		end
/**********************************/
		WRITE_CYCLE: begin //Espera para no escribir muchas veces el mismo dato
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			if (count == 0) begin
				byteCounter <= byteCounter+1; //Se recibió un byte
				if (byteCounter == 1) begin //Solo se ha recibido un byte
					rRec[15:8] <= rByte;
					nextState <= START_WRITE; //Espera para recibir siguiente byte
				end
				else begin //Es el segundo byte
					rRec[7:0] <= rByte; //Escribe segundo byte
					nextState <= STOP; //Envía a STOP para finalizar comunicación
				end
			end
			else begin
				if (timeCounter <= 124) begin //Espera medio ciclo para caer en SCL bajo
					nextState <= WRITE_CYCLE;
				end
				else begin
					nextState <= WAIT_WRITE;
				end
			end //else contador
		end
/**********************************/
/**********************************/
		STOP: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= 0;

			if (timeCounter == 124) begin
				timeReset <= 1;
				nextState <= IDLE_ID;
			end
			else begin
				nextState <= STOP;
			end
		end
/**********************************/
		default: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;
			byteCounter <= byteCounter;

			nextState <= IDLE_ID;
			end

	endcase
end

endmodule
