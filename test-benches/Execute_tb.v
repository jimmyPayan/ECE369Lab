`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 10:48:48 PM
// Design Name: 
// Module Name: Execute_tb
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


module Execute_tb();
reg [4:0] RegDst, rt, rd;
reg [31:0] ALUSrc0, ALUSrc1,Imm32b, PCPlusFour;
reg [4:0] Shamt, Reg_Data1, Reg_Data2, Opcode;
reg [5:0] Instruction;
reg [25:0] instr_index;

wire Zero_output;
wire [31:0] ALUResult_output;
wire [27:0] j_sll_two_output;
wire [31:0] PC_Plus_Branch_output;
wire [4:0] RegDestSelected_output;

Execute Execute_test(
RegDst, ALUSrc0, ALUSrc1, Shamt,
Reg_Data1, Reg_Data2, Imm32b, PCPlusFour, Instruction, Opcode, instr_index, rt, rd,

Zero_output, ALUResult_output,
j_sll_two_output, PC_Plus_Branch_output, RegDestSelected_output
);

initial begin

// add $16, $8, $12
RegDst <= 0;
ALUSrc0 <= 0;
ALUSrc1 <= 1;
Shamt <= 16;
end

endmodule
