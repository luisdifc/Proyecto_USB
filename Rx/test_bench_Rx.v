`include "probador_Rx.v"
`include "Rx_Module.v"

module test_bench_Rxt;

	//cables de comunicacion entre modulos
	wire clock;
	wire reset;
	wire start;
	wire [7:0] RX_BUF_FRAME_TYPE; //B2..0   110b: Received Cable Reset
	wire [15:0] ALERT; //B3 Hard Reset 
	wire [7:0] RECEIVE_DETECT;
	wire [7:0] RECEIVE_BYTE_COUNT;
	wire tx_State_Machine_ACTIVE;
	wire unexpected_GoodCRC;
	wire cC_Busy, cC_IDLE;
	wire [7:0] data_In;

	wire [15:0] ALERTo;
	wire [7:0] RECEIVE_BYTE_COUNTo;
	wire GoodCRC_to_PHYo;
	wire [7:0] DIR_WRITEo;
	wire [7:0] DATA_to_Buffero;
	

	//instancia del probador
	probador_Rx p_Rx(.CLK(clock),
					.reset(reset),
					.Start(start),
					.iRX_BUF_FRAME_TYPE(RX_BUF_FRAME_TYPE),
					.iALERT(ALERT),
					.iRECEIVE_DETECT(RECEIVE_DETECT),
					.iRECEIVE_BYTE_COUNT(RECEIVE_BYTE_COUNT),
					.Tx_State_Machine_ACTIVE(tx_State_Machine_ACTIVE),
					.Unexpected_GoodCRC(unexpected_GoodCRC),
					.CC_Busy(cC_Busy),
					.CC_IDLE(cC_IDLE),
					.Data_In(data_In),
					.oALERT(ALERTo),
					.oRECEIVE_BYTE_COUNT(RECEIVE_BYTE_COUNTo),
					.oGoodCRC_to_PHY(GoodCRC_to_PHYo),
					.oDIR_WRITE(DIR_WRITEo),
					.oDATA_to_Buffer(DATA_to_Buffero)
	);

	//instancia del registro
	Rx_Module maquinita_Rx (.CLK(clock),
					.reset(reset),
					.Start(start),
					.iRX_BUF_FRAME_TYPE(RX_BUF_FRAME_TYPE),
					.iALERT(ALERT),
					.iRECEIVE_DETECT(RECEIVE_DETECT),
					.iRECEIVE_BYTE_COUNT(RECEIVE_BYTE_COUNT),
					.Tx_State_Machine_ACTIVE(tx_State_Machine_ACTIVE),
					.Unexpected_GoodCRC(unexpected_GoodCRC),
					.CC_Busy(cC_Busy),
					.CC_IDLE(cC_IDLE),
					.Data_In(data_In),
					.oALERT(ALERTo),
					.oRECEIVE_BYTE_COUNT(RECEIVE_BYTE_COUNTo),
					.oGoodCRC_to_PHY(GoodCRC_to_PHYo),
					.oDIR_WRITE(DIR_WRITEo),
					.oDATA_to_Buffer(DATA_to_Buffero)
	);

endmodule
