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
// *****Inputs*****
// MEM/WB Control Signals
RegWriteIn, MemToRegIn, 
// EX/MEM Control Signals
R_EnableIn, W_EnableIn, R_WidthIn, W_WidthIn,
// ID/EX Control Signals
OpcodeIn, FunctIn, RegDstIn, ALUSrc0In, ALUSrc1In,
// ID/EX Inputs
ShamtIn, Reg_Data1In, Reg_Data2In, Imm32bIn, rtIn, rdIn,

// *****Outputs*****
// MEM/WB Control Signals
RegWriteOut, MemToRegOut, 
// EX/MEM Control Signals
R_EnableOut, W_EnableOut, R_WidthOut, W_WidthOut,
// ID/EX Control Signals
OpcodeOut, FunctOut, RegDstOut, ALUSrc0Out, ALUSrc1Out,
// ID/EX Outputs
ShamtOut, Reg_Data1Out, Reg_Data2Out, Imm32bOut, rtOut, rdOut
);

input Clock;
input MemToRegIn, RegWriteIn; // Write Back Signals

input R_EnableIn, W_EnableIn; // Memory Signals
input [1:0] R_WidthIn, W_WidthIn;

input RegDstIn, ALUSrc0In;
input [1:0] ALUSrc1In; // Execute Signals + Data
input [4:0] ShamtIn, rtIn, rdIn;
input [5:0] OpcodeIn, FunctIn; 
input [31:0] Reg_Data1In, Reg_Data2In, Imm32bIn;

output reg MemToRegOut, RegWriteOut; // Write Back Signals

output reg R_EnableOut, W_EnableOut; // Memory Signals
output reg [1:0] R_WidthOut, W_WidthOut;

output reg RegDstOut, ALUSrc0Out;
output reg [1:0] ALUSrc1Out; // Execute Signals + Data
output reg [4:0] ShamtOut, rtOut, rdOut;
output reg [5:0] OpcodeOut, FunctOut; 
output reg [31:0] Reg_Data1Out, Reg_Data2Out, Imm32bOut;

always @ (posedge Clock) begin 
// Write Back Signals 
MemToRegOut <= MemToRegIn;
RegWriteOut <= RegWriteIn;

// Memory Signals
R_EnableOut <= R_EnableIn;
R_WidthOut <= R_WidthIn;
W_EnableOut <= W_EnableIn;
W_WidthOut <= W_WidthIn;

// Execute Signals
RegDstOut <= RegDstIn;
ALUSrc0Out <= ALUSrc0In;
ALUSrc1Out <= ALUSrc1In;
OpcodeOut <= OpcodeIn;
FunctOut <= FunctIn;

// Execute Data
ShamtOut <= ShamtIn;
rtOut <= rtIn;
rdOut <= rdIn;
Reg_Data1Out <= Reg_Data1In;
Reg_Data2Out <= Reg_Data2In;
Imm32bOut <= Imm32bIn;



end

endmodule
