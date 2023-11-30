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


module ProcessorTopFileMIPS(Clock, PC_To_Instr_Mem_output, regWriteData_output, RegWrite_WB_output, rDestSelected_WB_output);

// Wires used for first time in Instruction Fetch
input Clock; // configure outputs
output reg RegWrite_WB_output;
output reg [4:0] rDestSelected_WB_output;
output reg [31:0] PC_To_Instr_Mem_output;
output reg [31:0] regWriteData_output;

wire PCSel_ID, Stall_PC;
wire [31:0] BranchPC_IF, PCPlusFour_IF, Instruction_IF;
wire [31:0] PC_To_Instr_Mem_IF;
Instruction_Fetch IF_Stage(
Clock, 
PCSel_ID, BranchPC_IF, 0, //Stall_PC hardcoded to 0
Instruction_IF, PCPlusFour_IF, PC_To_Instr_Mem_IF
);

// Wires used for first time in IF/ID
wire [31:0] Instruction_ID, PCPlusFour_ID;
wire Stall_ID;
FetchToDecode IF_ID_Pipeline(
Clock, 
Instruction_IF, PCPlusFour_IF, PCSel_ID, 0, //Stall_ID
Instruction_ID, PCPlusFour_ID
);

// Wires used for first time in Instruction Decode
wire RegDst_ID, ALUSrc0_ID,  R_Enable_ID, W_Enable_ID, MemToReg_ID, RegWrite_ID;
wire [1:0] R_Width_ID, W_Width_ID, ALUSrc1_ID;
wire [31:0] Reg_Data1_ID, Reg_Data2_ID, Imm32b_ID;
wire [4:0] rDestSelected_WB;
wire [31:0] regWriteData;
wire RegWrite_WB;
wire [5:0] Opcode_EX;
wire Stall_ID_EX;
wire [4:0] rDestSelected_MEM;

Instruction_Decode ID_Stage (
Clock, 
// ****Inputs****
// Standard ID Stage
Instruction_ID, PCPlusFour_ID, rDestSelected_WB, regWriteData, RegWrite_WB, // Inputs
// Hazard Detection 
Instruction_ID[25:21], Instruction_ID[20:16], rDestSelected_MEM, Opcode_EX, Opcode_MEM,

// ****Outputs****
//IF Control Signals
PCSel_ID, BranchPC_IF, 
//MEM/WB Control Signals
RegWrite_ID, MemToReg_ID,
// EX/MEM Control Signals
R_Enable_ID, W_Enable_ID, R_Width_ID, W_Width_ID,
// ID/EX Control Signals
RegDst_ID, ALUSrc1_ID, ALUSrc0_ID,
//ID Data Outputs
Reg_Data1_ID, Reg_Data2_ID, Imm32b_ID,

// Hazard Detection Outputs
Stall_PC, Stall_ID, Stall_ID_EX
);

// Wires used for first time in ID/EX
wire MemToReg_EX, RegWrite_EX, R_Enable_EX, W_Enable_EX, RegDst_EX, ALUSrc0_EX;
wire [1:0] R_Width_EX, W_Width_EX, ALUSrc1_EX;
wire [4:0] Shamt_EX, rt_EX, rd_EX;
wire [5:0] Instruction_EX;
wire [5:0] Funct_EX;
wire [31:0] PCPlusFour_EX, Reg_Data1_EX, Reg_Data2_EX, Imm32b_EX;

