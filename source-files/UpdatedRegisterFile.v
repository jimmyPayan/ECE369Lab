`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2023 05:34:34 PM
// Design Name: 
// Module Name: RegisterFile
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

// Changes made: Initialized all registers to something, no matter what. Temporary registers are
// initialized with their register index (ie; $4 receives the value 4). 
module UpdatedRegisterFile(
Clk,
ReadReg1, ReadReg2, WAddr, WData, RegWrite, // Inputs
ReadData1, ReadData2 // Outputs
);

    input [4:0] ReadReg1, ReadReg2, WAddr;
    input signed [31:0] WData;
    input RegWrite, Clk;
    output reg signed [31:0] ReadData1, ReadData2;
    
    integer i;
    
    reg signed [31:0] Registers [0:31];
    
    // Initialization Notes: Not 100% sure what to do with registers $1, $26 - $28, $30
    initial begin
        // Zero Register
        Registers[0] <= 0;      
        
        // Initialize registers 2 - 25
        for (i = 2 ; i < 26 ; i = i + 1) begin
        Registers[i] <= i + 100;
        end
        
        // Notes: Registers 26 and 27 are Kernel registers and should not be accessible normally.
        // Make sure users can't read from / write to $26 or $27 
        // There is a "priveliged" mode which can access these registers, but I do not know much about that. -Jimmy
        Registers[26] <= 0;
        Registers[27] <= 0;
        
        // Global Pointer
        Registers[28] <= 0;
        
        // Stack pointer set to top of stack
        Registers[29] <= 1023;
        
        // Frame Pointer
        Registers[30] <= 0;
        
        // Return Address 
        Registers[31] <= 0;
    end
    
    always @(posedge Clk) begin
        if (RegWrite == 1 && (WAddr != 0 && WAddr != 26 && WAddr != 27)) begin
            Registers[WAddr] <= WData;
        end
        
    end
    
    always @(negedge Clk) begin
        ReadData1 <= Registers[ReadReg1];
        ReadData2 <= Registers[ReadReg2];        
    end            
           
endmodule
