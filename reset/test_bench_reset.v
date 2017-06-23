`include "probador_reset.v"
`include "Reset_Module.v"

module test_bench_reset;

	//cables de comunicacion entre modulos
	wire clock;
	wire reset;
	wire phy_ack;
	wire [7:0] iTrans;
	wire hardR;
	wire [7:0] TRANS;
	wire [15:0] Alert;
	wire [7:0] REC_DET;
	wire [7:0] REC_B_COUNT;
	wire stop;

	//instancia del probador
	probador_reset p_reset(.CLK(clock),
					.reset(reset),
					.ioTRANSMIT(iTrans),
					.PHY_ACK(phy_ack),
					.oTRANSMIT(TRANS),
					.ALERT(Alert),
					.oRECEIVE_DETECT(REC_DET),
					.oRECEIVE_BYTE_COUNT(REC_B_COUNT),
					.PHY_Stop_Attempting_Reset(stop)
	);

	//instancia del registro
	Reset_Module maquinita_reset (.CLK(clock),
					.reset(reset),
					.ioTRANSMIT(iTrans),
					.PHY_ACK(phy_ack),
					.oTRANSMIT(TRANS),
					.ALERT(Alert),
					.oRECEIVE_DETECT(REC_DET),
					.oRECEIVE_BYTE_COUNT(REC_B_COUNT),
					.PHY_Stop_Attempting_Reset(stop)
	);
endmodule