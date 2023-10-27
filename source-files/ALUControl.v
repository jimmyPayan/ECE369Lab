`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 01:14:50 PM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(Instruction, Opcode, ALUControl);

input [5:0] Instruction;
input [5:0] Opcode;
output reg [3:0] ALUControl;

always @(*) begin

case (Instruction)

    // R-type with 6 MSB == 000000
    6'b000000: begin case (Opcode)
           6'b100000: ALUControl <= 0; // add
           6'b100010: ALUControl <= 1; // sub
           6'b001000: ALUControl <= 0; // jr (add $rs and $0)
           6'b100100: ALUControl <= 3; // and
           6'b100101: ALUControl <= 4; // or
           6'b100111: ALUControl <= 5; // nor
           6'b100110: ALUControl <= 6; // xor
           6'b000000: ALUControl <= 7; // sll
           6'b000010: ALUControl <= 8; // srl
           6'b101010: ALUControl <= 9; // slt
           default: ALUControl <= 4'bXXXX;
       endcase end
    
    // Arithmetic but 6 MSB != 000000   
    6'b001000: ALUControl <= 0; // addi
    6'b011100: ALUControl <= 2; // mul
    
    // Load commands
    6'b100011: ALUControl <= 0; // lw
    6'b100001: ALUControl <= 0; // lh
    6'b100000: ALUControl <= 0; // lb
    
    // Store commands
    6'b101011: ALUControl <= 0; // sw
    6'b101001: ALUControl <= 0; // sh
    6'b101000: ALUControl <= 0; // sb
    
    // Branch commands: It might be faster to put these directly into the branch logic
    6'b000001: begin case (Opcode)
            0: ALUControl <= 1; // bltz (rs - $0: if < 0, then rs < 0)
            1: ALUControl <= 1; // bgez (rs - $0: if >= 0, then rs >= 0)   
            default: ALUControl <= 4'bXXXX;  
       endcase end
    6'b000100: ALUControl <= 1; // beq (rs - rt: if 0, then rs = rt)
    6'b000101: ALUControl <= 1; // bne (rs - rt: if !0, then rs != rt)
    6'b000111: ALUControl <= 1; // bgtz (rs - $0: if > 0, then rs > 0)
    6'b000110: ALUControl <= 1; // blez (rs - $0: if <= 0, then rs <= 0)
    
    // Jump commands: jr already accounted for
    6'b000010: ALUControl <= 4'bXXXX; // j: Don't care. Nop
    6'b000011: ALUControl <= 4'bXXXX; // jal: Don't care. Nop
    
    // Immediate Logic Commands
    6'b001100: ALUControl <= 3; // andi
    6'b001101: ALUControl <= 4; // ori
    6'b001110: ALUControl <= 6; // xori
    6'b001010: ALUControl <= 9; // slti
    
    default: ALUControl <= 4'bXXXX;

endcase

end

endmodule
