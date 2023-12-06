`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 10:30:44 AM
// Design Name: 
// Module Name: InstructionMemory
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2023 07:43:42 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(programCounterIn, instructionOut);
input [31:0] programCounterIn;
output reg [31:0] instructionOut; // Instruction to be fetched by the processor
reg [31:0] instrMem [0:1023]; // Array holding all instructions to be executed by the processor

initial begin
//$readmemb ("basicmips.mem", instrMem);
$readmemh ("bug_test.mem", instrMem);
//$readmemh ("vbsme_lab7_instr.mem", instrMem);
end

always @ (programCounterIn) begin
    instructionOut <= instrMem[programCounterIn / 4];
end

endmodule
