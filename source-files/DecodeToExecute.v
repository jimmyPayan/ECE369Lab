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
InstrIn, OpcodeIn, RegDstIn, ALUSrc0In, ALUSrc1In,
R_EnableIn, W_EnableIn, BranchSelIn, RegWriteIn, MemToRegIn, R_CommandIn, W_CommandIn,

InstrOut, OpcodeOut, RegDstOut, ALUSrc0Out, ALUSrc1Out, 
R_EnableOut, W_EnableOut, BranchSelOut, RegWriteOut, MemToRegOut, R_CommandOut, W_CommandOut
);

input Clock;
input InstrIn, OpcodeIn, RegDstIn, ALUSrc0In, ALUSrc1In;
input R_EnableIn, W_EnableIn, RegWriteIn, MemToRegIn;
input [3:0] BranchSelIn;
input [2:0] R_CommandIn, W_CommandIn;

output reg InstrOut, OpcodeOut, RegDstOut, ALUSrc0Out, ALUSrc1Out;
output reg R_EnableOut, W_EnableOut, RegWriteOut, MemToRegOut;
output reg [3:0] BranchSelOut;
output reg [2:0] R_CommandOut, W_CommandOut;

always @ (posedge Clock) begin 
InstrOut <= InstrIn;
OpcodeOut <= OpcodeIn;
RegDstOut <= RegDstIn;
ALUSrc0Out <= ALUSrc0In;
ALUSrc1Out <= ALUSrc1In;
R_EnableOut <= R_EnableIn;
W_EnableOut <= W_EnableIn;
BranchSelOut <= BranchSelIn;
RegWriteOut <= RegWriteIn;
MemToRegOut <= MemToRegIn;
W_CommandOut <= W_CommandIn;
R_CommandOut <= R_CommandIn;
end

endmodule
