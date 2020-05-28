module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic c1,c2,c3,c4,c5,c6,c7;
			
		adder2 adder0(.A(A[1:0]), .B(B[1:0]), .c_in(1'b0),.S(Sum[1:0]), .c_out(c1)); //2 bit adder
		adder2 adder1(.A(A[3:2]), .B(B[3:2]), .c_in(c1),.S(Sum[3:2]), .c_out(c2)); //2 bit adder
		adder2 adder2(.A(A[5:4]), .B(B[5:4]), .c_in(c2),.S(Sum[5:4]), .c_out(c3)); //2 bit adder
		adder2 adder3(.A(A[7:6]), .B(B[7:6]), .c_in(c3),.S(Sum[7:6]), .c_out(c4)); //2 bit adder
		adder2 adder4(.A(A[9:8]), .B(B[9:8]), .c_in(c4),.S(Sum[9:8]), .c_out(c5)); //2 bit adder
		adder2 adder5(.A(A[11:10]), .B(B[11:10]), .c_in(c5),.S(Sum[11:10]), .c_out(c6)); //2 bit adder
		adder2 adder6(.A(A[13:12]), .B(B[13:12]), .c_in(c6),.S(Sum[13:12]), .c_out(c7)); //2 bit adder
		adder2 adder7(.A(A[15:14]), .B(B[15:14]), .c_in(c7),.S(Sum[15:14]), .c_out(CO)); //2 bit adder
		
endmodule
