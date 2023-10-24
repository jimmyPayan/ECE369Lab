`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2023 05:53:33 PM
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb();

reg [3:0] ALUControl; 
reg [31:0] A, B;

wire [31:0] ALUResult;
wire Zero;

ALU testALU(ALUControl, A, B, ALUResult, Zero);

initial begin 
// add
#100;
ALUControl <= 0; A <= 4; B <= 9; // Result should be 13

// sub, subi
#50 ALUControl <= 1; A <= 9; B <= 2; // Result should be 7

// mul
#50 ALUControl <= 2; A <= 3; B <= 5; // Result should be 15

// and, andi
#50 ALUControl <= 3; A <= 32'h0000FFFF; B <= 32'h00FF00FF; // Result should be 0x000000FF

// or, ori
#50 ALUControl <= 4; A <= 32'h0000FFFF; B <= 32'h00FF00FF; // Result should be 0x00FFFFFF

// nor
#50 ALUControl <= 5; A <= 32'h0000FFFF; B <= 32'h00FF00FF; // Result should be 0xFF000000

// xor
#50 ALUControl <= 6; A <= 32'h0000FFFF; B <= 32'h00FF00FF; // Result should be 0x00FFFF00

// sll
#50 ALUControl <= 7; A <= 7; B <= 2; // Result should be 31

// srl
#50 ALUControl <= 8; A <= 31; B <= 2; // Result should be 7

// slt
#50 ALUControl <= 9; A <= 7; B <= 15; // Result should be 1
#50 ALUControl <= 9; A <= 15; B <= 7; // Result should be 0

end



endmodule
