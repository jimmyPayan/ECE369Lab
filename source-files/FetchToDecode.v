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
output reg [31:0] InstructionOut;

input [31:0] PCPlusFourIn;
output reg [31:0] PCPlusFourOut;

input PCSel, Stall_ID;

always @ (posedge Clock) begin

if (PCSel == 0 && Stall_ID == 0) begin
    InstructionOut <= InstructionIn;
    PCPlusFourOut <= PCPlusFourIn;
end

else if (PCSel == 1 && Stall_ID == 0) begin 
    InstructionOut <= 0;
    PCPlusFourOut <= 0;
end

// else if (Stall_ID == 1) begin 
// test if we don't need write anything for this output to stay the same upon Stall_ID == 1  
//end 

end

endmodule
