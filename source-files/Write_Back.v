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


module Write_Back(Clock, RegWrite, MemToReg, R_Data, ALUResult, rDestSelected);
    input Clock, RegWrite, MemToReg;
    input [31:0] ALUResult, R_Data;
    input [4:0] rDestSelected;
    wire [31:0] regWriteData;
    wire [31:0] readData1X;
    wire [31:0] readData2X;


    Mux32bit2to1 mux(R_Data, ALUResult, regWriteData, MemToReg);
    UpdatedRegisterFile writereg(Clock, 0, 0, rDestSelected, regWriteData, RegWrite, readData1X, readData2X);

endmodule
