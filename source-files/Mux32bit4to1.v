`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2023 05:44:54 PM
// Design Name: 
// Module Name: Mux32bit4to1
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


module Mux32bit4to1(A, B, C, D, Out, Select);
input [31:0] A, B, C, D;
input Select;
output reg [31:0] Out;
always@(*) begin 
    case(Select)
        32'h00000001 : Out <= A;
        32'h00000002 : Out <= B;
        32'h00000004 : Out <= C;
        32'h00000008 : Out <= D;
        endcase
    end
endmodule
