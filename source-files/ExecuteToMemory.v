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


module ExecuteToMemory(
Clock, 

// *****Inputs*****
// MEM/WB Control Signals
RegWrite_In, MemToReg_In, 
// EX/MEM Control Signals
R_Enable_In, W_Enable_In, R_Width_In, W_Width_In,
// EX/MEM Inputs
ALUResult_In, Reg_Data2_In, rDestSelected_In,

// *****Outputs*****
// MEM/WB Control Signals
RegWrite_Out, MemToReg_Out, 
// EX/MEM Control Signals
R_Enable_Out, W_Enable_Out, R_Width_Out, W_Width_Out,
// EX/MEM Outputs
ALUResult_Out, Reg_Data2_Out, rDestSelected_Out
);

input Clock;
input R_Enable_In, W_Enable_In, RegWrite_In, MemToReg_In;
input [31:0] ALUResult_In, Reg_Data2_In;
input [4:0] rDestSelected_In;
input [1:0] R_Width_In, W_Width_In;

output reg R_Enable_Out, W_Enable_Out, RegWrite_Out, MemToReg_Out;
output reg [31:0] ALUResult_Out;
output reg [31:0] Reg_Data2_Out;
output reg [4:0] rDestSelected_Out;
output reg [1:0] R_Width_Out, W_Width_Out;

always @ (posedge Clock) begin 
R_Enable_Out <= R_Enable_In;
W_Enable_Out <= W_Enable_In;
RegWrite_Out <= RegWrite_In;
MemToReg_Out <= MemToReg_In;
ALUResult_Out <= ALUResult_In;
Reg_Data2_Out <= Reg_Data2_In;
rDestSelected_Out <= rDestSelected_In;
R_Width_Out <= R_Width_In;
W_Width_Out <= W_Width_In;
end

endmodule
