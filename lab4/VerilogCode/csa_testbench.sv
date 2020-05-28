module csa_testbench();
timeunit 10ns; //half clock cycle lasts for 10 ns 
timeprecision 1ns; //round delay to nearest decimal 

logic[15:0] A;
logic[15:0] B;
logic[15:0] Sum;
logic       CO;
carry_select_adder module1(.*);
initial 
begin:TestVectors

A=16'H0000;
B=16'H0000;

#2
A=16'H0001;
B=16'HFFFF;

#2
A=16'H0002;
B=16'HFFFF;
#2
A=16'H0003;
B=16'HFFFF;

#2
A=16'H0000;
B=16'HF0FF;
end



endmodule
