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


module ProcessorTopFileMIPS
(
Clock
);
input Clock;

// INSTRUCTION FETCH START
wire PCSel;
wire [31:0] PCPlusFour_IF, BranchPC_IF;
wire [31:0] NewPC_IF, PC_To_InstrMem_IF;
wire [31:0] Instruction_IF;

Mux32bit2to1 PC_Mux(PCPlusFour_IF, BranchPC_IF, NewPC_IF, PCSel_IF);
ProgramCounter Program_Counter(NewPC, PC_To_InstrMem_IF, Clock);
Plus4Adder PC_Iterator(PC_To_InstrMem_IF, PCPlusFour_IF);
InstructionMemory Instr_Mem(PC_To_InstrMem_IF, Instruction_IF);
// INSTRUCTION FETCH END



// IF/ID REGISTER START
wire [31:0] Instruction_ID;
FetchToDecode IF_ID_Pipeline(
Clock, 
Instruction_IF, PCPlusFour_IF,
Instruction_ID, PCPlusFour_ID);
// IF/ID REGISTER END



// INSTRUCTION DECODE START
wire PCSrc_ID, RegSrc0_ID, RegSrc1_ID, RegDst_ID, ALUSrc0_ID, ALUSrc1_ID,
R_Enable_ID, W_Enable_ID, MemToReg_ID, RegWrite_ID, R_Width_ID, W_Width_ID, InstrSel_ID,
rDestSelected_ID, regWriteData_ID, RegData1_ID, RegData2_ID;

Controller SignalController(
Instruction_ID[31:26], Instruction_ID[25:21], Instruction_ID[5:0],
PCSrc_ID, RegSrc0_ID, RegSrc1_ID, RegDst_ID, ALUSrc0_ID, ALUSrc1_ID,
R_Enable_ID, W_Enable_ID, MemToReg_ID, RegWrite_ID, R_Width_ID, W_Width_ID, InstrSel_ID
);

Mux32bit2to1 rs_Mux(Instruction_ID[25:21], 31, rsSelected_ID, RegSrc0_ID);
Mux32bit2to1 rt_Mux(0, Instruction_ID[20:16], rtSelected_ID, RegSrc1_ID);

UpdatedRegisterFile RegisterFile(rsSelected_ID, rtSelected_ID, rDestSelected_ID, regWriteData_ID, RegData1_ID, RegData2_ID, Clock);
// INSTRUCTION DECODE END



// Need to add sign extends
// SignExtend(Instruction[15:0], Imm_ID)
// SignExtend(Instruction[25:0], j_Destination)

// ID/EX Pipeline Register
wire [5:0] Instruction_EX, Opcode_EX;
wire RegDst_EX, ALUSrc0_EX, ALUSrc1_EX, R_Enable_EX, W_Enable_EX, 
InstrSel_EX, RegWrite_EX, MemToReg_EX, R_Width_EX, W_Width_EX;

DecodeToExecute ID_EX_Pipeline(Clock, 
Instruction_ID[31:26], Instruction_ID[5:0], RegDst_ID, ALUSRC0_ID, ALUSrc1_ID, 
R_Enable_ID, W_Enable_ID, BranchSel_ID, RegWrite_ID, MemToReg_ID, R_Width_ID, W_Width_ID,

Instruction_EX, Opcode_EX, RegDst_EX, ALUSRC0_EX, ALUSrc1_EX, 
R_Enable_EX, W_Enable_EX, BranchSel_EX, RegWrite_EX, MemToReg_EX, R_Width_EX, W_Width_EX
);
//(Clock, 
//InstrIn, OpcodeIn, RegDstIn, ALUSrc0In, ALUSrc1In,
//R_EnableIn, W_EnableIn, BranchSelIn, RegWriteIn, MemToRegIn, R_CommandIn, W_CommandIn,

//InstrOut, OpcodeOut, RegDstOut, ALUSrc0Out, ALUSrc1Out, 
//R_EnableOut, W_EnableOut, BranchSelOut, RegWriteOut, MemToRegOut, R_CommandOut, W_CommandOut
//);

// Execute Stage

// EX/MEM Pipeline Register

// Memory Stage

// MEM/WB Pipeline Register

// Write Back Stage
    
endmodule
