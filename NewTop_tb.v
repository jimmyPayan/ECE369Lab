`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2023 11:43:47 PM
// Design Name: 
// Module Name: NewTop_tb
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


module NewTop_tb();
    reg Clk;
    wire [6:0] out7; //seg a, b, ... g
    wire [7:0] en_out;
    
    NewTop test(Clk, out7, en_out);
    
    always begin
        Clk <= 0;
        #200;
        Clk <= 1;
        #200;
    end 

endmodule
