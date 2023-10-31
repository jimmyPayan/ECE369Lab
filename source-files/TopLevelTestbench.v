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
    
    ProcessorTopFileMIPS test(Clock, ProgramCounter, WriteData);
    
    always begin
        Clock <= 0;
        #200;
        Clock <= 1;
        #200;
    end 

endmodule
