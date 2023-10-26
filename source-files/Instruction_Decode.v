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
Instruction, PCPlusFour, rDestSelected, regWriteData, RegWrite, // Inputs
PCSel, RegDst, ALUSrc0, ALUSrc1, R_Enable, W_Enable, R_Width, W_Width, MemToReg, RegWriteOut, BranchSel, // Controller Outputs
Reg_Data1, Reg_Data2, // Register File Outputs
Imm32b // Sign Extend Output
);
input Clock, RegWrite;
input [31:0] Instruction, PCPlusFour, regWriteData;
input [4:0] rDestSelected;

// output // Add output signals

output reg PCSel, RegDst, ALUSrc0, ALUSrc1, R_Enable, W_Enable, MemToReg, RegWriteOut;
output reg [3:0] BranchSel;
output reg [1:0] R_Width, W_Width;
wire RegSrc0, RegSrc1, ExtendSel;

Controller Sys_Controller(
Instruction [31:26], Instruction [20:16], Instruction [5:0], // Inputs
PCSel, 
RegSrc0, RegSrc1, ExtendSel,
RegDst, ALUSrc0, ALUSrc1,
R_Enable, W_Enable, MemToReg, RegWriteOut, R_Width, W_Width, BranchSel // Outputs
);

wire rsSelected;
Mux5bit2to1 rs_Mux(Instruction [25:21], 31, rsSelected, RegSrc0);

wire rtSelected;
Mux5bit2to1 rt_Mux(0, Instruction [20:16], rtSelected, RegSrc1);

output reg [31:0] Reg_Data1, Reg_Data2;

UpdatedRegisterFile Register_File(Clock, 
rsSelected, rtSelected, rDestSelected, regWriteData, RegWrite, // Inputs
Reg_Data1, Reg_Data2 // Outputs
);

output reg [31:0] Imm32b;
SignExtend Extend_Imm(Instruction[15:0], Imm32b);

endmodule
