`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 12:10:42 PM
// Design Name: 
// Module Name: PCSrc_Control
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

module PCSrcControl(
// ***Inputs***
Instruction,  PC_Plus_Branch, Reg_Data1, Reg_Data2, Stall_PC,

// ***Outputs***
PCSel, BranchPC

); 
    input [31:0] Instruction, PC_Plus_Branch, Reg_Data1, Reg_Data2;
    input Stall_PC;
    
    output reg PCSel;
    output reg [31:0] BranchPC;
    
    // Make it always @ (*), functionality should stay the same though
    always @ (*) begin
    if (Stall_PC == 0) begin
        case (Instruction[31:26])   
            // jr 
            6'b000000: begin
                if (Instruction [5:0] == 6'b001000) begin
                    PCSel <= 1;
                    BranchPC <= Reg_Data1;
                end
                else begin
                    PCSel <= 0;
                    BranchPC <= 32'hXXXXXXXX;
                end
            end  
            
            // bltz, bgez
            6'b000001: begin
                case(Instruction [20:16])
                    // bltz
                    5'b00000:
                        if(Reg_Data1 < 0) begin 
                            PCSel <= 1;
                            BranchPC <= PC_Plus_Branch; 
                        end
                        
                        else PCSel <= 0;
                     
                    // bgez   
                    5'b00001:
                        if(Reg_Data1 >= 0) begin 
                            PCSel <= 1;
                            BranchPC <= PC_Plus_Branch; 
                        end
                        
                        else PCSel <= 0;
                        
                    default: begin
                        PCSel <= 0;
                        BranchPC <= 32'hXXXXXXXX;
                    end
                    
                endcase
            end
            
            // j
            6'b000010: begin
                PCSel <= 1;
                BranchPC <= {PC_Plus_Branch[31:28], (Instruction[25:0] << 2)}; // Changed 12/6/23
            end
            
            // jal (BE SURE TO TEST THIS)
            6'b000011: begin
                PCSel <= 1;
                BranchPC <= {PC_Plus_Branch[31:28], (Instruction[25:0] << 2)};     // Changed 12/6/23          
            end
            
            // beq
            6'b000100: begin
                if (Reg_Data1 == Reg_Data2) begin
                    PCSel <= 1;
                    BranchPC <= PC_Plus_Branch;
                end
                else PCSel <= 0;
            end
            
            // bne
            6'b000101: begin
                if (Reg_Data1 != Reg_Data2) begin
                    PCSel <= 1;
                    BranchPC <= PC_Plus_Branch;
                end
                else PCSel <= 0;
            end
            
            // blez
            6'b000110: begin
                if (Reg_Data1 <= 0) begin
                    PCSel <= 1;
                    BranchPC <= PC_Plus_Branch;
                end
                else PCSel <= 0;
            end
          
            // bgtz
            6'b000111: begin
                if (Reg_Data1 > 0) begin
                    PCSel <= 1;
                    BranchPC <= PC_Plus_Branch;
                end
                else PCSel <= 0;
            end          
          
            default: begin
                PCSel <= 0;
                BranchPC <= 32'hXXXXXXXX;
                end           
          endcase 
      end 
      
    else begin 
        PCSel <= 0;
    end             
    end
endmodule