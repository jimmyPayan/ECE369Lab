`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 03:04:08 PM
// Design Name: 
// Module Name: Execute
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


module Execute(
RegDst, ALUSrc0, ALUSrc1, Shamt,
Reg_Data1, Reg_Data2, Imm32b, PCPlusFour, Instruction, Opcode, instr_index, rt, rd,

Zero, ALUResult,
j_sll_two, PC_Plus_Branch
);

input ALUSrc0, RegDst;
input [1:0] ALUSrc1;
input [4:0] Shamt, rt, rd;
input [31:0] Reg_Data1, Reg_Data2, Imm32b, PCPlusFour;
input [5:0] Instruction, Opcode;
input [25:0] instr_index;

wire [3:0] ALUControl;
wire [31:0] ALU_A, ALU_B;
wire [31:0] Imm32b_sll_two;

output reg Zero;
output reg [31:0] ALUResult;
output reg [31:0] PC_Plus_Branch;
output reg [27:0] j_sll_two;

Mux32bit2to1 ALU_A_Mux(Reg_Data1, Shamt, ALU_A, ALUSrc0);
Mux32bit4to1 ALU_B_Mux(Reg_Data2, Imm32b, 8, 10, ALU_B, ALUSrc1);
ALUControl ALU_Control(Instruction, Opcode, ALUControl);
ALU Sys_ALU(ALUControl, ALU_A, ALU_B, ALUResult, Zero);
LeftShift2 SLL_j(instr_index, j_sll_two);
LeftShift2 SLL_Imm(Imm32b, Imm32b_sll_two);
Add Branch_Adder(PCPlusFour, Imm32b_sll_two, PC_Plus_Branch);
Mux32bit2to1 regDest_Mux(rt, rd, RegDestSelected, RegDst);
endmodule

