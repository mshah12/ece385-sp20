module d_flip_flop(input logic d, clk, reset, load, output logic q);

	always_ff @ (posedge clk or posedge reset)
	begin
		if (reset)
			q <= 1'b0;
		else if (load)
			q <= d;
	end
	
endmodule
