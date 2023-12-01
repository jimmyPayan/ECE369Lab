`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 06:59:21 PM
// Design Name: 
// Module Name: MemoryToWriteBack
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


module MemoryToWriteBack(
Clock, 

// Inputs
RegWrite_In, MemToReg_In, R_Data_In, ALUResult_In, rDestSelected_In,

// Outputs
RegWrite_Out, MemToReg_Out, R_Data_Out, ALUResult_Out, rDestSelected_Out
);
input Clock;
input RegWrite_In, MemToReg_In;
input [31:0] ALUResult_In, R_Data_In;
input [4:0] rDestSelected_In;

output reg RegWrite_Out, MemToReg_Out;
output reg [31:0] ALUResult_Out, R_Data_Out;
output reg [4:0] rDestSelected_Out;

always @ (posedge Clock) begin 
RegWrite_Out <= RegWrite_In;
MemToReg_Out <= MemToReg_In;
ALUResult_Out <= ALUResult_In;
R_Data_Out <= R_Data_In;
rDestSelected_Out <= rDestSelected_In;
end

endmodule
