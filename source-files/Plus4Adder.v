`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2023 07:30:51 PM
// Design Name: 
// Module Name: Plus4Adder
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


module Plus4Adder(ValueIn, ValuePlus4);

input [31:0] ValueIn;
output reg [31:0] ValuePlus4;

always @ (*) begin
 ValuePlus4 <= ValueIn + 4;
end

endmodule
