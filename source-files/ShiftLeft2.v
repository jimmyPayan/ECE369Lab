module ShiftLeft2(in,out);
  input [31:0] In;
  output reg [31:0] Out;



  always@(*) begin
  Out <= In << 2;
  end
endmodule
  