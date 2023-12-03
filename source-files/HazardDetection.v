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
    
   // R-Type -> R-Type || I-Type (Store or Branch) -> R-Type
   if ((((ID_rs == EX_rd) && (ID_rs != 0)) || ((ID_rt == EX_rd) && (ID_rt != 0))) && (EX_opcode == 6'b000000 || EX_opcode == 6'b011100) && (ID_opcode == 6'b000000 || ID_opcode == 6'b011100 || (ID_opcode[5:3] == 3'b000 && (ID_opcode[2:0] > 3'b000)) || (ID_opcode[5:3] == 3'b101))) begin
        Stall_ID <= 1;
        Stall_PC <= 1;
        Stall_ID_EX <= 1;
    end 
    
    
    
    // I-Type (Arithmetic or Load) -> R-Type
    
    else  if ((ID_rs == EX_rd && ID_rs != 0) && (EX_opcode == 6'b000000 || EX_opcode == 6'b011100) && (ID_opcode != 6'b000000 || ID_opcode != 6'b011100 || !(ID_opcode[5:3] == 3'b000 && (ID_opcode[2:0] > 3'b000)) || (ID_opcode[5:3] != 3'b101))) begin
        Stall_ID <= 1;
        Stall_PC <= 1;
        Stall_ID_EX <= 1;
    end
    
    
    
    // R-Type -> I-Type (Arithmetic or Load)
    else if ((((ID_rs == EX_rt) && (ID_rs != 0)) || ((ID_rt == EX_rt) && (ID_rt != 0))) && (ID_opcode == 6'b000000 || ID_opcode == 6'b011100) && (EX_opcode != 6'b000000 || EX_opcode != 6'b011100 || !(EX_opcode[5:3] == 3'b000 && (EX_opcode[2:0] > 3'b000)) || (EX_opcode[5:3] != 3'b101))) begin
        Stall_ID <= 1;
        Stall_PC <= 1;
        Stall_ID_EX <= 1;
    end
    
    
    
    // I-Type (Arithmetic or Load) -> I-Type (Arithmetic or Load)
  else if ((ID_rs == EX_rt && ID_rs != 0) && (ID_opcode != 6'b000000 || ID_opcode != 6'b011100 || !(ID_opcode[5:3] == 3'b000 && (ID_opcode[2:0] > 3'b000)) || (ID_opcode[5:3] != 3'b101)) && (EX_opcode != 6'b000000 || EX_opcode != 6'b011100 || !(EX_opcode[5:3] == 3'b000 && (EX_opcode[2:0] > 3'b000)) || (EX_opcode[5:3] != 3'b101))) begin
        Stall_ID <= 1;
        Stall_PC <= 1;
        Stall_ID_EX <= 1;
    end
    
    
    // I-Type (Branch or Store) -> I-Type (Arithmetic or Load)
    
    else if (((ID_rs == EX_rt && ID_rs != 0) || (ID_rt == EX_rt && ID_rt != 0)) && ((ID_opcode[5:3] == 3'b000 && (ID_opcode[2:0] > 3'b000)) || (ID_opcode[5:3] == 3'b101)) && (EX_opcode != 6'b000000 || EX_opcode != 6'b011100 || !(EX_opcode[5:3] == 3'b000 && (EX_opcode[2:0] > 3'b000)) || (EX_opcode[5:3] != 3'b101))) begin
        Stall_ID <= 1;
        Stall_PC <= 1;
        Stall_ID_EX <= 1;
    end
    
    
    
    
   // I-Type (Store or Branch) -> I-Type (Store or Branch)
   else if (((ID_rs == EX_rt && ID_rs != 0) || (ID_rt == EX_rt && ID_rt != 0)) && (EX_opcode != 6'b000000 || EX_opcode != 6'b011100 || EX_opcode != 6'b101011 || EX_opcode != 6'b101000 || EX_opcode != 6'b101001) && (ID_opcode == 6'b000000 || ID_opcode == 6'b011100)) begin 
        Stall_ID <= 1;
        Stall_PC <= 1;
        Stall_ID_EX <= 1;
    end

    
    // R-Type or I-Type dependency between an instruction in ID and an instruction in MEM
   else if (((ID_rs == MEM_rDestSelected) && (ID_rs != 0)) || ((ID_rt == MEM_rDestSelected) && (ID_rt != 0) && ((ID_opcode[5:3] == 3'b000 && (ID_opcode[2:0] > 3'b000)) || (ID_opcode[5:3] == 3'b101) || (ID_opcode == 6'b000000) || (ID_opcode == 6'b011100)))) begin
        Stall_ID <= 1; 
        Stall_PC <= 1;
        Stall_ID_EX <= 1;
    end
    
    
    // No dependency exists
    else begin 
        Stall_ID <= 0;
        Stall_PC <= 0;
        Stall_ID_EX <= 0;
    end
    
end

endmodule
