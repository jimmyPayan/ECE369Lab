`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 06:59:21 PM
// Design Name: 
// Module Name: DecodeToExecute
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


module DecodeToExecute
(Clock, 

MemToRegIn, RegWriteIn, 
R_EnableIn, W_EnableIn, R_WidthIn, W_WidthIn, BranchSelIn,
InstructionIn, OpcodeIn, RegDstIn, ALUSrc0In, ALUSrc1In, PCPlusFourIn, ShamtIn, Reg_Data1In, Reg_Data2In, Imm32bIn, rtIn, rdIn, instr_indexIn,

MemToRegOut, RegWriteOut, 
R_EnableOut, W_EnableOut, R_WidthOut, W_WidthOut, BranchSelOut,
InstructionOut, OpcodeOut, RegDstOut, ALUSrc0Out, ALUSrc1Out, PCPlusFourOut, ShamtOut, Reg_Data1Out, Reg_Data2Out, Imm32bOut, rtOut, rdOut, instr_indexOut 
);

input Clock;

input MemToRegIn, RegWriteIn; // Write Back Signals

input R_EnableIn, W_EnableIn; // Memory Signals
input [1:0] R_WidthIn, W_WidthIn;
input [3:0] BranchSelIn;

input RegDstIn, ALUSrc0In, ALUSrc1In; // Execute Signals + Data
input [4:0] ShamtIn, rtIn, rdIn;
input [5:0] InstructionIn, OpcodeIn; 
input [25:0] instr_indexIn;
input [31:0] PCPlusFourIn, Reg_Data1In, Reg_Data2In, Imm32bIn;

// Outputs of these now!
output reg MemToRegOut, RegWriteOut; // Write Back Signals

output reg R_EnableOut, W_EnableOut; // Memory Signals
output reg [1:0] R_WidthOut, W_WidthOut;
output reg [3:0] BranchSelOut;

output reg RegDstOut, ALUSrc0Out, ALUSrc1Out; // Execute Signals + Data
output reg [4:0] ShamtOut, rtOut, rdOut;
output reg [5:0] InstructionOut, OpcodeOut; 
output reg [25:0] instr_indexOut;
output reg [31:0] PCPlusFourOut, Reg_Data1Out, Reg_Data2Out, Imm32bOut;

always @ (posedge Clock) begin 
// Write Back Signals 
MemToRegOut <= MemToRegIn;
RegWriteOut <= RegWriteIn;

// Memory Signals
R_EnableOut <= R_EnableIn;
R_WidthOut <= R_WidthIn;
W_EnableOut <= W_EnableIn;
W_WidthOut <= W_WidthIn;
BranchSelOut <= BranchSelIn;

// Execute Signals
RegDstOut <= RegDstIn;
ALUSrc0Out <= ALUSrc0In;
ALUSrc1Out <= ALUSrc1In;
InstructionOut <= InstructionIn;
OpcodeOut <= OpcodeIn;

// Execute Data
ShamtOut <= ShamtIn;
rtOut <= rtIn;
rdOut <= rdIn;
instr_indexOut <= instr_indexIn;
PCPlusFourOut <= PCPlusFourIn;
Reg_Data1Out <= Reg_Data1In;
Reg_Data2Out <= Reg_Data2In;
Imm32bOut <= Imm32bIn;



end

endmodule
