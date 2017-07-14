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

//Descripcion:
//modulo contador de tiempos tiene la capacidad de contar nano segundos
//micro segundos, mili segundos y segundos

module timer (CLK, nanos, micros, milis, segs, reset);

//outputs declaration
output reg [9:0] nanos;
output reg [9:0] micros;
output reg [9:0] milis;
output reg [9:0] segs; 

//inputs declaration
input wire CLK;
input wire reset;

always @(posedge CLK or negedge CLK) begin
	if (reset) begin
		nanos <= 0;
		micros <= 0;
		milis <= 0;
		segs <= 0;
	end else begin
		if (nanos < 999) begin
			nanos <= nanos + 1;
		end else begin
			if (micros < 999) begin
				nanos <= 0;
				micros <= micros + 1;
			end else begin
				if (milis < 999) begin 
					micros <= 0;
					milis <= + 1;
				end else begin
					milis <= 0;
					segs <= segs + 1;
				end
			end
		end
	end
end //always

endmodule