DecodeToExecute ID_EX_Pipeline(
Clock, 
// ****Inputs****
// MEM/WB Control Signals
RegWrite_ID, MemToReg_ID,
// EX/MEM Control Signals
R_Enable_ID, W_Enable_ID, R_Width_ID, W_Width_ID,
// ID/EX Control Signals 
Instruction_ID[31:26], Instruction_ID[5:0], RegDst_ID, ALUSrc0_ID, ALUSrc1_ID, 
// ID/EX Inputs
Instruction_ID[10:6], Reg_Data1_ID, Reg_Data2_ID, Imm32b_ID, Instruction_ID[20:16], Instruction_ID[15:11], 
// Hazard Detect Inputs
0, //Stall_ID_EX hardcoded to 0

// ****Outputs****
// MEM/WB Control Signals
RegWrite_EX, MemToReg_EX,
// EX/MEM Control Signals
R_Enable_EX, W_Enable_EX, R_Width_EX, W_Width_EX, 
// ID/EX Control Signals
Opcode_EX, Funct_EX, RegDst_EX, ALUSrc0_EX, ALUSrc1_EX,  
// ID/EX Outputs
Shamt_EX, Reg_Data1_EX, Reg_Data2_EX, Imm32b_EX, rt_EX, rd_EX
);

// Wires used for first time in Execute
wire Zero_EX;
wire [27:0] j_sll_two_EX; 
wire [31:0] ALUResult_EX, PC_Plus_Branch_EX;
wire [4:0] rDestSelected_EX;

Execute EX_Stage(
// Control Signals
ALUSrc0_EX, ALUSrc1_EX, 0, 0, RegDst_EX, Opcode_EX, Funct_EX,

// A0 B0 A1 B1 regDest mux inputs from ID
Reg_Data1_EX, Reg_Data2_EX, 0, 0, rt_EX, rd_EX,

// Raw Inputs
Shamt_EX, Imm32b_EX,

// Outputs
ALUResult_EX, PC_Plus_Branch_EX, rDestSelected_EX
);

wire R_Enable_MEM, W_Enable_MEM, RegWrite_MEM, MemToReg_MEM, Zero_MEM;
wire [3:0] BranchSel_MEM;
wire [1:0] R_Width_MEM, W_Width_MEM;
wire [31:0] ALUResult_MEM, PC_Plus_Branch_MEM, Reg_Data2_MEM;
wire [27:0] j_sll_two_MEM;

ExecuteToMemory EX_MEM_Pipeline(
Clock,

// *****Inputs*****
// MEM/WB Control Signals
RegWrite_EX, MemToReg_EX,
// EX/MEM Control Signals
R_Enable_EX, W_Enable_EX, R_Width_EX, W_Width_EX,
// EX/MEM Inputs
ALUResult_EX, Reg_Data2_EX, rDestSelected_EX,

// *****Outputs*****
// MEM/WB Control Signals
RegWrite_MEM, MemToReg_MEM, 
// EX/MEM Control Signals
R_Enable_MEM, W_Enable_MEM, R_Width_MEM, W_Width_MEM,
// EX/MEM Outputs
ALUResult_MEM, Reg_Data2_MEM, rDestSelected_MEM
);

wire [31:0] R_Data_MEM;


Memory MEM_Stage(
Clock,

// Inputs
R_Enable_MEM, W_Enable_MEM, R_Width_MEM, W_Width, ALUResult_MEM, Reg_Data2_MEM, 
// Outputs
R_Data_MEM
);

wire MemToReg_WB; 
wire [31:0] R_Data_WB, ALUResult_WB;

MemoryToWriteBack MEM_WB_Pipeline(
Clock,

// Inputs
RegWrite_MEM, MemToReg_MEM, R_Data_MEM, ALUResult_MEM, rDestSelected_MEM,
// Outputs
RegWrite_WB, MemToReg_WB, R_Data_WB, ALUResult_WB, rDestSelected_WB
);

Write_Back WB_Stage(
R_Data_WB, ALUResult_WB, MemToReg_WB, // Inputs

regWriteData // Outputs
);

always @ (*) begin
rDestSelected_WB_output <= rDestSelected_WB;
RegWrite_WB_output <= RegWrite_WB;
PC_To_Instr_Mem_output <= PC_To_Instr_Mem_IF;
regWriteData_output <= regWriteData;
end

endmodule