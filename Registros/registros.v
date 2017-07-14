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

module Registros(CLK, ADDR, RNW, WR_DATA, RD_DATA, req, ACK, cc_status, power_status, alert, alert_mask, power_status_mask, fault_status_mask);
input CLK;

input [15:0] alert, alert_mask; 

input [7:0] cc_status, power_status, power_status_mask, fault_status_mask;


//Entradas
input [7:0] ADDR;
input [15:0] WR_DATA;
input RNW, req;



//Salidas
output ACK;
reg ACK;
output [15:0] RD_DATA;
reg [15:0] RD_DATA;



//Registros
reg [15:0] VENDOR_ID, PRODUCT_ID, DEVICE_ID, USBTYPEC_REV, USBPD_REV_VER, PD_INTERFACE_REV, ALERT, ALERT_MASK, DEVICE_CAPABILITIES_1,
		   DEVICE_CAPABILITIES_2, VBUS_VOLTAGE, VBUS_SINK_DISCONNECT_THRESHOLD, VBUS_STOP_DISCHARGE_THRESHOLD, VBUS_VOLTAGE_ALARM_HI_CFG, VBUS_VOLTAGE_ALARM_LO_CFG;

reg [7:0] POWER_STATUS_MASK, FAULT_STATUS_MASK, CONFIG_STANDARD_OUTPUT, TCPC_CONTROL, ROLE_CONTROL, FAULT_CONTROL, POWER_CONTROL, CC_STATUS, POWER_STATUS,
		  FAULT_STATUS, COMMAND, STANDARD_INPUT_CAPABILITIES, STANDARD_OUTPUT_CAPABILITIES, MESSAGE_HEADER_INFO, RECEIVE_DETECT, RECEIVE_BYTE_COUNT, RX_BUF_FRAME_TYPE,
		  RX_BUF_HEADER_BYTE_0, RX_BUF_HEADER_BYTE_1, RX_BUF_OBJ1_BYTE_0, RX_BUF_OBJ1_BYTE_1, RX_BUF_OBJ1_BYTE_2, RX_BUF_OBJ1_BYTE_3, RX_BUF_OBJ2_BYTE_0, RX_BUF_OBJ2_BYTE_1,
		  RX_BUF_OBJ2_BYTE_2, RX_BUF_OBJ2_BYTE_3, RX_BUF_OBJ3_BYTE_0, RX_BUF_OBJ3_BYTE_1, RX_BUF_OBJ3_BYTE_2, RX_BUF_OBJ3_BYTE_3, RX_BUF_OBJ4_BYTE_0, RX_BUF_OBJ4_BYTE_1,
		  RX_BUF_OBJ4_BYTE_2, RX_BUF_OBJ4_BYTE_3, RX_BUF_OBJ5_BYTE_0, RX_BUF_OBJ5_BYTE_1, RX_BUF_OBJ5_BYTE_2, RX_BUF_OBJ5_BYTE_3, RX_BUF_OBJ6_BYTE_0, RX_BUF_OBJ6_BYTE_1,
		  RX_BUF_OBJ6_BYTE_2, RX_BUF_OBJ6_BYTE_3, RX_BUF_OBJ7_BYTE_0, RX_BUF_OBJ7_BYTE_1, RX_BUF_OBJ7_BYTE_2, RX_BUF_OBJ7_BYTE_3, TRANSMIT, TRANSMIT_BYTE_COUNT, 
		  TX_BUF_OBJ1_BYTE_0, TX_BUF_OBJ1_BYTE_1, TX_BUF_OBJ1_BYTE_2, TX_BUF_OBJ1_BYTE_3, TX_BUF_OBJ2_BYTE_0, TX_BUF_OBJ2_BYTE_1, TX_BUF_OBJ2_BYTE_2, TX_BUF_OBJ2_BYTE_3,
		  TX_BUF_OBJ3_BYTE_0, TX_BUF_OBJ3_BYTE_1, TX_BUF_OBJ3_BYTE_2, TX_BUF_OBJ3_BYTE_3, TX_BUF_OBJ4_BYTE_0, TX_BUF_OBJ4_BYTE_1, TX_BUF_OBJ4_BYTE_2, TX_BUF_OBJ4_BYTE_3,
		  TX_BUF_OBJ5_BYTE_0, TX_BUF_OBJ5_BYTE_1, TX_BUF_OBJ5_BYTE_2, TX_BUF_OBJ5_BYTE_3, TX_BUF_OBJ6_BYTE_0, TX_BUF_OBJ6_BYTE_1, TX_BUF_OBJ6_BYTE_2, TX_BUF_OBJ6_BYTE_3,
		  TX_BUF_OBJ7_BYTE_0, TX_BUF_OBJ7_BYTE_1, TX_BUF_OBJ7_BYTE_2, TX_BUF_OBJ7_BYTE_3, TX_BUF_HEADER_BYTE_0, TX_BUF_HEADER_BYTE_1;
		  
		  
		  
