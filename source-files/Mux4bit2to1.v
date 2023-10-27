`timescale 1ns / 1ps

module Mux5bit2to1(A, B, Out, Select);
input [4:0] A, B;
input Select;
output reg [4:0] Out;

always@(*) begin 
    case (Select)
    0: Out <= A;
    1: Out <= B;
    endcase
end
endmodule
