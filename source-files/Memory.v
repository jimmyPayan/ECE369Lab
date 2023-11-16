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

// Inputs
R_Enable, W_Enable, R_Width, W_Width, ALUResult, W_Data,

// Outputs
R_Data_output
);
    input R_Enable, W_Enable, /*Zero,*/ Clock;
    input [1:0] R_Width, W_Width;
    input [31:0] ALUResult, W_Data;

    wire [31:0] R_Data, PCNew;
    wire PCSrc;
    output reg [31:0] R_Data_output;
    
    DataMemory Data_Memory(
    Clock, 
    W_Enable, R_Enable, 
    ALUResult, 
    R_Data, W_Data, 
    R_Width, W_Width);

    PCSrcControl test(BranchSel, Zero, ALUResult, j_sll_two, PC_Plus_Branch, PCSrc, PCNew);
    
    always @ (*) begin
    R_Data_output <= R_Data;
    end

endmodule
