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
RegWriteIn, MemToRegIn, 
RegWriteOut, MemToRegOut
);
input Clock;
input RegWriteIn, MemToRegIn;
output reg RegWriteOut, MemToRegOut;

always @ (posedge Clock) begin 
RegWriteOut <= RegWriteIn;
MemToRegOut <= MemToRegIn;
end

endmodule
