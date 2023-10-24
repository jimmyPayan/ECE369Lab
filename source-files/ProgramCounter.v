`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2023 06:46:56 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(PCNext, PCResult, Clk);
    input [31:0] PCNext;
    input Clk;
    output reg [31:0] PCResult;
    
    always @(posedge Clk) begin
        PCResult <= PCNext;
    end
    
endmodule
