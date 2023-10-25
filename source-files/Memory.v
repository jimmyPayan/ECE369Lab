`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 03:04:59 PM
// Design Name: 
// Module Name: Memory
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


module Memory(
Clock, 
R_Enable, W_Enable, R_Width, W_Width, BranchSel, PC_Plus_Branch, Zero, ALUResult, Reg_Data2, j_sll_two,
R_Data, PCNew, PCSrc
);
    input R_Enable, W_Enable, Zero, Clock;
    input [1:0] R_Width, W_Width;
    input [3:0] BranchSel;
    input [31:0] PC_Plus_Branch, ALUResult, Reg_Data2;
    input [27:0] j_sll_two;

    output reg [31:0] R_Data, PCNew;
    output reg [1:0] PCSrc;

    DataMemory Data_Memory(Clock, W_Enable, R_Enable, ALUResult, R_Data, Reg_Data2, R_Width, W_Width);
    PCSrcControl PCSrc_Control(BranchSel, Zero, ALUResult, j_sll_two, PC_Plus_Branch, PCSrc, PCNew);
    


endmodule
