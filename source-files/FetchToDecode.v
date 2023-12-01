`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 09:44:21 PM
// Design Name: 
// Module Name: FetchToDecode
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


module FetchToDecode(Clock, 
InstructionIn, PCPlusFourIn, PCSel, Stall_ID,
InstructionOut, PCPlusFourOut
);
input Clock;

input [31:0] InstructionIn;
output wire [31:0] InstructionOut;

reg [31:0] Instruction_reg;
reg [31:0] PCPlusFour_reg;

input [31:0] PCPlusFourIn;
output wire [31:0] PCPlusFourOut;

input PCSel, Stall_ID;

always @ (posedge Clock) begin

if (PCSel == 0 && Stall_ID == 0) begin
    Instruction_reg <= InstructionIn;
    PCPlusFour_reg <= PCPlusFourIn;
end

else if (PCSel == 1 && Stall_ID == 0) begin 
    Instruction_reg <= 0;
    PCPlusFour_reg <= 0;
end

// else if (Stall_ID == 1) begin 
// test if we don't need write anything for this output to stay the same upon Stall_ID == 1  
//end 

end

assign InstructionOut = Instruction_reg;
assign PCPlusFourOut = PCPlusFour_reg;

endmodule
