`timescale 1ns / 1ps

module Mux5bit2to1(A, B, Out, Select);
input [4:0] A, B;
input Select;
output reg [4:0] Out;

always@(*) begin 
    if (Select > 0) begin
    Out <= B;
    end
    
    else begin
    Out <= A;
    end
end
endmodule
