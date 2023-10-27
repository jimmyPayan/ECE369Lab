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
reg [4:0] Shamt;
reg [31:0] Reg_Data1, Reg_Data2;
reg [5:0] Instruction, Opcode;
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
RegDst <= 1; // rDestSelected should be 16
ALUSrc0 <= 0;
ALUSrc1 <= 0;
Shamt <= 16;
Reg_Data1 <= 108;
Reg_Data2 <= 112;
Imm32b <= 15;   // PC Plus Branch should be 64
PCPlusFour <= 4;
Instruction <= 6'b000000;
Opcode <= 6'b100000; // ALUResult should be 120
instr_index <= {2'b00, 24'hFFFFFF}; // Result should be 3FFFFFC
rt <= 5'bXXXXXX;
rd <= 16;
#100;
$finish;
end

endmodule
