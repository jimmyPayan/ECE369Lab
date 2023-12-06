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
// Inputs
Opcode, Funct, 

// Outputs
RegSrc0, RegSrc1,
RegDst, ALUSrc0, ALUSrc1,
R_Enable, W_Enable, R_Width, W_Width,
MemToReg, RegWrite, Jal 
);

input [5:0] Funct, Opcode;

output reg RegSrc0;
output reg RegSrc1;
//output reg ExtendSel;

output reg RegDst;
output reg ALUSrc0;
output reg [1:0] ALUSrc1;
output reg R_Enable;
output reg W_Enable;
output reg MemToReg;
output reg RegWrite;
output reg [1:0] R_Width;
output reg [1:0] W_Width;
output reg Jal;

//always @(Instruction) begin 
// Since we have case(opcode) and case(branchSignal) we should do always @ (*), functionality should be the same
always @ (*) begin
case (Opcode)
    // R-type instructions (and jump register since that's R-type for some reason ???)
    
    6'b000000: 
        begin case (Funct)
        // jr
            6'b001000: begin
            RegSrc0 <= 1;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0; // top of r-type changes
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
            end
        // sll
            6'b000000: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1;
            RegDst <= 1;
            ALUSrc0 <= 1;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 1;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
            end
        // srl
            6'b000010: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 1;
            ALUSrc1 <= 0;           
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 1;
            RegWrite <= 1;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
            end
        // Not sll / srl
            
            default: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1;  
            RegDst <= 1;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0; // Correction 11/30/23
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 1;
            RegWrite <= 1;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;  
            Jal <= 0;        
            end
    endcase end
    
    // mul (uses SPECIAL2 = 6'b011100, not SPECIAL = 6'b000000)
    // this is the only instruction that uses SPECIAL2 but we can expand if needed
    6'b011100: begin 
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 1;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 1;
            RegWrite <= 1;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX; 
            Jal <= 0;
    end  
    
    // Memory Instructions
    // lw
    6'b100011: begin
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
            W_Width <= 2'bXX;
            Jal <= 0;   
    end

    // lh
    6'b100001: begin
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
            W_Width <= 2'bXX; 
            Jal <= 0;    
    end

    // lb
    6'b100000: begin
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
            W_Width <= 2'bXX;  
            Jal <= 0;     
    end
    
    // sw
    6'b101011: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1;  
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 0; 
            W_Enable <= 1;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 0;
            Jal <= 0;
    end
    
    // sh
    6'b101001: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1;  
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 0; 
            W_Enable <= 1;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 1;
            Jal <= 0;
    end

    // sb
    6'b101000: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1;  
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 1;
            R_Enable <= 0; 
            W_Enable <= 1;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2;
            Jal <= 0;
    end
    
    // Branch and Jump instructions
    // bgez & bltz
    6'b000001: begin
            RegSrc0 <= 0;
            RegSrc1 <= 0; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
    end
    
    // beq
    6'b000100: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
    end
    
    // bne
    6'b000101: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
    end
    
    // bgtz
    6'b000111: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
    end
    
    // blez
    6'b000110: begin
            RegSrc0 <= 0;
            RegSrc1 <= 0; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
    end
    
    // j
    6'b000010: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 0;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 0;
    end
    
    // jal
    6'b000011: begin
            RegSrc0 <= 0;
            RegSrc1 <= 1; 
            RegDst <= 0;
            ALUSrc0 <= 0;
            ALUSrc1 <= 2;
            R_Enable <= 0; 
            W_Enable <= 0;
            MemToReg <= 0;
            RegWrite <= 0;
            R_Width <= 2'bXX;
            W_Width <= 2'bXX;
            Jal <= 1;
    end
        
    // Logical I-type instructions
    // addi
    6'b001000: begin
        RegSrc0 <= 0;
        RegSrc1 <= 1;
        RegDst <= 0;
        ALUSrc0 <= 0;
        ALUSrc1 <= 1;
        R_Enable <= 0;
        MemToReg <= 1;
        RegWrite <= 1;
        R_Width <= 2'bXX;
        W_Width <= 2'bXX;
        Jal <= 0;
    end
    
    // andi
    6'b001100: begin
        RegSrc0 <= 0;
        RegSrc1 <= 1;
        RegDst <= 0;
        ALUSrc0 <= 0;
        ALUSrc1 <= 1;
        R_Enable <= 0;
        MemToReg <= 1;
        RegWrite <= 1;
        R_Width <= 2'bXX;
        W_Width <= 2'bXX;
        Jal <= 0;
    end    
    
    // ori
    6'b001101: begin
        RegSrc0 <= 0;
        RegSrc1 <= 1;
        RegDst <= 0;
        ALUSrc0 <= 0;
        ALUSrc1 <= 1;
        R_Enable <= 0;
        MemToReg <= 1;
        RegWrite <= 1;
        R_Width <= 2'bXX;
        W_Width <= 2'bXX;
        Jal <= 0;
    end 
    
    // xori
    6'b001110: begin
        RegSrc0 <= 0;
        RegSrc1 <= 1;
        RegDst <= 0;
        ALUSrc0 <= 0;
        ALUSrc1 <= 1;
        R_Enable <= 0;
        MemToReg <= 1;
        RegWrite <= 1;
        R_Width <= 2'bXX;
        W_Width <= 2'bXX;
        Jal <= 0;
    end 
    
    // slti
    6'b001010: begin
        RegSrc0 <= 0;
        RegSrc1 <= 1;
        RegDst <= 0;
        ALUSrc0 <= 0;
        ALUSrc1 <= 1;
        R_Enable <= 0;
        MemToReg <= 1;
        RegWrite <= 1;
        R_Width <= 2'bXX;
        W_Width <= 2'bXX;
        Jal <= 0;
     end
     default: begin 
        RegSrc0 <= 0;
        RegSrc1 <= 0;
        RegDst <= 0;
        ALUSrc0 <= 0;
        ALUSrc1 <= 0;
        R_Enable <= 0;
        MemToReg <= 0;
        RegWrite <= 0;
        R_Width <= 0;
        W_Width <= 0;
        Jal <= 0;
     end
endcase
end

endmodule