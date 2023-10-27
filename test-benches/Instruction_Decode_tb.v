`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 10:58:33 PM
// Design Name: 
// Module Name: Instruction_Decode_tb
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


module Instruction_Decode_tb();
    reg Clock, RegWrite;
    reg [31:0] Instruction, regWriteData;
    reg [4:0] rDestSelected;
    wire PCSel, RegDst, ALUSrc0, R_Enable, W_Enable, MemToReg, RegWriteOut;
    wire BranchSel;
    wire [1:0] ALUSrc1, R_Width, W_Width;
    wire [31:0] Imm32b, Reg_Data2, Reg_Data1;
    
    Instruction_Decode ID_test(
    Clock, 
    Instruction, rDestSelected, regWriteData, RegWrite,
    PCSel, RegDst, ALUSrc0, ALUSrc1, R_Enable, W_Enable, 
    R_Width, W_Width, MemToReg, RegWriteOut, BranchSel, 
    Reg_Data1, Reg_Data2,
    Imm32b);
    
    always begin
        Clock <= 0;
        #100;
        Clock <= 1;
        #100;
    end
    
    initial begin
        Instruction <= 32'h01098020;
        rDestSelected <= 4'b00000;
        RegWrite <= 0;
        regWriteData <= 32'h00000000;
        #100;
        Instruction <= 32'h2151001A;
        #100;
        Instruction <= 32'h02119022;
        #100
        Instruction <= 32'h72119802;
        #100;
        Instruction <= 32'h8E140000;
        #100;
    end
    
    
    
endmodule
