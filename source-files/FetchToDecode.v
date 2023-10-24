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
InstructionIn, PCPlusFourIn,
InstructionOut, PCPlusFourOut
);
input Clock;

input [31:0] InstructionIn;
output reg [31:0] InstructionOut;

input [31:0] PCPlusFourIn;
output reg [31:0] PCPlusFourOut;

always @ (posedge Clock) begin
InstructionOut <= InstructionIn;
PCPlusFourOut <= PCPlusFourIn;
end

endmodule
