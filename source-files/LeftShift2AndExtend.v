`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 12:35:22 PM
// Design Name: 
// Module Name: LeftShift2AndExtend
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


module LeftShift2AndExtend(inputVal, outputVal);
input [25:0] inputVal;
output reg [27:0] outputVal;
reg [27:0] temp;

always @(*) begin
temp <= {2'b00, inputVal};
outputVal <= temp << 2;
end
endmodule
