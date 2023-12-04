`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2023 05:19:13 PM
// Design Name: 
// Module Name: ALU
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

module ALU(ALUControl, A, B, ALUResult, Zero);
    
	input [3:0] ALUControl; // control bits for ALU operation
                            // you need to adjust the bitwidth as needed

	input signed [31:0] A, B;	    // inputs

	output reg signed [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0

    // Combinational, no need for Clock
    always @ (*) begin
    
    // Assign ALUResult register
    case (ALUControl)   
        0: ALUResult <= A + B; // add, addi
        1: ALUResult <= A - B; // sub, subi
        2: ALUResult <= A * B; // mul
        3: ALUResult <= A & B; // and, andi
        4: ALUResult <= A | B; // or, ori
        5: ALUResult <= ~(A | B); // nor
        6: ALUResult <= A ^ B; // xor, xori
        7: ALUResult <= B << A; // sll
        8: ALUResult <= B >> A; // srl
        9: begin if (A < B) ALUResult <= 1; else ALUResult <= 0; end // slt
	10: begin if (A > B) ALUResult <= 1; else ALUResult <= 0; end //sgt
        default: ALUResult <= 32'hXXXXXXXX; // nop
    endcase
    
    // Assign Zero bit
    if (ALUResult == 0) Zero <= 1;
    else Zero <= 0;
    
    end
endmodule
