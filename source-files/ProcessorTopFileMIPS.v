`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 09:55:22 PM
// Design Name: 
// Module Name: ProcessorTopFileMIPS
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


module ProcessorTopFileMIPS();

Instruction_Fetch(
Clock, PCSel_IF, BranchPC_IF,
PCPlusFour_IF, Instruction_IF
);

FetchToDecode(
Clock, 
Instruction_IF, PCPlusFour_IF,
Instruction_ID, PCPlusFour_ID
);

Instruction_Decode();

DecodeToExecute();

Execute();

ExecuteToMemory();

Memory();

MemoryToWriteBack();

Write_Back();

endmodule