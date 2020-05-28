module 2_bit_mux(input logic [3:0] A, B, 
						output logic Select, 
						output logic [3:0] Sum);

assign Sum = Select & A + ~Select & B;

endmodule 
