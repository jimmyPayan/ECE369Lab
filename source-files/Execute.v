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
wire [31:0] ALU_A_Final, ALU_B_Final;
wire [31:0] Shamtout;
wire [31:0] ALUResult;
wire [31:0] PC_Plus_Branch;
wire [4:0] RegDestSelected;

output reg [31:0] ALUResult_output;
output reg [31:0] PC_Plus_Branch_output;
output reg [4:0] RegDestSelected_output;


SignExtend5to32 shamtExtend(sa, Shamtout);

Mux32bit2to1 ALU_A0_Mux(Reg_Data1, Shamtout, ALU_A0, ALUSrc0);
Mux32bit4to1 ALU_B0_Mux(Reg_Data2, Imm32b, 8, 10, ALU_B0, ALUSrc1);

Mux32bit2to1 ALU_A1_Mux(ALU_A0, );
Mux32bit2to1 ALU_B1_Mux();

ALUControl ALU_Control(Opcode, Funct, ALUControl);
ALU Sys_ALU(ALUControl, ALU_A0, ALU_B0, ALUResult, Zero);

Mux5bit2to1 regDest_Mux(rt, rd, RegDestSelected, RegDst);

always @(*) begin
ALUResult_output <= ALUResult;
PC_Plus_Branch_output <= PC_Plus_Branch;
RegDestSelected_output <= RegDestSelected;
end

endmodule
