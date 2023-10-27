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
input [1:0] Select;
output reg [31:0] Out;
always@(*) begin 
    case(Select)
        0 : Out <= A;
        1 : Out <= B;
        2 : Out <= C;
        3 : Out <= D;
        endcase
    end
endmodule