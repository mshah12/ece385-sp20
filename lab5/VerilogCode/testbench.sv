module testbench();
timeunit 10ns;	// Half clock cycle for 10ns
			// This is the amount of time represented by #1 
timeprecision 1ns; //round amount of time to nearest decimal point


logic [7:0] S;
logic Clk = 0,Reset,Run,ClearA_LoadB;
logic [6:0] AhexU, AhexL, BhexU, BhexL;
logic [7:0] Aval, Bval;
logic X;

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end
initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

top_level_unit test (.*);

initial 
begin
Reset = 1'b1;

#2
S = 8'h02;
Reset = 1'b0;
Run = 1'b0;
ClearA_LoadB = 1'b1;

#2
S = 8'hFF;
Reset = 1'b0;
Run = 1'b1;
ClearA_LoadB = 1'b0;

#20
S = 8'h02;
Reset = 1'b0;
Run = 1'b0;
ClearA_LoadB = 1'b1;

#2
S = 8'h01;
Reset = 1'b0;
Run = 1'b1;
ClearA_LoadB = 1'b0;

#20
S = 8'hFF;
Reset = 1'b0;
Run = 1'b0;
ClearA_LoadB = 1'b1;
#2
S = 8'hFF;
Reset = 1'b0;
Run = 1'b1;
ClearA_LoadB = 1'b0;
#35
S = 8'hFF;
Reset = 1'b0;
Run = 1'b0;
ClearA_LoadB = 1'b1;
#2
S = 8'h02;
Reset = 1'b0;
Run = 1'b1;
ClearA_LoadB = 1'b0;

#35
S = 8'h00;
Reset = 1'b0;
Run = 1'b0;
ClearA_LoadB = 1'b0;

end



endmodule
