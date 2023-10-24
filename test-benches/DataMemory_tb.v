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
reg [31:0] W_addr;
reg [31:0] R_addr;

DataMemory DataMemory_test(
Clock, 
W_en, R_en, 
W_addr, R_addr,
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
R_en <= 0; memReadCommand <= 0; R_addr <= 0; W_en = 0; memWriteCommand <= 0; W_addr <= 0; W_data <= 0;
#150;

// Test lw: Should be 0xEEEEEEEE
R_en = 1; memReadCommand <= 0; R_addr <= 12;
#150;

// Test lh first half: Should be 0123
R_en <= 1; memReadCommand <= 1; R_addr <= 8;
#150;
// Test lh second half: Should be 4567
R_en <= 1; memReadCommand <= 1; R_addr <= 10;
#150;

// Test lb first byte: Should be CA
R_en <= 1; memReadCommand <= 2; R_addr <= 0;
#150; 
// Test lb first byte: Should be DF
R_en <= 1; memReadCommand <= 2; R_addr <= 1;
#150; 
// Test lb first byte: Should be EB
R_en <= 1; memReadCommand <= 2; R_addr <= 2;
#150; 
// Test lb first byte: Should be 89
R_en <= 1; memReadCommand <= 2; R_addr <= 3;
#150; 

// Test sw
R_en <= 0; W_en = 1; memWriteCommand <= 0; W_addr = 24; W_data = 0'hBEADBEAD;
#150; 
// Check sw: Should be BEADBEAD
W_en <= 0; R_en <= 1; memReadCommand <= 0; R_addr <= 24;
#150;

// Test sh
R_en <= 0; W_en = 1; memWriteCommand <= 1; W_addr = 30; W_data = 0'hDDDD;
#150;
// Check sh: Should be 0xDDDD0000
W_en <= 0; R_en <= 1; memReadCommand <= 0; R_addr <= 28;
#150;

// Test sb
R_en <= 0; W_en = 1; memWriteCommand <= 2; W_addr = 33; W_data = 0'hE0;
#150;
W_en <= 0; R_en <= 1; memReadCommand <= 0; R_addr <= 32;
#150;
end

endmodule
