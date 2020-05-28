module shift_register(input logic [7:0] dataIn, input logic clk, reset, load, shiftEnable, shiftIn,
								output logic [7:0] dataOut, output logic shiftOut, output logic shiftOut2);
								
	always_ff @ (posedge clk)
	begin
		if (reset)
			dataOut <= 8'b0;
		else if (load)
			dataOut <= dataIn;
		else if (shiftEnable)
		begin
			dataOut[6:0] <= dataOut[7:1];
			dataOut[7] <= shiftIn;
		end
	end
	
	assign shiftOut = dataOut[0];
	assign shiftOut2 = dataOut[1];							
endmodule
