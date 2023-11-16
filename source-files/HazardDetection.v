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
rs, rt, opcode, rDestSelected,

// Outputs
stall
);

input [4:0] rs, rt, rDestSelected;
input [5:0] opcode;

output reg stall;

always @ (*) begin

// if opcode == R type && ( rDestSelected == rs || rDestSelected == rt ) && (rDestSelected != 0)
//   stall 1

// else if opcode == I type && rDestSelected == rs
//   stall 1

// if (branch)
//   flush 1 - is this right?

end

endmodule
