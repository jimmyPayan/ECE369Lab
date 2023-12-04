`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2023 10:04:00 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit(
// Inputs
MEM_rDestSelected, WB_rDestSelected, EX_opcode, EX_rt, EX_rs, 
//Outputs
ALUA1, ALUB1);

    input [4:0] MEM_rDestSelected, WB_rDestSelected, EX_rt, EX_rs;
    input [5:0] EX_opcode;
    output reg [1:0] ALUA1, ALUB1;
    
    always @(EX_rs, EX_rt) begin
        // R-Type or Store -> MEM
        if ((EX_opcode == 6'b000000 || EX_opcode == 6'b011100 || EX_opcode == 6'b101011)) begin
            // rs dependency in MEM and rt dependency in WB
            if (EX_rs == MEM_rDestSelected && (EX_rt == WB_rDestSelected && EX_rt != MEM_rDestSelected) && (MEM_rDestSelected != 0 && WB_rDestSelected != 0)) begin
                ALUA1 <= 1;
                ALUB1 <= 2;
            end
            // rs dependency in WB and rt dependency in MEM
            else if ((EX_rs == WB_rDestSelected && EX_rs != MEM_rDestSelected) && EX_rt == MEM_rDestSelected && (MEM_rDestSelected != 0 && WB_rDestSelected != 0)) begin
                ALUA1 <= 2;
                ALUB1 <= 1;
            end 
            // rs dependency in MEM and rt depedency in MEM
            else if (EX_rs == MEM_rDestSelected && EX_rt == MEM_rDestSelected && (MEM_rDestSelected != 0)) begin
                ALUA1 <= 1;
                ALUB1 <= 1;
            end 
            // rs dependency in WB and rt dependency in WB  
            else if (EX_rs == WB_rDestSelected && EX_rt == WB_rDestSelected && EX_rs != MEM_rDestSelected && EX_rt != MEM_rDestSelected && (WB_rDestSelected != 0)) begin
                ALUA1 <= 2;
                ALUB1 <= 2;
            end
            // no rs dependency and rt dependency in WB
            else if (((EX_rs != MEM_rDestSelected && EX_rs != WB_rDestSelected) || EX_rs == 0) && (EX_rt == WB_rDestSelected && EX_rt != MEM_rDestSelected) && (WB_rDestSelected != 0)) begin
                ALUA1 <= 0;
                ALUB1 <= 2;
            end
            // rs dependency in WB and no rt dependency
            else if ((EX_rs == WB_rDestSelected && EX_rs != MEM_rDestSelected) && ((EX_rt != MEM_rDestSelected && EX_rt != WB_rDestSelected) || EX_rt == 0) && WB_rDestSelected != 0) begin
                ALUA1 <= 2;
                ALUB1 <= 0;
            end
            
            // rs dependency in MEM and no rt dependency 
            else if (EX_rs == MEM_rDestSelected && ((EX_rt != MEM_rDestSelected && EX_rt != WB_rDestSelected) || EX_rt == 0) && MEM_rDestSelected != 0) begin
                ALUA1 <= 1;
                ALUB1 <= 0;
            end 
            // no rs dependency and rt dependency in MEM
            else if (((EX_rs != MEM_rDestSelected && EX_rs != WB_rDestSelected) || EX_rs == 0) && EX_rt == MEM_rDestSelected && MEM_rDestSelected != 0) begin
                ALUA1 <= 0;
                ALUB1 <= 1;
            end 
            // no dependency
            else begin
                ALUA1 <= 0;
                ALUB1 <= 0;
            end           
        end
        
        else if (EX_opcode != 6'b000000 && EX_opcode != 6'b011100 && EX_opcode != 6'b101011) begin
            // rs dependency in WB
            if (EX_rs == WB_rDestSelected && EX_rs != MEM_rDestSelected && WB_rDestSelected != 0) begin
                ALUA1 <= 2;
                ALUB1 <= 0;
            end
            // rs dependency in MEM
            else if (EX_rs == MEM_rDestSelected && MEM_rDestSelected != 0) begin
                ALUA1 <= 1;
                ALUB1 <= 0;
            end
            // no dependency
            else begin
                ALUA1 <= 0;
                ALUB1 <= 0;
            end    
        end     
    end
    
endmodule
