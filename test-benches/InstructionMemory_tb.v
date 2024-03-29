`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2023 08:51:37 PM
// Design Name: 
// Module Name: InstructionMemory_tb
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


module InstructionMemory_tb();

reg [31:0] programCounterIn;
wire [31:0] instructionOut;

InstructionMemory InstructionMemTest(programCounterIn, instructionOut);

initial begin
programCounterIn <= 0;
#50;
programCounterIn <= 4;
#50;
programCounterIn <= 8;
#50
programCounterIn <= 12;
#50;
programCounterIn <= 24;
#50;

end


endmodule
