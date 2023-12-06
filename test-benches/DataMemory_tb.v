`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2023 11:59:13 AM
// Design Name: 
// Module Name: DataMemory_tb
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


module DataMemory_tb();

reg Clock;
reg W_en;
reg R_en;
reg [1:0] memReadCommand; // 0 = lw, 1 = lh, 2 = lb 
reg [1:0] memWriteCommand; // 0 = sw, 1 = sh, 2 = sb 
wire [31:0] R_data;
reg [31:0] W_data;
reg [31:0]Address;

DataMemory DataMemory_test(
Clock, 
W_en, R_en, 
Address,
R_data, W_data,
memReadCommand, memWriteCommand
);

always begin
Clock <= 0;
#25;
Clock <= 1;
#25;
end


initial begin

// Initialize
R_en <= 0; memReadCommand <= 0; W_en = 0; memWriteCommand <= 0; Address <= 0; W_data <= 0;
#150;

// Test lw: Should be 0xEEEEEEEE
R_en = 1; memReadCommand <= 0; Address <= 0;
#150;

// Test lw: Should be 0xEEEEEEEE
R_en = 1; memReadCommand <= 0; Address <= 4;
#150;

// Test lw: Should be 0xEEEEEEEE
R_en = 1; memReadCommand <= 0; Address <= 8;
#150;

// Test lw: Should be 0xEEEEEEEE
R_en = 1; memReadCommand <= 0; Address <= 12;
#150;

// Test lw: Should be 0xEEEEEEEE
R_en = 1; memReadCommand <= 0; Address <= 16;
#150;

// Test lh first half: Should be 0123
R_en <= 0; memReadCommand <= 1; Address <= 8;
#150;

// Test lh first half: Should be 0123
R_en <= 1; memReadCommand <= 1; Address <= 8;
#150;
// Test lh second half: Should be 4567
R_en <= 1; memReadCommand <= 1; Address <= 10;
#150;

// Test lb first byte: Should be CA
R_en <= 1; memReadCommand <= 2; Address <= 0;
#150; 
// Test lb first byte: Should be DF
R_en <= 1; memReadCommand <= 2; Address <= 1;
#150; 
// Test lb first byte: Should be EB
R_en <= 1; memReadCommand <= 2; Address <= 2;
#150; 
// Test lb first byte: Should be 89
R_en <= 1; memReadCommand <= 2; Address <= 3;
#150; 

// Test sw
R_en <= 0; W_en <= 1; memWriteCommand <= 0; Address <= 24; W_data <= 32'hBEADBEAD;
#150; 
// Check sw: Should be BEADBEAD
W_en <= 0; R_en <= 1; memReadCommand <= 0; Address <= 24;
#150;

// Test sh
R_en <= 0; W_en <= 1; memWriteCommand <= 1; Address <= 30; W_data <= 32'h0000DDDD;
#150;
// Check sh: Should be 0xDDDD0000
W_en <= 0; R_en <= 1; memReadCommand <= 0; Address <= 28;
#150;

// Test sb
R_en <= 0; W_en <= 1; memWriteCommand <= 2; Address <= 33; W_data <= 32'h000000E0;
#150;
W_en <= 0; R_en <= 1; memReadCommand <= 0; Address <= 32;
#150;
end

endmodule
