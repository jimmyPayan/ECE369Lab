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
ShamtIn, Reg_Data1In, Reg_Data2In, Imm32bIn, rtIn, rdIn, rsIn,
// Hazard Detect Inputs
Stall_ID_EX,

// *****Outputs*****
// MEM/WB Control Signals
RegWriteOut, MemToRegOut, 
// EX/MEM Control Signals
R_EnableOut, W_EnableOut, R_WidthOut, W_WidthOut,
// ID/EX Control Signals
OpcodeOut, FunctOut, RegDstOut, ALUSrc0Out, ALUSrc1Out,
// ID/EX Outputs
ShamtOut, Reg_Data1Out, Reg_Data2Out, Imm32bOut, rtOut, rdOut, rsOut
);

input Clock;
input MemToRegIn, RegWriteIn; // Write Back Signals

input R_EnableIn, W_EnableIn; // Memory Signals
input [1:0] R_WidthIn, W_WidthIn;

input RegDstIn, ALUSrc0In;
input [1:0] ALUSrc1In; // Execute Signals + Data
input [4:0] ShamtIn, rtIn, rdIn, rsIn;
input [5:0] OpcodeIn, FunctIn; 
input [31:0] Reg_Data1In, Reg_Data2In, Imm32bIn;

input Stall_ID_EX;

output reg MemToRegOut, RegWriteOut; // Write Back Signals

output reg R_EnableOut, W_EnableOut; // Memory Signals
output reg [1:0] R_WidthOut, W_WidthOut;

output reg RegDstOut, ALUSrc0Out;
output reg [1:0] ALUSrc1Out; // Execute Signals + Data
output reg [4:0] ShamtOut, rtOut, rdOut, rsOut;
output reg [5:0] OpcodeOut, FunctOut; 
output reg [31:0] Reg_Data1Out, Reg_Data2Out, Imm32bOut;

always @ (posedge Clock) begin 

if (Stall_ID_EX == 0) begin
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
rsOut <= rsIn;
Reg_Data1Out <= Reg_Data1In;
Reg_Data2Out <= Reg_Data2In;
Imm32bOut <= Imm32bIn;

end 

else begin 

MemToRegOut <= 0;
RegWriteOut <= 0;

// Memory Signals
R_EnableOut <= 0;
R_WidthOut <= 0;
W_EnableOut <= 0;
W_WidthOut <= 0;

// Execute Signals
RegDstOut <= 0;
ALUSrc0Out <= 0;
ALUSrc1Out <= 0;
OpcodeOut <= 0;
FunctOut <= 0;

// Execute Data
ShamtOut <= 0;
rtOut <= 0;
rdOut <= 0;
rsOut <= 0;
Reg_Data1Out <= 0;
Reg_Data2Out <= 0;
Imm32bOut <= 0;

end

end

endmodule
