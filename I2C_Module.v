//Defines
`define IDLE_ID 	18'b1
`define START	  	18'b3
`define WAIT_ID 	18'b9
`define SAVE_ID 	18'b17
`define COMP_ID 	18'b33
`define ACK1	  	18'b65
`define START_REG 	18'b129
`define WAIT_REG  	18'b257
`define SAVE_REG  	18'b513
`define ACK2		18'b1025
`define R_W			18'b2049
`define START_R	  	18'b4097
`define SEND_IDLE 	18'b8193
`define SEND		18'b16385
`define START_W   	18'b32769
`define WRITE_IDLE	18'b65537
`define SAVE_W		18'b131073
`define STOP		18'b262145

module I2C_Module (
	input SCL,
	input CLK,
	input iSDA,
	output oSDA
	);

//wires
wire woSDA;

//registers
	reg [2:0] count; 				 //Contador de bits recibidos/enviados
	reg [7:0] rByte, 				 //Byte recibido
			  		rAdd,					 //Dirección del registro solicitado por el maestro
			  		rSend,				 //Byte con info a enviar al maestro
			  		rRec;					 //Byte recibido a escribir en el registro solicitado por el maestro
	reg 	  	R_W; 					 //Indica si hay Read o Wirte solicitado
	reg [17:0] currentState, //Registro del estado actual
			  nextState;    		 //Registro de próximo estado
	reg hSDA, lSDA, hSCL; 	 //Banderas para eventos en SDA y SCL

//assign
assign oSDA = woSDA;

//Settings State MACHINE
always @(posedge CLK) begin
	currentState <= nextState;
end //END Settings State Machine

//SDA and SCL controll
always @ ( SDA, SCL ) begin

end

//Main State Machine
always @(posedge CLK) begin
	case(currentState)
		`IDLE_ID: //IDLE ID 
		begin
			//Valores iniciales de los registros
				count <= 3'b0;
				rByte <= 8'b0;
				R_W <= 1'b1;
				rAdd <= 8'b0;
				rSend <= 8'b0;
				rRec <= 8'b0;

			if(lSDA) begin
				nextState <= `START;
			end else begin
				nextState <= `IDLE_ID;
			end //else IDLE
		end //end IDLE_ID
/********************************/
		`START: //START ID
		begin
			count <= 3'b8;
			rByte <= 8'b0;
			R_W <= 1'b1;
			rAdd <= 8'b0;
			rSend <= 8'b0;
			rRec <= 8'b0;

			nextState <= `WAIT_ID;
		end //START
/********************************/
		`WAIT_ID: //WAIT ID
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rREC;

			if (hSCL) begin
				nextState <= `SAVE_ID;
			end else begin
				nextState <= `WAIT_ID;
			end //if WAIT_ID
		end //WAIT_ID
/********************************/
		`SAVE_ID: //SAVE ID
		begin
			count <= count-1;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			rByte[count] <= iSDA;
			if(count == 0) begin
				nextState <= `COMP_ID;
			end else begin
				nextState <= `WAIT_ID;
			end //if SAVE_ID
		end //SAVE_ID
/********************************/
		`COMP_ID: //COMPARE ID
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(rByte == DevID) begin
				nextState <= `ACK1;
			end else begin
				nextState <= `IDLE_ID;
			end //if `COMP_ID
		end //COMP_ID
/********************************/
		`ACK1: //ACKNOWLEDGE 1
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= 0; //Envía ACK //Contador para mantener salida activa el tiempo reqerido
			nextState <= `START_REG;
		end //ACK1
/********************************/
		`START_REG: //START REGISTER
		begin
			count <= 3'b8;
			rByte <= rByte;
			R_W <= rByte[0];
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			nextState <= `WAIT_REG;
		end //START_REG
/********************************/
		`WAIT_REG: //WAIT REGISTER
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if (hSCL) begin
				nextState <= `SAVE_REG;
			end else begin
				nextState <= `WAIT_REG;
			end //if WAIT_ID
		end //WAIT_REG
/********************************/
		`SAVE_REG: //SAVE REGISTER ADDRESS
		begin
			count <= count-1;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			rByte[count] <= iSDA;
			if(count == 0) begin
				nextState <= `ACK2;
			end else begin
				nextState <= `WAIT_REG;
			end	//if `SAVE_REG
		end //SAVE_REG
/********************************/
		`ACK2: //ACKNOWLEDGE 2
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rByte; //Guarda dirección del registro recibida
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= 0; //Envía ACK //Contador para mantener salida activa el tiempo reqerido
			nextState <= `R_W;
		end //ACK2
/********************************/
		`R_W: //READ OR WRITE
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(R_W) begin
				nextState <= `START_R; //Es un Read
			end else begin
				nextState <= `START_W; //Es un Write
			end //if `R_W
		end //R_W
/********************************/
		`START_R: //START READ
		begin
			count <= 3'b8;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend; //Pone contenido del registro solicitado
			rRec <= rRec;

			nextState <= `SEND_IDLE;
		end //START_R
/********************************/
		`SEND_IDLE: //SEND IDLE
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(hSCL) begin
				nextState <= `SEND;
			end else begin
				nextState <= `SEND_IDLE;
			end //if `SEND_IDLE
		end //SEND_IDLE
/********************************/
		`SEND: //SEND
		begin
			count <= count-1;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			woSDA <= rSend[count]; //Contador para mantener la salida activa el tiempo requerido
			if(count == 0) begin
				nextState <= `STOP;
			end else begin
				nextState <= `SEND_IDLE;
			end //if `SEND
		end //SEND
/********************************/
		`START_W: //START W
		begin
			count <= 18'b8;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			nextState <= `WRITE_IDLE;
		end //START_W
/********************************/
		`WRITE_IDLE: //WRITE IDLE
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(hSCL) begin
				nextState <= `SAVE_W;
			end else begin
				nextState <= `WRITE_IDLE;
			end //if `WRITE_IDLE
		end //WRITE_IDLE
/********************************/
		`SAVE_W: //SAVE WRITE DATA
		begin
			count <= count-1;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			rByte[count] <= iSDA;
			if(count == 0) begin
				nextState <= `STOP;
			end else begin
				nextState <= `WRITE_IDLE;
			end //if `SAVE_W
		end //SAVE_W
/********************************/
		`STOP: //STOP
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			if(hSDA) begin
				nextState <= `IDLE_ID;
			end else begin
				nextState <= `IDLE_ID; //Contador de desconexión
			end //end `STOP
		end //STOP
/********************************/
		default: //Envía a IDLE_ID
		begin
			count <= count;
			rByte <= rByte;
			R_W <= R_W;
			rAdd <= rAdd;
			rSend <= rSend;
			rRec <= rRec;

			nextState <= `IDLE_ID;
		end //default
	endcase

end //always @(posedge CLK)

endmodule
