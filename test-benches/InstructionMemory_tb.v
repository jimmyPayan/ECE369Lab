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
programCounterIn = 0;
#50;
programCounterIn = 1;
#50;
programCounterIn = 2;
#50
programCounterIn = 3;
#50;
programCounterIn = 4;
#50;

end


endmodule
