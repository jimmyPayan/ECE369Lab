`timescale 1ns / 1ps

module Mux32bit2to1(A, B, Out, Select);
input [31:0] A, B;
input Select;
output reg [31:0] Out;

always@(*) begin 
    if (Select > 0) begin
    Out <= B;
    end
    
    else begin
    Out <= A;
    end
end
endmodule