always @(posedge CLK)
	begin
	
	//Esto es para que actualice los valores de las entradas que vienen del hardware
	//ALERT <= alert;
	//ALERT_MASK <= alert_mask;
	//POWER_STATUS_MASK <= power_status_mask;
	//FAULT_STATUS_MASK <= fault_status_mask;
	
	
	
	
	
	//req indica que se tiene un acceso desde el CPU
	if (req == 'b1)
		begin
		
		case(ADDR)
		
		'h00:
		begin
			RD_DATA <=  VENDOR_ID;
			ACK = 1;
			
		end //end para este caso del case	
			
		'h02:
		begin
				RD_DATA <= PRODUCT_ID;
				ACK = 1;
		end //end para este caso del case
			
		'h04:
		begin
			RD_DATA <= DEVICE_ID;
			ACK = 1;
			
		end //end para este caso del case
		
		'h06:
		begin
				RD_DATA <= USBTYPEC_REV;
				ACK = 1;
			
		end //end para este valor específico del case
		
		'h08:
		begin
			RD_DATA <= USBPD_REV_VER;
			ACK = 1;
		end //end para este valor específico del case
			
		'h0A:
		begin
			RD_DATA <= PD_INTERFACE_REV;
			ACK = 1;
			
		end //end para este valor específico del case
			
		'h10:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA <= ALERT;
				end //end if
				
				//Si es escritura
				else
				begin
				ALERT <= WR_DATA;
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h12:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA <= ALERT_MASK;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				ALERT_MASK <= WR_DATA;
				ACK = 1;
				end //end else
			
		end //end para este caso del case
			
		
		'h14:
		begin
		
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= POWER_STATUS_MASK;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				POWER_STATUS_MASK <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h15:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= FAULT_STATUS_MASK;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				FAULT_STATUS_MASK <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h18:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= CONFIG_STANDARD_OUTPUT;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				CONFIG_STANDARD_OUTPUT <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h19:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= TCPC_CONTROL;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TCPC_CONTROL <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h1A:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= ROLE_CONTROL;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				ROLE_CONTROL <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
			
		'h1B:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= FAULT_CONTROL;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				FAULT_CONTROL <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h1C:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= POWER_CONTROL;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				POWER_CONTROL <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h1D:
		begin
			CC_STATUS <= cc_status;
			RD_DATA[7:0] <= CC_STATUS;
			RD_DATA[15:8] <= 8'b0;
			ACK = 1;
						
		end //end para este caso del case
		
		'h1E:
		begin
			RD_DATA[7:0] <= POWER_STATUS;
			RD_DATA[15:8] <= 8'b0;
			ACK = 1;
						
		end //end para este caso del case
		
		'h1F:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= FAULT_STATUS;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				FAULT_STATUS <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h23:
		begin
			COMMAND <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h24:
		begin
			DEVICE_CAPABILITIES_1 = RD_DATA;
			ACK = 1;
		end //end para este caso del case
		
		'h26:
		begin
			DEVICE_CAPABILITIES_2 = RD_DATA;
			ACK = 1;
		end //end para este caso del case
		
		'h28:
		begin
			STANDARD_INPUT_CAPABILITIES <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h29:
		begin
			STANDARD_OUTPUT_CAPABILITIES <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h2E:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= MESSAGE_HEADER_INFO;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				MESSAGE_HEADER_INFO <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h2F:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= RECEIVE_DETECT;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				RECEIVE_DETECT <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h30:
		begin
			RECEIVE_BYTE_COUNT <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h31:
		begin
			RX_BUF_FRAME_TYPE <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h32:
		begin
			RX_BUF_HEADER_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h33:
		begin
			RX_BUF_HEADER_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h34:
		begin
			RX_BUF_OBJ1_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h35:
		begin
			RX_BUF_OBJ1_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h36:
		begin
			RX_BUF_OBJ1_BYTE_2 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h37:
		begin
			RX_BUF_OBJ1_BYTE_3 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
	
		'h38:
		begin
			RX_BUF_OBJ2_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h39:
		begin
			RX_BUF_OBJ2_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h3A:
		begin
			RX_BUF_OBJ2_BYTE_2 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h3B:
		begin
			RX_BUF_OBJ2_BYTE_3 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h3C:
		begin
			RX_BUF_OBJ3_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h3D:
		begin
			RX_BUF_OBJ3_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h3E:
		begin
			RX_BUF_OBJ3_BYTE_2 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h3F:
		begin
			RX_BUF_OBJ3_BYTE_3 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h40:
		begin
			RX_BUF_OBJ4_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h41:
		begin
			RX_BUF_OBJ4_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h42:
		begin
			RX_BUF_OBJ4_BYTE_2 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h43:
		begin
			RX_BUF_OBJ4_BYTE_3 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h44:
		begin
			RX_BUF_OBJ5_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h45:
		begin
			RX_BUF_OBJ5_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h46:
		begin
			RX_BUF_OBJ5_BYTE_2 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h47:
		begin
			RX_BUF_OBJ5_BYTE_3 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h48:
		begin
			RX_BUF_OBJ6_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h49:
		begin
			RX_BUF_OBJ6_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h4A:
		begin
			RX_BUF_OBJ6_BYTE_2 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h4B:
		begin
			RX_BUF_OBJ6_BYTE_3 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h4C:
		begin
			RX_BUF_OBJ7_BYTE_0 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h4D:
		begin
			RX_BUF_OBJ7_BYTE_1 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h4E:
		begin
			RX_BUF_OBJ7_BYTE_2 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h4F:
		begin
			RX_BUF_OBJ7_BYTE_3 <= WR_DATA[7:0];
			ACK = 1;
						
		end //end para este caso del case
		
		'h50:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= TRANSMIT;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TRANSMIT <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		
		'h51:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= TRANSMIT_BYTE_COUNT;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TRANSMIT_BYTE_COUNT <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		
		'h51:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= TRANSMIT_BYTE_COUNT;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TRANSMIT_BYTE_COUNT <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		WR_DATA
		'h52:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= TX_BUF_HEADER_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_HEADER_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h53:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= TX_BUF_HEADER_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_HEADER_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h54:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ1_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ1_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h55:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ1_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ1_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h56:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ1_BYTE_2;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ1_BYTE_2 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h57:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ1_BYTE_3;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ1_BYTE_3 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h58:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ2_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ2_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h59:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ2_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ2_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h5A:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ2_BYTE_2;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ2_BYTE_2 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h5B:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ2_BYTE_3;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ2_BYTE_3 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
				
		'h5C:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ3_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ3_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h5D:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ3_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ3_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h5E:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ3_BYTE_2;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ3_BYTE_2 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h5F:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ3_BYTE_3;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ3_BYTE_3 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h60:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ4_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ4_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h61:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ4_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ4_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h62:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ4_BYTE_2;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ4_BYTE_2 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h63:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ4_BYTE_3;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ4_BYTE_3 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h64:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ5_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ5_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h65:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ5_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ5_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h66:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ5_BYTE_2;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ5_BYTE_2 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h67:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ5_BYTE_3;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ5_BYTE_3 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h68:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ6_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ6_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h69:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ6_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ6_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h6A:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ6_BYTE_2;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ6_BYTE_2 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h6B:
		begin
				
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ6_BYTE_3;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				TX_BUF_OBJ6_BYTE_3 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h6C:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ7_BYTE_0;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				TX_BUF_OBJ7_BYTE_0 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h6D:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ7_BYTE_1;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ7_BYTE_1 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h6E:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ7_BYTE_2;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				TX_BUF_OBJ7_BYTE_2 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h6F:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA[7:0] <=TX_BUF_OBJ7_BYTE_3;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				TX_BUF_OBJ7_BYTE_3 <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h70:
		begin
				
				RD_DATA <= VBUS_VOLTAGE;
				ACK = 1;
				
			
		end //end para este caso del case
		
		
		'h72:
		begin
		
				//Si es lectura	
				if (RNW == 1)
				begin
				RD_DATA <= VBUS_SINK_DISCONNECT_THRESHOLD;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				VBUS_SINK_DISCONNECT_THRESHOLD <= WR_DATA;
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h74:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA <= VBUS_STOP_DISCHARGE_THRESHOLD;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				VBUS_STOP_DISCHARGE_THRESHOLD <= WR_DATA;
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h76:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA <= VBUS_VOLTAGE_ALARM_HI_CFG;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				VBUS_VOLTAGE_ALARM_HI_CFG <= WR_DATA;
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h78:
		begin
				//Si es lectura
				if (RNW == 1)
				begin
				RD_DATA <= VBUS_VOLTAGE_ALARM_LO_CFG;
				ACK = 1;
				end //end if
				
				//Si es escritura
				else
				begin
				VBUS_VOLTAGE_ALARM_LO_CFG <= WR_DATA;
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		
		
		endcase
		
		end //end if
		
	//si req es 0 (o sea, si no está solicitando nada)
	else
		begin
		RD_DATA = 4'h0;
		ACK = 0;
		
		end //end else

	
	end //end always

endmodule