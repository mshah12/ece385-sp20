module CSA_Middle_Module(input logic [3:0] A, B,
								input logic Cin,
						output logic Cout, 
						output logic [3:0] Sum);
				
				logic [3:0]	sum0, sum1;	
				logic cout1, cout0;
				logic connect;
				logic temp;
				
				four_bit_ripple_adder adder0(.A(A), .B(B), .Cin(1'b0), .Sum(sum0), .Cout(cout0));
				four_bit_ripple_adder adder1(.A(A), .B(B), .Cin(1'b1), .Sum(sum1), .Cout(cout1));
			
				two_bit_mux mux0(.A(sum1), .B(sum0), .Select(Cin), .Sum(Sum));
				
				assign connect = cout1 & Cin;
				assign Cout = cout0 | connect;
						
						
endmodule
