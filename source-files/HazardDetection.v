`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2023 09:31:43 PM
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(
// Inputs
Clock, 
ID_rs, ID_rt, EX_opcode, MEM_opcode, MEM_rDestSelected, EX_rt, EX_rd, ID_opcode,

// Outputs
Stall_ID, Stall_PC, Stall_ID_EX
);
input Clock;
input [4:0] ID_rs, ID_rt, MEM_rDestSelected, EX_rt, EX_rd;
input [5:0] EX_opcode, MEM_opcode, ID_opcode;

output reg Stall_ID, Stall_PC, Stall_ID_EX;

always @ (ID_rs, ID_rt) begin

   // Branch -> R-Type in EX
   if ((ID_opcode[5:3] == 3'b000 && ID_opcode[2:0] > 3'b000) && (((ID_rs == EX_rd) && ID_rs) || ((ID_rt == EX_rd) && ID_rt)) && (EX_opcode == 6'b000000 || EX_opcode == 6'b011100)) begin
    Stall_ID <= 1;
    Stall_PC <= 1;
    Stall_ID_EX <= 1;
   end 
   
   // Branch -> I-Type (Arithmetic or LW) in EX
   if ((ID_opcode[5:3] == 3'b000 && ID_opcode[2:0] > 3'b000) && (((ID_rs == EX_rt) && ID_rs) || ((ID_rt == EX_rt) && ID_rt)) && (EX_opcode != 6'b000000 && EX_opcode != 6'b011100 && EX_opcode != 6'b100011)) begin
    Stall_PC <= 1;
    Stall_ID <= 1;
    Stall_ID_EX <= 1;  
   end
   
   // Branch or Jump -> MEM
   else if ((ID_opcode[5:3] == 3'b000 && ID_opcode[2:0] > 3'b000) && (((ID_rs == MEM_rDestSelected) && ID_rs) || ((ID_rt == MEM_rDestSelected) && ID_rt)) && (MEM_opcode != 6'b100011)) begin
    Stall_ID <= 1;
    Stall_PC <= 1;
    Stall_ID_EX <= 1;
   end  
   // FIX ME: Redo hazard detect logic with 
   // R-Type -> lw
   else if ((EX_opcode == 6'b100011) && (ID_opcode == 6'b000000 || ID_opcode == 6'b101011 || ID_opcode == 6'b011100) && (ID_rs == EX_rt || ID_rt == EX_rt)) begin
    Stall_ID <= 1;
    Stall_PC <= 1;
    Stall_ID_EX <= 1;
   end
   
   // I_Type -> lw
   else if ((EX_opcode == 6'b100011) && (ID_opcode != 6'b000000 && ID_opcode != 6'b101011 && ID_opcode != 6'b011100 && !(ID_opcode[5:3] == 3'b000 && ID_opcode[2:0] > 3'b000)) && (ID_rs == EX_rt)) begin
    Stall_ID <= 1;
    Stall_PC <= 1;
    Stall_ID_EX <= 1;
   end
   
   else begin
    Stall_PC <= 0;
    Stall_ID <= 0;
    Stall_ID_EX <= 0;
   end
   
    
end

endmodule
