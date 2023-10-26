`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2023 12:14:29 PM
// Design Name: 
// Module Name: SignExtend5to32
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


module SignExtend5to32(inputVal, outputVal);
input [4:0] inputVal;
output reg [31:0] outputVal;

always @(*) begin
    outputVal <= {27'b000000000000000000000000000, inputVal};

end

endmodule
