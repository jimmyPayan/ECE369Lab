`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 01:56:51 PM
// Design Name: 
// Module Name: Instruction_Fetch
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


module Instruction_Fetch(
Clock,
PCSel, BranchPC,
Instruction_output, PCPlusFour_output, PC_To_Instr_Mem_output
);
input Clock;
input [31:0] BranchPC;
input PCSel;
wire [31:0] Instruction; 
wire [31:0] PCPlusFour;
output reg [31:0] Instruction_output; 
output reg [31:0] PCPlusFour_output;
output reg [31:0] PC_To_Instr_Mem_output;

wire [31:0] NewPC;  
Mux32bit2to1 PC_Mux(PCPlusFour, BranchPC, NewPC, PCSel);

wire [31:0] PC_To_Instr_Mem;
ProgramCounter Program_Counter(NewPC, PC_To_Instr_Mem, Clock);

Plus4Adder PC_Iterator(PC_To_Instr_Mem, PCPlusFour);

InstructionMemory Instruction_Memory(PC_To_Instr_Mem, Instruction);

always @ (*) begin
Instruction_output <= Instruction;
PCPlusFour_output <= PCPlusFour;
PC_To_Instr_Mem_output <= PC_To_Instr_Mem;
end

endmodule