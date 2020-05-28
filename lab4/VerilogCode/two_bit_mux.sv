module two_bit_mux(input logic [3:0] A, B, 
						input logic Select, 
						output logic [3:0] Sum);

always_comb
begin
if (Select == 1'b1)
	Sum = A;
	else
	Sum = B;

end

endmodule 
