`timescale 1ns / 1ps

module Add(A, B, Out);
input [31:0] A, B;
output reg [31:0] Out;

always@(*) begin
Out <= A + B;
end

endmodule
