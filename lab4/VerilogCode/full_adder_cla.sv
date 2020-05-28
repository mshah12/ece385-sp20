module full_adder_cla(input logic a,b,cin, output logic p,g,s,cout);
	
	assign s = a^b^cin;
	assign cout = (a&b)|(b&cin)|(a&cin);
	assign p = a ^ b;
	assign g = a&b;
endmodule
