module datapath(input logic [15:0] MDR, adderMux, PC, ALU, 
						input logic GatePC, GateMDR, GateALU, GateMARMUX,
						output logic [15:0] databus);

			logic [3:0] control;
		assign control	= {GatePC, GateMDR, GateALU,GateMARMUX};
			
			always_comb
				begin
					unique case(control)
					4'b1000: 
					databus = PC;
					4'b0100:
					databus = MDR;
					4'b0010:
					databus = ALU;
					4'b0001:
					databus = adderMux;
					default:
					databus = 16'HXXXX;
					endcase
				end
endmodule
