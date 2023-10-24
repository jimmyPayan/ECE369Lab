`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 04:32:36 PM
// Design Name: 
// Module Name: ALUControl_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for ALUControl module
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALUControl_tb();

  reg [5:0] Instruction = 0;
  reg [5:0] OpCode = 0;
  wire [3:0] ALUControl;

  ALUControl aluControl_test(Instruction, OpCode, ALUControl);

  initial begin
    // Test cases
    // R-type with 6 MSB == 000000
    // Results should be: 1 0 0 3 4 5 6 7 8 9
    #100;
    Instruction <= 6'b000000; OpCode <= 6'b100010; #50;
    Instruction <= 6'b000000; OpCode <= 6'b100000; #50;
    Instruction <= 6'b000000; OpCode <= 6'b001000; #50;
    Instruction <= 6'b000000; OpCode <= 6'b100100; #50;
    Instruction <= 6'b000000; OpCode <= 6'b100101; #50;
    Instruction <= 6'b000000; OpCode <= 6'b100111; #50;
    Instruction <= 6'b000000; OpCode <= 6'b100110; #50;
    Instruction <= 6'b000000; OpCode <= 6'b000000; #50;
    Instruction <= 6'b000000; OpCode <= 6'b000010; #50;
    Instruction <= 6'b000000; OpCode <= 6'b101010; #50;

    // Arithmetic but 6 MSB != 000000
    // Results should be 0 2
    Instruction <= 6'b001000; #50;
    Instruction <= 6'b011100; #50;
  
    // Load commands
    // Results should be 0 0 0
    Instruction <= 6'b100011; #50;
    Instruction <= 6'b100001; #50;
    Instruction <= 6'b100000; #50;

    // Store commands
    // Results should be 0 0 0
    Instruction <= 6'b101011; #50;
    Instruction <= 6'b101001; #50;
    Instruction <= 6'b101000; #50;

    // Branch commands
    // Results should be 1 for all branch instructions
    Instruction <= 6'b000001; OpCode <= 6'b000000; #50;
    Instruction <= 6'b000001; OpCode <= 6'b000001; #50;
    Instruction <= 6'b000100; #50;
    Instruction <= 6'b000101; #50;
    Instruction <= 6'b000111; #50;
    Instruction <= 6'b000110; #50;

    // Jump commands
    // Results should be 10 for jump instructions
    Instruction <= 6'b000010; OpCode <= 6'b000000; #50;
    Instruction <= 6'b000011; OpCode <= 6'b000000; #50;

    // Immediate Logic Commands
    // Results should be: 3 4 6 9
    Instruction <= 6'b001100; #50;
    Instruction <= 6'b001101; #50;
    Instruction <= 6'b001110; #50;
    Instruction <= 6'b001010; #50;

  end

endmodule
