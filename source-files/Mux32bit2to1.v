`timescale 1ns / 1ps

module Mux32bit2to1(A, B, Out, Select);
input [31:0] A, B;
input Select;
output reg [31:0] Out;

always@(*) begin 
    case(Select)
    0: Out <= A; 
    1: Out <= B;
    endcase
end
endmodule