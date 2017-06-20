
module I2C_Module (
	input SCL,
	input CLK,
	input iSDA,
	output oSDA
	);

//wires
wire woSDA;

//registers
	reg [2:0] count; 		//Contador de bits recibidos/enviados
	reg [7:0] rByte, 		//Byte recibido
			  rAdd,			//Dirección del registro solicitado por el maestro
			  rSend,		//Byte con info a enviar al maestro
			  rRec;	 		//Byte recibido a escribir en el registro solicitado por el maestro
	reg 	  R_W;	 		//Indica si hay Read o Wirte solicitado
	reg [4:0] currentState, //Registro del estado actual
			  nextState;    //Registro de próximo estado
	
//assign
assign oSDA = woSDA;

//Settings State MACHINE
always @(posedge CLK) begin
	currentState <= nextState;
end //END Settings State Machine

//MAIN STATE MACHINE
always @(posedge CLK) begin 
	case(currentState) 
		'IDLE_ID': //IDLE ID
		
		'START': //START ID
		
		'WAIT_ID': //WAIT ID
		
		'SAVE_ID': //SAVE ID
		
		'COMP_ID': //COMPARE ID
		
		'ACK1': //ACKNOWLEDGE 1
		
		'START_REG': //START REGISTER
		
		'WAIT_REG': //WAIT REGISTER
		
		'SAVE_REG': //SAVE REGISTER ADDRESS
		
		'ACK2': //ACKNOWLEDGE 2
		
		'R_W': //READ OR WRITE
		
		'START_R': //START READ
		
		'SEND_IDLE': //SEND IDLE
		
		'SEND': //SEND
		
		//TO STOP
		
		'START_W': //START ID
		
		'WRITE_IDLE': //WRITE IDLE
		
		'SAVE_W': //SAVE WRITE DATA
		
		'STOP': //STOP
		
		default: //Envía a IDLE_ID
			nextState <= 'IDLE_ID';
	endcase
	
end //always @(posedge CLK)

endmodule