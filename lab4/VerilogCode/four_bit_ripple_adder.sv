module four_bit_ripple_adder(input logic [3:0] A, B, 
								input logic Cin,
								output logic [3:0]Sum, 
								output logic Cout);

								
			logic c1;
			
		adder2 adder0(.A(A[1:0]), .B(B[1:0]), .c_in(Cin),.S(Sum[1:0]), .c_out(c1)); //2 bit adder
		adder2 adder1(.A(A[3:2]), .B(B[3:2]), .c_in(c1),.S(Sum[3:2]), .c_out(Cout)); //2 bit adder
								
endmodule
