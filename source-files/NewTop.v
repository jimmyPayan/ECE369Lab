`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2023 08:40:19 PM
// Design Name: 
// Module Name: NewTop
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


module NewTop(Clk, out7, en_out);
input Clk;
wire ClkDivOut;
wire [31:0] PCCounter;
wire [31:0] RegWrite;
output [6:0] out7; //seg a, b, ... g
output [7:0] en_out;
ClkDiv Out(Clk, Reset, ClkDivOut);
ProcessorTopFileMIPS name(ClkDivOut, PCCounter, RegWrite);
Two4DigitDisplay display(Clk, PCCounter, RegWrite, out7, en_out);

endmodule
