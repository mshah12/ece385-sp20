module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
			logic cout1,cout2,cout3;
			four_bit_ripple_adder adder0(.A(A[3:0]), .B(B[3:0]),.Cin(1'b0), .Sum(Sum[3:0]), .Cout(cout1));
	   CSA_Middle_Module middle0(.A(A[7:4]), .B(B[7:4]),.Cin(cout1),.Cout(cout2), .Sum(Sum[7:4]));
	  	CSA_Middle_Module middle1(.A(A[11:8]), .B(B[11:8]), .Cin(cout2), .Cout(cout3),.Sum(Sum[11:8]));
	   CSA_Middle_Module middle2(.A(A[15:12]), .B(B[15:12]), .Cin(cout3),.Cout(CO), .Sum(Sum[15:12]));

	  
	  
endmodule
