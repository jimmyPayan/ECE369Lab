`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 06:59:21 PM
// Design Name: 
// Module Name: ExecuteToMemory
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


module ExecuteToMemory(Clock, 
R_EnableIn, W_EnableIn, BranchSelIn, RegWriteIn, MemToRegIn, ALUResultIn, rDestSelectedIn, 
R_WidthIn, W_WidthIn, PCPlusBranchIn, ZeroIn, RegData2In, jumpLeftShiftedTwoIn, 

R_EnableOut, W_EnableOut, BranchSelOut, RegWriteOut, MemToRegOut, ALUResultOut, rDestSelectedOut, 
R_WidthOut, W_WidthOut, PCPlusBranchOut, ZeroOut, RegData2Out, jumpLeftShiftedTwoOut
);

input Clock;
input R_EnableIn, W_EnableIn, RegWriteIn, MemToRegIn, ZeroIn;
input [3:0] BranchSelIn;
input [31:0] ALUResultIn, PCPlusBranchIn, RegData2In;
input [4:0] rDestSelectedIn;
input [1:0] R_WidthIn, W_WidthIn;
input [27:0] jumpLeftShiftedTwoIn;

output reg R_EnableOut, W_EnableOut, RegWriteOut, MemToRegOut, ZeroOut;
output reg [3:0] BranchSelOut;
output reg [31:0] ALUResultOut;
output reg [31:0] PCPlusBranchOut;
output reg [31:0] RegData2Out;
output reg [4:0] rDestSelectedOut;
output reg [1:0] R_WidthOut, W_WidthOut;
output reg [27:0] jumpLeftShiftedTwoOut;

always @ (posedge Clock) begin 
R_EnableOut <= R_EnableIn;
W_EnableOut <= W_EnableIn;
BranchSelOut <= BranchSelIn;
RegWriteOut <= RegWriteIn;
MemToRegOut <= MemToRegIn;
ALUResultOut <= ALUResultIn;
PCPlusBranchOut <= PCPlusBranchIn;
RegData2Out <= RegData2In;
rDestSelectedOut <= rDestSelectedIn;
R_WidthOut <= R_WidthIn;
W_WidthOut <= W_WidthIn;
PCPlusBranchOut <= PCPlusBranchIn;
ZeroOut <= ZeroIn;
jumpLeftShiftedTwoOut <= jumpLeftShiftedTwoIn;
end

endmodule
