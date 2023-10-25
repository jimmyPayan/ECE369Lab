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


module ExecuteToMemory
(Clock, 
R_EnableIn, W_EnableIn, BranchSelIn, RegWriteIn, MemToRegIn, ALUResult_In, rDestSelected_in, R_Width_in, W_Width_in, PC_plus_branch_in, Zero_in, RegData2_in, j_sll_two_in, 
R_EnableOut, W_EnableOut, BranchSelOut, RegWriteOut, MemToRegOut, ALUResult_Out, rDestSelected_Out, R_Width_Out, W_Width_Out, PC_plus_branch_out, Zero_out, RegData2_out, j_sll_two_out
);

input Clock;
input R_EnableIn, W_EnableIn, RegWriteIn, MemToRegIn, Zero_in;
input [3:0] BranchSelIn;
input [31:0] ALUResult_In, PC_plus_branch_in, RegData2_in;
input [4:0] rDestSelected_in;
input [1:0] R_Width_in, W_Width_in;
input [27:0] j_sll_two_in;

output reg R_EnableOut, W_EnableOut, RegWriteOut, MemToRegOut, Zero_out;
output reg [3:0] BranchSelOut;
output reg [31:0] ALUResult_Out, PC_plus_branch_out, RegData2_out;
output reg [4:0] rDestSelected_Out;
output reg [1:0] R_Width_Out, W_Width_Out;
output reg [27:0] j_sll_two_out;

always @ (posedge Clock) begin 
R_EnableOut <= R_EnableIn;
W_EnableOut <= W_EnableIn;
BranchSelOut <= BranchSelIn;
RegWriteOut <= RegWriteIn;
MemToRegOut <= MemToRegIn;
ALUResult_Out <= ALUResult_In;
PC_plus_branch_out <= PC_plus_branch_in;
RegData2_out <= RegData2_in;
rDestSelected_Out <= rDestSelected_in;
R_Width_Out <= R_Width_in;
W_Width_Out <= W_Width_in;
PC_plus_branch_out <= PC_plus_branch_in;
Zero_out <= Zero_in;
j_sll_two_out <= j_sll_two_in;
end

endmodule
