module ripple_adder_testbench();

timeunit 10ns; 

timeprecision 1ns;

logic[15:0] A;
logic[15:0] B;
logic[15:0] Sum;
logic       CO;
ripple_adder ripple(.*);

initial
begin :Test
A=16'H0000;
B=16'H0000;

#2
A=16'H0002;
B=16'HFFFF;
end

endmodule