`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2023 12:44:01 PM
// Design Name: 
// Module Name: GradualMIPSProcessor
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


module GradualMIPSProcessor(Clock, regWriteData_output, PC_To_Instr_Mem_output);
// Wires used for first time in Instruction Fetch
input Clock; // configure outputs
output reg [31:0] PC_To_Instr_Mem_output;
output reg [31:0] regWriteData_output;

wire PCSel_IF;
wire [31:0] BranchPC_IF, PCPlusFour_IF, Instruction_IF;
wire [31:0] PC_To_Instr_Mem_IF;

Instruction_Fetch IF(
Clock, PCSel_IF, BranchPC_IF,
Instruction_IF, PCPlusFour_IF, PC_To_Instr_Mem_IF
);

// Wires used for first time in IF/ID
wire [31:0] Instruction_ID, PCPlusFour_ID;

FetchToDecode IF_ID(
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
wire [31:0] regWriteData_WB;
wire regWrite_WB;

Instruction_Decode ID (
Clock, 
Instruction_ID, RegDestSelected_WB, regWriteData_WB, regWrite_WB, // Inputs

PCSel_ID, RegDst_ID, ALUSrc0_ID, ALUSrc1_ID, R_Enable_ID, W_Enable_ID, // Controller Outputs
R_Width_ID, W_Width_ID, MemToReg_ID, RegWrite_ID, BranchSel_ID, // Controller Outputs cont.
Reg_Data1_ID, Reg_Data2_ID, // Register File Outputs
Imm32b_ID // Sign Extend Output
);








// Concurrent assignment to outputs
always @ (*) begin
PC_To_Instr_Mem_output <= PC_To_Instr_Mem_IF;
regWriteData_output <= regWriteData_WB;
end

endmodule
