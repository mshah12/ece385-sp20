module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
		logic c0,c4,c8,c12;
		logic pg0, pg4,pg8;
		logic gg0, gg4,gg8;
		assign c4 = gg0 | c0 & pg0;
		assign c8 = gg4 | gg0 & pg4 | c0 & pg0 & pg4;
		assign c12 = gg8 | gg4 & pg8 | gg0 & pg8 & pg4 | c0 & pg8 & pg4 & pg0;
	  carry_middle_module adder0(.A(A[3:0]),.B(B[3:0]),.Cin(1'b0),.Cout(c0),.Pg(pg0),.Gg(gg0), .s(Sum[3:0]));
	  carry_middle_module adder1(.A(A[7:4]),.B(B[7:4]),.Cin(c4),.Cout(),.Pg(pg4),.Gg(gg4), .s(Sum[7:4]));
	  carry_middle_module adder2(.A(A[11:8]),.B(B[11:8]),.Cin(c8),.Cout(),.Pg(pg8),.Gg(gg8), .s(Sum[11:8]));
	  carry_middle_module adder3(.A(A[15:12]),.B(B[15:12]),.Cin(c12),.Cout(CO),.Pg(),.Gg(), .s(Sum[15:12]));

	  
endmodule
