module Registros(ADDR, RNW, WR_DATA, RD_DATA, req, ACK);

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
		  TX_BUF_OBJ7_BYTE_0, TX_BUF_OBJ7_BYTE_1, TX_BUF_OBJ7_BYTE_2, TX_BUF_OBJ7_BYTE_3;
		  
		  
always @*
	begin
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
			end
			
			'h0A:
			begin
				RD_DATA <= PD_INTERFACE_REV;
				ACK = 1;
			
			end //end para este valor específico del case
			
			'h10:
			begin
				if (RNW == 1)
				begin
				RD_DATA <= ALERT;
				end //end if
				
				else
				begin
				ALERT <= WR_DATA;
				ACK = 1;
				end //end else
			
			end //end para este caso del case
		
		'h12:
		begin
				if (RNW == 1)
				begin
				RD_DATA <= ALERT_MASK;
				ACK = 1;
				end //end if
				
				else
				begin
				ALERT_MASK <= WR_DATA;
				ACK = 1;
				end //end else
			
		end //end para este caso del case
			
		
		'h14:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= POWER_STATUS_MASK;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
				else
				begin
				POWER_STATUS_MASK <= WR_DATA[7:0];
				ACK = 1;
				end //end else
			
		end //end para este caso del case
		
		'h15:
		begin
				if (RNW == 1)
				begin
				RD_DATA[7:0] <= FAULT_STATUS_MASK;
				RD_DATA[15:8] <= 8'b0;
				ACK = 1;
				end //end if
				
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
		
		
		endcase
		
		end //end if
		
	//si req es 0
	else
		begin
		RD_DATA = 2'h0;
		ACK = 1;
		
		end //end else

	
	end //end always



endmodule
