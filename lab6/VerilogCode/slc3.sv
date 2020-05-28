//------------------------------------------------------------------------------
// Company:        UIUC ECE Dept.
// Engineer:       Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 6 Given Code - SLC-3 
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 10-19-2017 
//    spring 2018 Distribution
//
//------------------------------------------------------------------------------
module slc3(
    input logic [15:0] S,
    input logic Clk, Reset, Run, Continue,
    output logic [11:0] LED,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
    output logic CE, UB, LB, OE, WE,
    output logic [19:0] ADDR,
    inout wire [15:0] Data //tristate buffers need to be of type wire
);


// Declaration of push button active high signals
logic Reset_ah, Continue_ah, Run_ah;

assign Reset_ah = ~Reset;
assign Continue_ah = ~Continue;
assign Run_ah = ~Run;
// Internal connections
logic BEN;
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX;
logic MIO_EN;

logic [15:0] MDR_In;
logic [15:0] MAR, MDR, IR, PC;
logic [15:0] Data_from_SRAM, Data_to_SRAM;

//User defined Logic 
logic [15:0] databus, PC_IN,MDR_OUT,A1A2OUT,ADDR1_OUT,ADDR2_OUT,SR2_OUT
,A_IN,B_IN,Alu_Connect;
logic [15:0] pc_incremented;
assign pc_incremented = PC + 16'H0001;
logic[2:0] DRMUX_IN,SR2,SR1,NZP_IN,NZP_OUT;
assign A1A2OUT = ADDR2_OUT + ADDR1_OUT;
logic BEN_IN;

assign LED = {12{LD_LED}} & IR[11:0];
// Signals being displayed on hex display 
logic [3:0][3:0] hex_4;

// For week 1, hexdrivers will display IR. Comment out these in week 2.
//HexDriver hex_driver3 (IR[15:12], HEX3);
//HexDriver hex_driver2 (IR[11:8], HEX2);
//HexDriver hex_driver1 (IR[7:4], HEX1);
//HexDriver hex_driver0 (IR[3:0], HEX0);

// For week 2, hexdrivers will be mounted to Mem2IO
 HexDriver hex_driver3 (hex_4[3][3:0], HEX3);
 HexDriver hex_driver2 (hex_4[2][3:0], HEX2);
 HexDriver hex_driver1 (hex_4[1][3:0], HEX1);
 HexDriver hex_driver0 (hex_4[0][3:0], HEX0);

// The other hex display will show PC for both weeks.
HexDriver hex_driver7 (PC[15:12], HEX7);
HexDriver hex_driver6 (PC[11:8], HEX6);
HexDriver hex_driver5 (PC[7:4], HEX5);
HexDriver hex_driver4 (PC[3:0], HEX4);

// Connect MAR to ADDR, which is also connected as an input into MEM2IO.
// MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
// input into MDR)
assign ADDR = { 4'b00, MAR }; //Note, our external SRAM chip is 1Mx16, but address space is only 64Kx16
assign MIO_EN = ~OE;

// You need to make your own datapath module and connect everything to the datapath
// Be careful about whether Reset is active high or low
datapath d0 (.MDR(MDR), .adderMux(A1A2OUT),.PC(PC),.ALU(Alu_Connect), .GatePC(GatePC), 
.GateMDR(GateMDR), .GateALU(GateALU), .GateMARMUX(GateMARMUX),.databus(databus));


// Our SRAM and I/O controller
Mem2IO memory_subsystem(
    .*, .Reset(Reset_ah), .ADDR(ADDR), .Switches(S),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]),
    .Data_from_CPU(MDR), .Data_to_CPU(MDR_In),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// The tri-state buffer serves as the interface between Mem2IO and SRAM
tristate #(.N(16)) tr0(
    .Clk(Clk), .tristate_output_enable(~WE), .Data_write(Data_to_SRAM), .Data_read(Data_from_SRAM), .Data(Data)
);

// State machine and control signals
ISDU state_controller(
    .*, .Reset(Reset_ah), .Run(Run_ah), .Continue(Continue_ah),
    .Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
    .Mem_CE(CE), .Mem_UB(UB), .Mem_LB(LB), .Mem_OE(OE), .Mem_WE(WE)
);

