`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 03:01:39 PM
// Design Name: 
// Module Name: Instruction_Decode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Decode(
Clock,

// ****Inputs****
// Standard ID Stage
Instruction, PCPlusFour, rDestSelected_ID, regWriteData, RegWrite, 
// Hazard Detection
rt_EX, rd_EX, rDestSelected_MEM, Opcode_EX, Opcode_MEM,

// ****Outputs****
// IF Control Signals
PCSel_output, BranchPC_output,
// MEM/WB Control Signals
RegWriteOut_output, MemToReg_output,
// EX/MEM Control Signals
R_Enable_output, W_Enable_output, R_Width_output, W_Width_output, 
// ID/EX Control Signals
RegDst_output, ALUSrc1_output, ALUSrc0_output,
// ID Data Outputs
Reg_Data1_output, Reg_Data2_output, Imm32b_output,

// Hazard Detection Outputs
Stall_PC_output, Stall_ID_output, Stall_ID_EX_output
);

input Clock, RegWrite;
input [31:0] Instruction, regWriteData, PCPlusFour;
input [5:0] Opcode_EX, Opcode_MEM;
input [4:0] rDestSelected_ID, rDestSelected_MEM, rt_EX, rd_EX;

wire PCSel, RegDst, ALUSrc0, R_Enable, W_Enable, MemToReg, RegWriteOut;
wire [3:0] BranchSel;
wire [1:0] R_Width, W_Width, ALUSrc1;
output reg PCSel_output, Stall_PC_output, Stall_ID_output, Stall_ID_EX_output, RegDst_output, ALUSrc0_output, R_Enable_output, W_Enable_output, MemToReg_output, RegWriteOut_output;
output reg [1:0] R_Width_output, W_Width_output, ALUSrc1_output;
output reg [31:0] BranchPC_output;
wire RegSrc0, RegSrc1, ExtendSel;

Controller Sys_Controller(
// Inputs
Instruction [31:26], Instruction [5:0], 

// Outputs
RegSrc0, RegSrc1,
RegDst, ALUSrc0, ALUSrc1, 
R_Enable, W_Enable, R_Width, W_Width, 
MemToReg, RegWriteOut
);

wire [4:0] rsSelected;
Mux5bit2to1 rs_Mux(Instruction [25:21], 31, rsSelected, RegSrc0);

wire [4:0] rtSelected;
Mux5bit2to1 rt_Mux(0, Instruction [20:16], rtSelected, RegSrc1);

wire [31:0] Reg_Data1, Reg_Data2;
output reg [31:0] Reg_Data1_output, Reg_Data2_output;

UpdatedRegisterFile Register_File(Clock, 
// Inputs
rsSelected, rtSelected, rDestSelected_ID, regWriteData, RegWrite,
// Outputs 
Reg_Data1, Reg_Data2 
);

wire [31:0] Imm32b, BranchPC;
output reg [31:0] Imm32b_output;
SignExtend16Bit Extend_Imm(
// inputs
Instruction[15:0], 
// outputs
Imm32b);

// Left shift should not be its own module.
wire [31:0] PC_Plus_Branch;
Add Branch_adder(
// inputs
PCPlusFour, (Imm32b << 2), 
// outputs
PC_Plus_Branch);

PCSrcControl PCSrc_Control(
// inputs
Instruction, PC_Plus_Branch, Reg_Data1, Reg_Data2, 
// outputs
PCSel, BranchPC);

wire Stall_PC;
HazardDetection Hazard_Detect(
// Inputs
Instruction [25:21], Instruction [20:16], Opcode_EX, Opcode_MEM, rDestSelected_MEM, rt_EX, rd_EX,

// Outputs
Stall_ID, Stall_PC, Stall_ID_EX
);
// Call: (ID_rs, ID_rt, ex_opcode, mem_opcode, mem_rDestSelected, EX_rt, EX_rd, output signals)

always @ (*) begin
PCSel_output <= PCSel;
RegDst_output <= RegDst; 
ALUSrc0_output <= ALUSrc0;
ALUSrc1_output <= ALUSrc1;
R_Enable_output <= R_Enable;
W_Enable_output <= W_Enable;
MemToReg_output <= MemToReg;
RegWriteOut_output <= RegWriteOut;
R_Width_output <= R_Width;
W_Width_output <= W_Width;
Reg_Data1_output <= Reg_Data1;
Reg_Data2_output <= Reg_Data2;
Imm32b_output <= Imm32b;

// Hazard Detection / Moving PCSrc to ID Stage Signals
BranchPC_output <=  BranchPC;
PCSel_output <= PCSel;
Stall_PC_output <= Stall_PC;
Stall_ID_output <= Stall_ID;
Stall_ID_EX_output <= Stall_ID_EX;
end

endmodule
