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


module Plus4Adder(ValueIn, ValuePlus4, Stall_PC);

input [31:0] ValueIn;
input Stall_PC;
output reg [31:0] ValuePlus4;

always @ (Stall_PC) begin
case(Stall_PC)
    0: begin ValuePlus4 <= ValueIn + 4; end
    1: begin ValuePlus4 <= ValueIn; end
endcase

end

endmodule
