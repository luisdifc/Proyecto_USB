module I2C_Module (
	input SCL,
	input CLK,
	input iSDA,
	input Reset,
	output oSDA
);
	//Defines
	parameter IDLE_ID 	 =	1;
	parameter START	  	 =	2;
	parameter WAIT_ID 	 =	8;
	parameter SAVE_ID 	 =	16;
	parameter ID_CYCLE   =  524288;
	parameter COMP_ID 	 =	32;
	parameter ACK1	  	 =	64;
	parameter START_REG  =	128;
	parameter WAIT_REG   =	256;
	parameter SAVE_REG   =	512;
	parameter ACK2		   =	1024;
	parameter R_W			   =	2048;
	parameter START_R	   =	4096;
	parameter SEND_IDLE  =	8192;
	parameter SEND		   =	16384;
	parameter START_W    =	32768;
	parameter WRITE_IDLE =	65536;
	parameter SAVE_W		 =	131072;
	parameter STOP			 =	262144;


//wires

//registers
	reg [3:0] count; 				 						 //Contador de bits recibidos/enviados
	reg [7:0] rByte, 				 						 //Byte recibido
			  		rAdd,					 						 //Dirección del registro solicitado por el maestro
			  		rSend,				 						 //Byte con info a enviar al maestro
			  		rRec;											 //Byte recibido a escribir en el registro solicitado por el maestro
	reg 	  	RW; 					 						 //Indica si hay Read o Wirte solicitado
	reg [18:0] currentState, 						 //Registro del estado actual
			  			nextState;    		 			 //Registro de próximo estado
	reg Start; 	 												 //Banderas para eventos en SDA y SCL
	reg woSDA;							 						 //Registro a SDA como salida
	reg [6:0] DevID;				 						 //Registro interno con el ID del dispositivo
	reg [31:0] timeCounter;							 //Contador de ciclos de CLK
	reg timeReset;								 //Resets

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

always @ ( CLK, Reset ) begin
	if (Reset) begin
		DevID <= 5;
		currentState <= 1;
		nextState <= 1;
		count <= 4'b1000;
		rByte <= 8'b0;
		rAdd <= 8'b0;
		rSend <= 8'b0;
		rRec <= 8'b0;
		RW <= 0;
		Start <= 0;
		timeCounter <= 32'b0;
		woSDA <= 1;
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
		IDLE_ID: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (Start) begin
				nextState <= START;
			end
			else begin
				nextState <= IDLE_ID;
			end
		end
/**********************************/
		START: begin
			count <= 4'b1000;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (SCL) begin
				nextState <= START;
			end
			else begin
				nextState <= WAIT_ID;
			end
		end
/**********************************/
		WAIT_ID: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (SCL) begin
				nextState <= SAVE_ID;
			end
			else begin
				nextState <= WAIT_ID;
			end
		end
/**********************************/
		SAVE_ID: begin
			count <= count-1;
			rByte[count] <= iSDA;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			timeReset <= 1;
			nextState <= ID_CYCLE;
		end
/**********************************/
		ID_CYCLE: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (count == 0) begin
				nextState <= COMP_ID;
			end
			else begin
				if (timeCounter <= 149) begin
					nextState <= ID_CYCLE;
				end
				else begin
					nextState <= WAIT_ID;
				end
			end //else contador
		end
/**********************************/
		COMP_ID: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (rByte[7:1] == DevID) begin
				nextState <= ACK1;
			end
			else begin
				nextState <= IDLE_ID;
			end
		end
/**********************************/
		ACK1: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= 0;
			nextState <= IDLE_ID;
		end
/**********************************/
		default: begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			nextState <= ID_CYCLE;
			end

	endcase
end

endmodule
