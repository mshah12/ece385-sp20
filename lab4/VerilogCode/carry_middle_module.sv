module carry_middle_module(input logic [3:0] A,
 input logic [3:0]B,
 input logic Cin,
 output Cout,Pg,Gg, 
 output [3:0] s);
	
		 logic c1,c2,c3;
		 logic p0,p1,p2,p3,g0,g1,g2,g3;
		 assign c1 = Cin & p0 | g0;
		 assign c2 = Cin & p0 & p1 | g0 & p1 | g1;
		assign c3 = Cin & p0 & p1 & p2 | g0 & p1 & p2 | g1 & p2 | g2;

		full_adder_cla adder0( .a(A[0:0]),.b(B[0:0]),.cin(Cin), .p(p0),.g(g0),.s(s[0:0]),.cout());
		
		full_adder_cla adder1( .a(A[1:1]),.b(B[1:1]),.cin(c1), .p(p1),.g(g1),.s(s[1:1]), .cout());
		
		full_adder_cla adder2( .a(A[2:2]),.b(B[2:2]),.cin(c2), .p(p2),.g(g2),.s(s[2:2]), .cout());
		
		full_adder_cla adder3( .a(A[3:3]),.b(B[3:3]),.cin(c3), .p(p3),.g(g3),.s(s[3:3]), .cout(Cout));
		
		assign Pg = p0 & p1 & p2 & p3;
		assign Gg = g3 | g2 & p3 | g1 & p3 & p2 | g0 & p3 & p2 & p1;
		
endmodule
