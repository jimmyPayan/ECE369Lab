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
Instruction, rDestSelected, regWriteData, RegWrite, // Inputs
PCSel_output, RegDst_output, ALUSrc0_output, ALUSrc1_output, R_Enable_output, W_Enable_output, 
R_Width_output, W_Width_output, MemToReg_output, RegWriteOut_output, BranchSel_output, // Controller Outputs
Reg_Data1_output, Reg_Data2_output, // Register File Outputs
Imm32b_output // Sign Extend Output
);
input Clock, RegWrite;
input [31:0] Instruction, regWriteData;
input [4:0] rDestSelected;

// output // Add output signals

wire PCSel, RegDst, ALUSrc0, ALUSrc1, R_Enable, W_Enable, MemToReg, RegWriteOut;
wire [3:0] BranchSel;
wire [1:0] R_Width, W_Width;
output reg PCSel_output, RegDst_output, ALUSrc0_output, R_Enable_output, W_Enable_output, MemToReg_output, RegWriteOut_output;
output reg [3:0] BranchSel_output;
output reg [1:0] R_Width_output, W_Width_output, ALUSrc1_output;
wire RegSrc0, RegSrc1, ExtendSel;

Controller Sys_Controller(
Instruction [31:26], Instruction [20:16], Instruction [5:0], // Inputs
PCSel, 
RegSrc0, RegSrc1, /*ExtendSel,*/
RegDst, ALUSrc0, ALUSrc1,
R_Enable, W_Enable, MemToReg, RegWriteOut, R_Width, W_Width, BranchSel // Outputs
);

wire [4:0] rsSelected;
Mux5bit2to1 rs_Mux(Instruction [25:21], 31, rsSelected, RegSrc0);

wire [4:0] rtSelected;
Mux5bit2to1 rt_Mux(0, Instruction [20:16], rtSelected, RegSrc1);

wire [31:0] Reg_Data1, Reg_Data2;
output reg [31:0] Reg_Data1_output, Reg_Data2_output;

UpdatedRegisterFile Register_File(Clock, 
rsSelected, rtSelected, rDestSelected, regWriteData, RegWrite, // Inputs
Reg_Data1, Reg_Data2 // Outputs
);

wire [31:0] Imm32b;
output reg [31:0] Imm32b_output;
SignExtend16Bit Extend_Imm(Instruction[15:0], Imm32b /*, ExtendSel*/);

always @ (*) begin
PCSel_output <= PCSel;
RegDst_output <= RegDst; 
ALUSrc0_output <= ALUSrc0;
ALUSrc1_output <= ALUSrc1;
R_Enable_output <= R_Enable;
W_Enable_output <= W_Enable;
MemToReg_output <= MemToReg;
RegWriteOut_output <= RegWriteOut;
BranchSel_output <= BranchSel;
R_Width_output <= R_Width;
W_Width_output <= W_Width;
Reg_Data1_output <= Reg_Data1;
Reg_Data2_output <= Reg_Data2;
Imm32b_output <= Imm32b;
end


endmodule
