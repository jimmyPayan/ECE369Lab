`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 03:22:46 PM
// Design Name: 
// Module Name: SignExtend
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


module SignExtend16Bit(inputValue, outputValue/*, extendSel*/);
//input extendSel; // 0 = 0's extend, 1 = sign extend
input [15:0] inputValue;
output reg [31:0] outputValue;
always @ (*) begin
case (inputValue[15])
    0: outputValue <= {16'h0000, inputValue};
    1: outputValue <= {16'hFFFF, inputValue};
endcase
end

endmodule