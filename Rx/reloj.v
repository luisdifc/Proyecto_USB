module relojito(reloj);
	output reloj;
  	reg reloj;

  	initial reloj = 0;
	
  	always
   	#1 reloj = ~reloj;
endmodule