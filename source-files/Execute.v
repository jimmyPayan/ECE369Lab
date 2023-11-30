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
// Control signals
ALUSrcA0, ALUSrcB0, ALUSrcA1, ALUSrcB1, RegDst, Opcode, Funct,

// A0 B0 A1 B1 regDest mux inputs from ID 
Reg_Data1, Reg_Data2, dont_care_A1, dont_care_B1, rt, rd,

// Raw inputs
sa, Imm32b,

// Outputs
ALUResult_output, PC_Plus_Branch_output, RegDestSelected_output
);

input ALUSrcA0, RegDst, ALUSrcA1, ALUSrcB1;
input [1:0] ALUSrcB0;
input [4:0] sa, rt, rd;
input [31:0] Reg_Data1, Reg_Data2, Imm32b;
input [5:0] Opcode, Funct;
input [31:0] dont_care_A1, dont_care_B1;


wire [3:0] ALUControl;
wire [31:0] ALU_A1, ALU_B1;
wire [31:0] ALU_A0, ALU_B0;
wire [31:0] Shamt_sll_two;
wire [31:0] ALUResult;
wire [31:0] PC_Plus_Branch;
wire [4:0] RegDestSelected;
wire Zero; // sure if we need a zero bit we have one but we don't

output reg [31:0] ALUResult_output;
output reg [31:0] PC_Plus_Branch_output;
output reg [4:0] RegDestSelected_output;

SignExtend5to32 shamtExtend(sa, Shamt_sll_two);

Mux32bit2to1 ALU_A0_Mux(Reg_Data1, Shamt_sll_two, ALU_A0, ALUSrcA0);
Mux32bit4to1 ALU_B0_Mux(Reg_Data2, Imm32b, 8, 32'hXXXXXXXX, ALU_B0, ALUSrcB0);

Mux32bit2to1 ALU_A1_Mux(ALU_A0, 32'hZZZZXXXX, ALU_A1, ALUSrcA1);
Mux32bit2to1 ALU_B1_Mux(ALU_B0, 32'hXXXXZZZZ, ALU_B1, ALUSrcB1);

ALUControl ALU_Control(Opcode, Funct, ALUControl);
ALU Sys_ALU(ALUControl, ALU_A1, ALU_B1, ALUResult, Zero);

Mux5bit2to1 regDest_Mux(rt, rd, RegDestSelected, RegDst);

always @(*) begin
ALUResult_output <= ALUResult;
PC_Plus_Branch_output <= PC_Plus_Branch;
RegDestSelected_output <= RegDestSelected;
end

endmodule
