module top_level_unit(input logic [7:0] S, input logic 
							Clk,Reset,Run,ClearA_LoadB, 
							output logic [6:0] AhexU, AhexL, BhexU, BhexL,
							output logic [7:0] Aval, Bval,
							output logic X);

						logic m,m1, clearA, clearB, shift,addOrSub, loadA, loadB, adderEn;
						logic bshiftIn;
						logic [8:0] adderOut;
						logic tempx;
						assign X = tempx;
						logic Reset_SH, Run_SH, ClearA_LoadB_SH;

						assign Reset_SH = Reset;
						assign Run_SH = Run;
						assign ClearA_LoadB_SH = ClearA_LoadB;
						
 control_unit controlunit1 (.clk(Clk), .run(Run_SH), .reset(Reset_SH), .clearALoadB(ClearA_LoadB_SH), .m(m), 
									.clearA(clearA), .clearB(clearB), .shift(shift), .addOrSub(addOrSub), .loadA(loadA), .loadB(loadB), .adderEn(adderEn), .m1(m1)); //add = 0, sub = 1
 
 shift_register aReg (.dataIn(adderOut[7:0]), .clk(Clk), .reset(Reset_SH | clearA), .load(adderEn), .shiftEnable(shift), .shiftIn(tempx),
								.dataOut(Aval), .shiftOut(bshiftIn));							
  
 shift_register bReg (.dataIn(S), .clk(Clk), .reset(Reset_SH), .load(ClearA_LoadB_SH), .shiftEnable(shift), .shiftIn(bshiftIn),
								.dataOut(Bval), .shiftOut(m), .shiftOut2(m1));	
	
 d_flip_flop xReg (.d(adderOut[8]), .clk(Clk), .reset(clearA | Reset_SH), .load(adderEn), .q(tempx));

 nine_bit_adder adder (.A(Aval), .S(S) , .complement(addOrSub), .Sum(adderOut));
 
 
	 hex_driver        HexAL (
                        .In0(Aval[3:0]),
                        .Out0(AhexL) );
	 hex_driver        HexAU (
                        .In0(Aval[7:4]),
                        .Out0(AhexU) );	
	 hex_driver        HexBL (
                        .In0(Bval[3:0]),
                        .Out0(BhexL) );
	 hex_driver        HexBU (
                        .In0(Bval[7:4]),
                        .Out0(BhexU) );
							
	//sync button_sync[2:0] (Clk, {~Reset, ~Run, ~ClearA_LoadB}, {Reset_SH, Run_SH, ClearA_LoadB_SH}); for board
							
							
 
endmodule

module sync (
	input  logic Clk, d, 
	output logic q
);

always_ff @ (posedge Clk)
begin
	q <= d;
end

endmodule
