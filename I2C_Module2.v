module I2C_Module (
	input SCL,
	input CLK,
	input iSDA,
	output oSDA
);
	//Defines
	parameter IDLE_ID 	 =	1;
	parameter START	  	 =	3;
	parameter WAIT_ID 	 =	9;
	parameter SAVE_ID 	 =	17;
	parameter COMP_ID 	 =	33;
	parameter ACK1	  	 =	65;
	parameter START_REG  =	129;
	parameter WAIT_REG   =	257;
	parameter SAVE_REG   =	513;
	parameter ACK2		   =	1025;
	parameter R_W			   =	2049;
	parameter START_R	   =	4097;
	parameter SEND_IDLE  =	8193;
	parameter SEND		   =	16385;
	parameter START_W    =	32769;
	parameter WRITE_IDLE =	65537;
	parameter SAVE_W		 =	131073;
	parameter STOP			 =	262145;

//wires

//registers
	reg [2:0] count; 				 //Contador de bits recibidos/enviados
	reg [7:0] rByte, 				 //Byte recibido
			  		rAdd,					 //Dirección del registro solicitado por el maestro
			  		rSend,				 //Byte con info a enviar al maestro
			  		rRec;					 //Byte recibido a escribir en el registro solicitado por el maestro
	reg 	  	RW; 					 //Indica si hay Read o Wirte solicitado
	reg [17:0] currentState, //Registro del estado actual
			  nextState;    		 //Registro de próximo estado
	reg hSDA, lSDA, hSCL; 	 //Banderas para eventos en SDA y SCL
	reg woSDA;							 //Registro a SDA como salida
	reg [6:0] DevID;				 //Registro interno con el ID del dispositivo

//assign
assign oSDA = woSDA;

initial begin
	DevID <= 5;
end

//Settings State MACHINE
always @(posedge CLK) begin
	currentState <= nextState;
end //END Settings State Machine

//SDA and SCL controll
/*always @ ( SDA, SCL ) begin

end*/

//Main State Machine
always @(posedge CLK) begin
	case(currentState)
		IDLE_ID: //IDLE ID
		begin
			//Valores iniciales de los registros
				count <= 3'b0;
				rByte <= 8'b0;
				RW <= 1'b1;
				rAdd <= 8'b0;
				rSend <= 8'b0;
				rRec <= 8'b0;

			if(~iSDA) begin //Espera flanco negativo en SDA, señal START
				nextState <= START;
			end else begin
				nextState <= IDLE_ID;
			end //else IDLE
		end //end IDLE_ID
/********************************/
		START: //START ID
		begin
			count <= 8;
			rByte <= 8'b0;
			RW <= 1'b1;
			rAdd <= 8'b0;
			rSend <= 8'b0;
			rRec <= 8'b0;

			nextState <= WAIT_ID;
		end //START
/********************************/
		WAIT_ID: //WAIT ID
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (SCL) begin //Espera cambio en el reloj a valor positivo
				nextState <= SAVE_ID;
			end else begin
				nextState <= WAIT_ID;
			end //if WAIT_ID
		end //WAIT_ID
/********************************/
		SAVE_ID: //SAVE ID
		begin
			count <= count-1;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			rByte[count] <= iSDA;
			if(count == 0) begin
				nextState <= COMP_ID;
			end else begin
				nextState <= WAIT_ID;
			end //if SAVE_ID
		end //SAVE_ID
/********************************/
		COMP_ID: //COMPARE ID
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(rByte == DevID) begin
				nextState <= ACK1;
			end else begin
				nextState <= IDLE_ID;
			end //if COMP_ID
		end //COMP_ID
/********************************/
		ACK1: //ACKNOWLEDGE 1
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= 0; //Envía ACK //Contador para mantener salida activa el tiempo reqerido
			nextState <= START_REG;
		end //ACK1
/********************************/
		START_REG: //START REGISTER
		begin
			count <= 8;
			rByte <= rByte;
			RW <= rByte[0];
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			nextState <= WAIT_REG;
		end //START_REG
/********************************/
		WAIT_REG: //WAIT REGISTER
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (SCL) begin //Espera cambio en el reloj a valor positivo
				nextState <= SAVE_REG;
			end else begin
				nextState <= WAIT_REG;
			end //if WAIT_ID
		end //WAIT_REG
/********************************/
		SAVE_REG: //SAVE REGISTER ADDRESS
		begin
			count <= count-1;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			rByte[count] <= iSDA;
			if(count == 0) begin
				nextState <= ACK2;
			end else begin
				nextState <= WAIT_REG;
			end	//if SAVE_REG
		end //SAVE_REG
/********************************/
		ACK2: //ACKNOWLEDGE 2
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rByte; //Guarda dirección del registro recibida
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= 0; //Envía ACK //Contador para mantener salida activa el tiempo reqerido
			nextState <= RW;
		end //ACK2
/********************************/
		R_W: //READ OR WRITE
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(RW) begin
				nextState <= START_R; //Es un Read
			end else begin
				nextState <= START_W; //Es un Write
			end //if RW
		end //RW
/********************************/
		START_R: //START READ
		begin
			count <= 8;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend; //Pone contenido del registro solicitado
			rRec <= rRec;

			nextState <= SEND_IDLE;
		end //START_R
/********************************/
		SEND_IDLE: //SEND IDLE
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(SCL) begin //Espera cambio en el reloj a valor positivo
				nextState <= SEND;
			end else begin
				nextState <= SEND_IDLE;
			end //if SEND_IDLE
		end //SEND_IDLE
/********************************/
		SEND: //SEND
		begin
			count <= count-1;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= rSend[count]; //Contador para mantener la salida activa el tiempo requerido
			if(count == 0) begin
				nextState <= STOP;
			end else begin
				nextState <= SEND_IDLE;
			end //if SEND
		end //SEND
/********************************/
		START_W: //START W
		begin
			count <= 8;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			nextState <= WRITE_IDLE;
		end //START_W
/********************************/
		WRITE_IDLE: //WRITE IDLE
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(SCL) begin //Espera cambio en el reloj a valor positivo
				nextState <= SAVE_W;
			end else begin
				nextState <= WRITE_IDLE;
			end //if WRITE_IDLE
		end //WRITE_IDLE
/********************************/
		SAVE_W: //SAVE WRITE DATA
		begin
			count <= count-1;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			rByte[count] <= iSDA;
			if(count == 0) begin
				nextState <= STOP;
			end else begin
				nextState <= WRITE_IDLE;
			end //if SAVE_W
		end //SAVE_W
/********************************/
		STOP: //STOP
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(iSDA) begin //Espera cambio en el reloj a valor positivo
				nextState <= IDLE_ID;
			end else begin
				nextState <= IDLE_ID; //Contador de desconexión
			end //end STOP
		end //STOP
/********************************/
		default: //Envía a IDLE_ID
		begin
			count <= count;
			rByte <= rByte;
			RW <= RW;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			nextState <= IDLE_ID;
		end //default
	endcase

end //always @(posedge CLK)

endmodule
