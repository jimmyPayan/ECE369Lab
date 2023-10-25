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


module PCSrc_Control(BranchSel, Zero, ALUResult, Imm, AddResult, PCSrc, PCNew);
    input [3:0] BranchSel;
    input Zero;
    input [31:0] ALUResult, AddResult;
    input [27:0] Imm;
    output reg [1:0] PCSrc;
    output reg [31:0] PCNew;
    
    always @(BranchSel) begin
        case(BranchSel) 
            4'b0000: 
                if (ALUResult >= 0) begin 
                    PCSrc <= 1; 
                    PCNew <= AddResult; 
                end
                else begin
                    PCSrc <= 0;
                    PCNew <= 32'h00000000;
                end
            4'b0001:
                if (Zero == 1) begin
                    PCSrc <= 1;
                    PCNew <= AddResult;
                end
                else begin
                    PCSrc <= 0;
                    PCNew <= 32'h00000000;
                end
            4'b0010:
                if (Zero == 0) begin
                    PCSrc <= 1;
                    PCNew <= AddResult;
                end
                else begin
                    PCSrc <= 0;
                    PCNew <= 32'h00000000;
                end
            4'b0011:
                if (ALUResult > 0) begin
                    PCSrc <= 1;
                    PCNew <= AddResult;
                end
                else begin
                    PCSrc <= 0;
                    PCNew <= 32'h00000000;
                end 
            4'b0100:
                if (ALUResult <= 0) begin
                    PCSrc <= 1;
                    PCNew <= AddResult;
                end 
                else begin
                    PCSrc <= 0;
                    PCNew <= 32'h00000000;
                end 
            4'b0101:
                if (ALUResult < 0) begin
                    PCSrc <= 1;
                    PCNew <= AddResult;
                end
                else begin
                    PCSrc <= 0;
                    PCNew <= 32'h00000000;
                end 
            4'b0110: begin
                PCSrc <= 1;
                PCNew <= {AddResult[31:28], Imm};
                end
            4'b0111: begin
                PCSrc <= 1;
                PCNew <= ALUResult; 
                end
            4'b1000: begin
                PCSrc <= 1;
                PCNew <= AddResult;
                end               
            default: begin
                PCSrc <= 1;
                PCNew <= 32'h00000000;
                end           
          endcase              
    end
endmodule
