`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 03:50:17 AM
// Design Name: 
// Module Name: LeftShift2
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


module LeftShift2(valueIn, valueLSS2);
input [31:0] valueIn;
output reg [31:0] valueLSS2;

always @ (*) begin
valueLSS2 <= valueIn << 2;
end

endmodule
