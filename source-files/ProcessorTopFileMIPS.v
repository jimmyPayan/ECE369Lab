`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 09:55:22 PM
// Design Name: 
// Module Name: ProcessorTopFileMIPS
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


module ProcessorTopFileMIPS(Clock);

// Wires used for first time in fetch
input Clock;
wire PCSel_IF;
wire [31:0] BranchPC_IF, PCPlusFour_IF, Instruction_IF;

Instruction_Fetch IF_Stage(
Clock, PCSel_IF, BranchPC_IF,
PCPlusFour_IF, Instruction_IF
);

// Wires used for first time in IF/ID
wire [31:0] Instruction_ID, PCPlusFour_ID;

FetchToDecode IF_ID_Pipeline(
Clock, 
Instruction_IF, PCPlusFour_IF, 
Instruction_ID, PCPlusFour_ID
);

// Wires used for first time in decode
wire PCSel_ID, RegDst_ID, ALUSrc0_ID,  R_Enable_ID, W_Enable_ID, MemToReg_ID, RegWrite_ID;
wire [1:0] R_Width_ID, W_Width_ID, ALUSrc1_ID;
wire [3:0] BranchSel_ID;
wire [31:0] Reg_Data1_ID, Reg_Data2_ID, Imm32b_ID;

Instruction_Decode ID_Stage (
Clock, 
Instruction_ID, PCPlusFour_ID, // Inputs

PCSel_ID, RegDst_ID, ALUSrc0_ID, ALUSrc1_ID, R_Enable_ID, W_Enable_ID, // Controller Outputs
R_Width_ID, W_Width_ID, MemToReg_ID, RegWrite_ID, BranchSel_ID, // Controller Outputs cont.
Reg_Data1_ID, Reg_Data2_ID, // Register File Outputs
Imm32b_ID // Sign Extend Output
);

// Wires used for first time in ID/EX
wire MemToReg_EX, RegWrite_EX, R_Enable_EX, W_Enable_EX, RegDst_EX, ALUSrc0_EX;
wire [1:0] R_Width_EX, W_Width_EX, ALUSrc1_EX;
wire [3:0] BranchSel_EX;
wire [4:0] Shamt_EX, rt_EX, rd_EX;
wire [5:0] Instruction_EX, Opcode_EX;
wire [25:0] instr_index_EX;
wire [31:0] PCPlusFour_EX, Reg_Data1_EX, Reg_Data2_EX, Imm32b_EX;
DecodeToExecute ID_EX_Pipeline(
Clock, 

MemToReg_ID, RegWrite_ID, 
R_Enable_ID, W_Enable_ID, R_Width_ID, W_Width_ID, BranchSel_ID,
Instruction_ID[31:26], Instruction_ID[5:0], RegDst_ID, ALUSrc0_ID, ALUSrc1_ID, PCPlusFour_ID, Instruction_ID[10:6], Reg_Data1_ID, Reg_Data2_ID, Imm32b_ID, Instruction_ID[20:16], Instruction_ID[15:11], Instruction_ID[25:0],

MemToReg_EX, RegWrite_EX, 
R_Enable_EX, W_Enable_EX, R_Width_EX, W_Width_EX, BranchSel_EX,
Instruction_EX, Opcode_EX, RegDst_EX, ALUSrc0_EX, ALUSrc1_EX, PCPlusFour_EX, Shamt_EX, Reg_Data1_EX, Reg_Data2_EX, Imm32b_EX, rt_EX, rd_EX, instr_index_EX 
);

Execute EX_Stage();

ExecuteToMemory EX_MEM_Pipeline();

Memory MEM_Stage();

MemoryToWriteBack MEM_WB_Pipeline();

Write_Back WB_Stage();

endmodule