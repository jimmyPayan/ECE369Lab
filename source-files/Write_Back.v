`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2023 03:05:12 PM
// Design Name: 
// Module Name: Write_Back
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


module Write_Back(RegWrite_In, MemToReg, R_Data, ALUResult, rDestSelected_in, RegWrite_Out, regWriteData, rDestSelected_Out);
    input RegWrite_In, MemToReg;
    input [31:0] ALUResult, R_Data;
    input [4:0] rDestSelected_in;
    output reg RegWrite_Out;
    output reg rDestSelected_Out;
    output reg [31:0] regWriteData;

    always @(*) begin
        RegWrite_Out <= RegWrite_In;
        rDestSelected_Out <= rDestSelected_in;
    end 

    Mux32bit2to1 mux(R_Data, ALUResult, regWriteData, MemToReg);
    

endmodule
