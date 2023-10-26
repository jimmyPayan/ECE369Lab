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


module MemoryToWriteBack
(Clock, 
RegWriteIn, MemToRegIn, R_Data_In, ALUResult_In, rDestSelected_in, PCNew_in, PCSrc_in,
RegWriteOut, MemToRegOut, R_Data_Out, ALUResult_Out, rDestSelected_Out, PCNew_Out, PCSrc_Out
);
input Clock;
input RegWriteIn, MemToRegIn, PCSrc_in;
input [31:0] ALUResult_In, R_Data_In, PCNew_in;
input [4:0] rDestSelected_in;

output reg RegWriteOut, MemToRegOut, PCSrc_Out;
output reg [31:0] ALUResult_Out, R_Data_Out, PCNew_Out;
output reg [4:0] rDestSelected_Out;

always @ (posedge Clock) begin 
RegWriteOut <= RegWriteIn;
MemToRegOut <= MemToRegIn;
ALUResult_Out <= ALUResult_In;
R_Data_Out <= R_Data_In;
rDestSelected_Out <= rDestSelected_in;
PCSrc_Out <= PCSrc_in;
PCNew_Out <= PCSrc_in;
end

endmodule
