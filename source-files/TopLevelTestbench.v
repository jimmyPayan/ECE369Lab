`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2023 09:33:23 PM
// Design Name: 
// Module Name: TopLevelTestbench
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


module TopLevelTestbench();
    reg Clock;
    wire [31:0] ProgramCounter;
    wire [31:0] WriteData;
    wire [4:0] rDestSelected;
    wire regWrite;
    wire Stall;
    wire [1:0] ALUSrcA1, ALUSrcB1;
    
    
    ProcessorTopFileMIPS test(Clock, ProgramCounter, WriteData, regWrite, rDestSelected, Stall, ALUSrcA1, ALUSrcB1);
    
    always begin
        Clock <= 0;
        #75;
        Clock <= 1;
        #75;
    end 

endmodule
