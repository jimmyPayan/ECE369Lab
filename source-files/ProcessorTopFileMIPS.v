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


module ProcessorTopFileMIPS(Clock, PC_To_Instr_Mem_output, regWriteData_output);

// Wires used for first time in Instruction Fetch
input Clock; // configure outputs
output reg [31:0] PC_To_Instr_Mem_output;
output reg [31:0] regWriteData_output;

wire PCSel_IF;
wire [31:0] BranchPC_IF, PCPlusFour_IF, Instruction_IF;
wire [31:0] PC_To_Instr_Mem_IF;
Instruction_Fetch IF_Stage(
Clock, PCSel_IF, BranchPC_IF,
Instruction_IF, PCPlusFour_IF, PC_To_Instr_Mem_IF
);

// Wires used for first time in IF/ID
wire [31:0] Instruction_ID, PCPlusFour_ID;

FetchToDecode IF_ID_Pipeline(
Clock, 
Instruction_IF, PCPlusFour_IF, 
Instruction_ID, PCPlusFour_ID
);

// Wires used for first time in Instruction Decode
wire PCSel_ID, RegDst_ID, ALUSrc0_ID,  R_Enable_ID, W_Enable_ID, MemToReg_ID, RegWrite_ID;
wire [1:0] R_Width_ID, W_Width_ID, ALUSrc1_ID;
wire [3:0] BranchSel_ID;
wire [31:0] Reg_Data1_ID, Reg_Data2_ID, Imm32b_ID;
wire [4:0] RegDestSelected_WB;
wire [31:0] regWriteData;
wire RegWriteWB;

Instruction_Decode ID_Stage (
Clock, 
Instruction_ID, RegDestSelected_WB, regWriteData, RegWriteWB, // Inputs

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

// Wires used for first time in Execute
wire Zero_EX;
wire [27:0] j_sll_two_EX; 
wire [31:0] ALUResult_EX, PC_Plus_Branch_EX;
wire [4:0] RegDestSelected_EX;

Execute EX_Stage(
RegDst_EX, ALUSrc0_EX, ALUSrc1_EX, Shamt_EX,
Reg_Data1_EX, Reg_Data2_EX, Imm32b_EX, PCPlusFour_EX, Instruction_EX, Opcode_EX, instr_index_EX, rt_EX, rd_EX,

Zero_EX, ALUResult_EX,
j_sll_two_EX, PC_Plus_Branch_EX, RegDestSelected_EX
);

wire R_Enable_MEM, W_Enable_MEM, RegWrite_MEM, MemToReg_MEM, Zero_MEM;
wire [3:0] BranchSel_MEM;
wire [1:0] R_Width_MEM, W_Width_MEM;
wire [31:0] ALUResult_MEM, PC_Plus_Branch_MEM, Reg_Data2_MEM;
wire [4:0] RegDestSelected_MEM;
wire [27:0] j_sll_two_MEM;

ExecuteToMemory EX_MEM_Pipeline(
Clock,
R_Enable_EX, W_Enable_EX, BranchSel_EX, RegWrite_EX, MemToReg_EX, ALUResult_EX, RegDestSelected_EX, 
R_Width_EX, W_Width_EX, PC_Plus_Branch, Zero_EX, Reg_Data2_EX, j_sll_two_EX,

R_Enable_MEM, W_Enable_MEM, BranchSel_MEM, RegWrite_MEM, MemToReg_MEM, ALUResult_MEM, RegDestSelected_MEM, 
R_Width_MEM, W_Width_MEM, PC_Plus_Branch_MEM, Zero_MEM, Reg_Data2_MEM, j_sll_two_MEM
);

wire [31:0] R_Data, PCNew;

Memory MEM_Stage(
Clock,
R_Enable_MEM, W_Enable_MEM, R_Width_MEM, W_Width, BranchSel_MEM, PC_Plus_Branch_MEM, Zero_MEM, ALUResult_MEM, 
Reg_Data2_MEM, j_sll_two_MEM, R_Data, PCNew, PCSel_IF
);

wire RegWrite_WB, MemToReg_WB; 
wire [31:0] R_Data_WB, ALUResult_WB;
//wire [4:0] RegDestSelected_WB;

MemoryToWriteBack MEM_WB_Pipeline(
Clock,
RegWrite_MEM, MemToReg_MEM, R_Data, ALUResult_MEM, RegDestSelected_MEM, PCNew, PCSrc,
RegWrite_WB, MemToReg_WB, R_Data_WB, ALUResult_WB, RegDestSelected_WB, BranchPC_IF, PCSel_IF
);

Write_Back WB_Stage(
R_Data_WB, ALUResult_WB, MemToReg_WB, // Inputs

regWriteData // Outputs
);
always @ (*) begin
PC_To_Instr_Mem_output <= PC_To_Instr_Mem_IF;
regWriteData_output <= regWriteData;
end

endmodule
