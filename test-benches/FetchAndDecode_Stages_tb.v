`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2023 11:03:52 AM
// Design Name: 
// Module Name: FetchAndDecode_Stages_tb
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


module FetchAndDecode_Stages_tb(
Clock, // Global signal
PCSel, BranchPC, // Fetch inputs
RegDestSelected_WB, regWriteData_WB, regWrite_WB // Decode inputs
);
input Clock;
input PCSel;
input [31:0] BranchPC;
wire [31:0] PCPlusFour_IF;
wire [31:0] Instruction_IF;
wire [31:0] PC_To_Instr_Mem_IF;

Instruction_Fetch IF_Stage_tb(
Clock,
PCSel, BranchPC,
Instruction_IF, PCPlusFour_IF, PC_To_Instr_Mem_IF
);

// IF/ID Declarations
wire [31:0] Instruction_ID, PCPlusFour_ID;
FetchToDecode IF_ID_tb(
Clock,
Instruction_IF, PCPlusFour_IF,
Instruction_ID, PCPlusFour_ID 
);

// ID Declarations
input [31:0] regWriteData_WB, regWrite_WB;
input [4:0] RegDestSelected_WB;
wire PCSel_ID, RegDest_ID, ALUSrc0_ID, R_Enable_ID, W_Enable_ID, MemToReg_ID, RegWrite_ID;
wire [1:0] ALUSrc1_ID, R_Width_ID, W_Width_ID;
wire [4:0] BranchSel_ID;
wire [31:0] Reg_Data1_ID, Reg_Data2_ID, Imm32b_ID;
Instruction_Decode ID_Stage_tb (
Clock, 
Instruction_ID, RegDestSelected_WB, regWriteData, RegWrite_WB, // Inputs

PCSel_ID, RegDst_ID, ALUSrc0_ID, ALUSrc1_ID, R_Enable_ID, W_Enable_ID, // Controller Outputs
R_Width_ID, W_Width_ID, MemToReg_ID, RegWrite_ID, BranchSel_ID, // Controller Outputs cont.
Reg_Data1_ID, Reg_Data2_ID, // Register File Outputs
Imm32b_ID // Sign Extend Output
);

initial begin
#100;
$finish;
end


endmodule
