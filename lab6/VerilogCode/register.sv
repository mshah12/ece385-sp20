module register #(parameter n=16) (input  logic Clk, Reset, Load,
              input  logic [n-1:0]  D,
              output logic [n-1:0]  Data_Out);

					logic [n-1:0] signal = 0;
					
    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= signal;
		 else if (Load)
			  Data_Out <= D;
    end
	
	 
endmodule
