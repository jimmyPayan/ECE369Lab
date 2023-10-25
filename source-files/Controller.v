`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 07:35:25 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
Instruction, BranchSignal, Opcode, // Inputs
PCSrc, 
RegSrc0, RegSrc1, ExtendSel,
RegDst, ALUSrc0, ALUSrc1,
R_Enable, W_Enable, MemToReg, RegWrite, R_Width, W_Width, InstrSel // Outputs
);

input [5:0] Instruction;
input [4:0] BranchSignal;
input [5:0] Opcode;

output reg PCSrc;

output reg RegSrc0;
output reg RegSrc1;
output reg ExtendSel;

output reg RegDst;
output reg ALUSrc0;
output reg ALUSrc1;
output reg R_Enable;
output reg W_Enable;
output reg MemToReg;
output reg RegWrite;
output reg [1:0] R_Width;
output reg [1:0] W_Width;
output reg [3:0] InstrSel;

always @(Instruction) begin
case (Instruction)
    // R-type instructions (and jump register since that's R-type for some reason ???)
    
    6'b000000: 
        case (Opcode)
        // jr
            6'b001000: begin
            PCSrc <= 1;
            RegSrc0 <= 1;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 0;
            ALUSrc1 <= 2;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 7;
        end
        // sll
            6'b000000: begin
            PCSrc <= 1;
            RegSrc0 <= 1;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 1;
            ALUSrc1 <= 2;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 7; 
            end
        // srl
            6'b000010: begin
            PCSrc <= 1;
            RegSrc0 <= 1;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 1;
            ALUSrc1 <= 2;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 7; 
            end
        // Not sll / srl
            default: begin
            PCSrc <= 1;
            RegSrc0 <= 1;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 0;
            ALUSrc1 <= 2;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;          
            InstrSel <= 7;  
        end
        endcase
    
    // mul (uses SPECIAL2 = 6'b011100, not SPECIAL = 6'b000000)
    // this is the only instruction that uses SPECIAL2 but we can expand if needed
    6'b011100: begin 
            PCSrc <= 0;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 1;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 10;      
    end  
    
    // Memory Instructions
    // lw
    6'b100011: begin
            PCSrc <= 0;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 1; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 1;
            R_Width <= 0;
            W_Width <= 10;
            InstrSel <= 10;          
    end

    // lh
    6'b100001: begin
            PCSrc <= 0;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 1; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 1;
            R_Width <= 1;
            W_Width <= 10;
            InstrSel <= 10;          
    end

    // lb
    6'b100000: begin
            PCSrc <= 0;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 1; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 1;
            R_Width <= 2;
            W_Width <= 10;
            InstrSel <= 10;          
    end
    
    // sw
    6'b101011: begin
            PCSrc <= 0;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 0; 
            W_Enable <= 1;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 0;
            InstrSel <= 10;  
    end
    
    // sh
    6'b101001: begin
            PCSrc <= 0;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 0; 
            W_Enable <= 1;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 1;
            InstrSel <= 10;  
    end

    // sb
    6'b101011: begin
            PCSrc <= 0;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 0; 
            W_Enable <= 1;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 2;
            InstrSel <= 10;  
    end
    
    // Branch and Jump instructions
    // bgez & bltz
    6'b000001: begin
            PCSrc <= 1;
            RegSrc0 <= 0;
            RegSrc1 <= 0; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            
            case (BranchSignal)
            0: InstrSel <= 5;
            1: InstrSel <= 0;
            endcase
    end
    
    // beq
    6'b000100: begin
            PCSrc <= 1;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 1;     
    end
    
    // bne
    6'b000101: begin
            PCSrc <= 1;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 2;     
    end
    
    // bgtz
    6'b000111: begin
            PCSrc <= 1;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 3;     
    end
    
    // blez
    6'b000110: begin
            PCSrc <= 1;
            RegSrc0 <= 0;
            RegSrc1 <= 0; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 4;    
    end
    
    // j
    6'b000010: begin
            PCSrc <= 1;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 6;    
    end
    
    // jal
    6'b000011: begin
            PCSrc <= 1;
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 2;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 10;
            W_Width <= 10;
            InstrSel <= 8;    
    end
        
    // Logical I-type instructions
    // addi, ori, xori, slti
    default: begin
        PCSrc <= 0;
        RegSrc0 <= 0;
        RegSrc1 <= 1;
        RegDst <= 0;
        ALUSrc0 <= 0;
        ALUSrc1 <= 1;
        R_Enable <= 0;
        W_Enable <= 0;
        MemToReg <= 1;
        RegWrite <= 1;
        R_Width <= 10;
        W_Width <= 10;
        InstrSel <= 10;
    end    
endcase
end

endmodule