//My code (Week 2)
//Right side
ALU alu_unit(.B(B_IN), .A(A_IN),.ALUK(ALUK), .ALU_OUT(Alu_Connect)); //00=ADD,01=AND,10=NOT,11=PASS A
mux2 sr2_mux(.d0({{11{IR[4]}},IR[4:0]}),.d1(SR2_OUT),.d2(),.d3(),.s({1'b0,SR2MUX}), .y(B_IN)); //00=sextIR 01=SR2OUT
REGFILE reg_file(.datapath(databus), .DRMUX_IN(DRMUX_IN),
					.SR1_IN(SR1),.SR2_IN(IR[2:0]),.LD_REG(LD_REG),.Clk(Clk),.Reset(Reset_ah),.SR2(SR2_OUT), .SR1(A_IN));
					
mux2 #(3) sr1_mux (.d0(IR[11:9]),.d1(IR[8:6]),.d2(),.d3(),.s({1'b0,SR1MUX}), .y(SR1));//00=Ir[11:9] 01=IR[8:6]					

mux2 #(3) dr_mux (.d0(3'b111),.d1(IR[11:9]),.d2(),.d3(),.s({1'b0,DRMUX}), .y(DRMUX_IN));//00=111 01 =IR[11:9]

//Left Side
mux2 addr2_mux (.d0({{5{IR[10]}},IR[10:0]}),.d1({{7{IR[8]}},IR[8:0]}),.d2({{10{IR[5]}},IR[5:0]}),.d3(16'h0),.s({ADDR2MUX}), .y(ADDR2_OUT));//00 = IR[10:0], 01=IR[8:0], 10=IR[5:0], 11 = 16'h0
mux2 addr1_mux (.d0(A_IN),.d1(PC),.d2(),.d3(),.s({1'b0,ADDR1MUX}), .y(ADDR1_OUT));//00=sr1out, 01=PC
always_comb
begin	
	if(databus == 16'b0)
	begin
		NZP_IN = {1'b0,1'b1,1'b0};
	end
	else if(databus[15] == 1'b1)
	begin
		NZP_IN = {1'b1,1'b0,1'b0};
	end
	else	
	begin
		NZP_IN = {1'b0,1'b0,1'b1};
	end
end
register #(3) nzp_reg (.Clk(Clk), .Reset(Reset_ah), .Load(LD_CC),.D(NZP_IN), .Data_Out(NZP_OUT)); 
/*always_comb
begin
	if(NZP_OUT[2] == IR[11])
	begin
	BEN_IN = 1'b1;
	end
	else if(NZP_OUT[1] == IR[10])
	begin
	BEN_IN = 1'b1;
	end
	else if(NZP_OUT[0] == IR[9])
	begin
	BEN_IN = 1'b1;
	end
	else
	begin
	BEN_IN = 1'b0;
	end
end*/
always_comb
begin
BEN_IN = (IR[11] & NZP_OUT[2]) | (IR[10] & NZP_OUT[1]) | (IR[9] & NZP_OUT[0]);
end
register #(1) ben_reg (.Clk(Clk), .Reset(Reset_ah), .Load(LD_BEN),.D(BEN_IN), .Data_Out(BEN)); 
//My CODE (Week 1)
register PCReg(.Clk(Clk), .Reset(Reset_ah), .Load(LD_PC),.D(PC_IN),.Data_Out(PC));

register MARReg(.Clk(Clk), .Reset(Reset_ah), .Load(LD_MAR),.D(databus),.Data_Out(MAR));

register MDRReg(.Clk(Clk), .Reset(Reset_ah), .Load(LD_MDR),.D(MDR_OUT),.Data_Out(MDR));

register IRReg(.Clk(Clk), .Reset(Reset_ah), .Load(LD_IR),.D(databus),.Data_Out(IR));
				 
mux2 pc_mux(.d0(databus),.d1(A1A2OUT),.d2(pc_incremented),.d3(), .s(PCMUX),.y(PC_IN));//00=databus, 01=A1A2OUT, 10=PC +1
		
mux2 mdr_mux(.d0(databus),.d1(MDR_In),.d2(),.d3(), .s({1'b0, MIO_EN}), .y(MDR_OUT)); 







	
endmodule

module mux2 #(parameter width =16) (input logic [width-1:0] d0,d1,d2,d3,
												input logic [1:0] s, 
												output logic [width-1:0] y);

always_comb 
	begin 
		case(s)
		2'b00:
		y = d0;
		2'b01:
		y = d1;
		2'b10:
		y = d2;
		default:
		y = d3;
		
		endcase
	end

endmodule

//00=ADD,01=AND,10=NOT,11=PASS A
module ALU(input logic[15:0] B, A,
				input logic[1:0] ALUK, 
				output logic[15:0] ALU_OUT);
			always_comb
			begin
				case(ALUK)
					2'b00:
						ALU_OUT = A + B;
					2'b01:
						ALU_OUT = A & B;
					2'b10:
						ALU_OUT = ~A;
					default:
						ALU_OUT = A;
				endcase
			end
endmodule

module REGFILE(input logic[15:0] datapath, input[2:0] DRMUX_IN,
					SR1_IN,SR2_IN ,input logic LD_REG,Clk,Reset,output logic[15:0] SR2, SR1);
								
			logic[15:0] regs[8];

				always_ff @ (posedge Clk)
				begin
				if(Reset)
					begin
						for(int i=0;i<8;i++)
						begin 
							regs[i] <= 16'h0;
						end
					end
					if(LD_REG == 1'b1)
						begin
						regs[DRMUX_IN] <= datapath;
						end
				end
				always_comb
					begin		
						SR1 = regs[SR1_IN];	
						SR2 = regs[SR2_IN];
					end
endmodule


