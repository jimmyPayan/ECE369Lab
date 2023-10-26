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


module Instruction_Fetch(Clock,
PCSel, BranchPC,
Instruction, PCPlusFour
);
input Clock;
input [31:0] BranchPC;
input PCSel;
output reg [31:0] Instruction, PCPlusFour;

wire NewPC;  

Mux32bit2to1 PC_Mux(PCPlusFour, BranchPC, NewPC, PCSel);

wire PC_To_Instr_Mem;
ProgramCounter Program_Counter(NewPC, PC_To_Instr_Mem);

Plus4Adder PC_Iterator(PC_To_Instr_Mem, PCPlusFour);
InstructionMemory Instruction_Memory(PC_To_Instr_Mem, Instruction);

endmodule