`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2023 11:37:41 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
Clock, 
W_en, R_en, 
Address,
R_data, W_data,
memReadCommand, memWriteCommand
);

input Clock;
input W_en;
input R_en;
input [1:0] memReadCommand; // 0 = lw, 1 = lh, 2 = lb 
input [1:0] memWriteCommand; // 0 = sw, 1 = sh, 2 = sb 
output reg signed [31:0] R_data;
input signed [31:0] W_data;
input [31:0] Address;

reg signed [31:0] memoryInitial [0:1023];

initial 
begin    // Read in memory from .mem file
    $readmemh("data_memory.mem", memoryInitial);
end

always @ (posedge Clock) begin

    if (R_en) 
    begin
        case (memReadCommand)
        0: R_data = memoryInitial[Address >> 2];
        1: 
            case (Address - ((Address >> 2) << 2))
                0:  R_data = memoryInitial[Address >> 2][31:16];
                2:  R_data = memoryInitial[Address >> 2][15:0];
            endcase
        2: 
            case (Address - ((Address >> 2) << 2))
                0: R_data = memoryInitial[Address >> 2][31:24];
                1: R_data = memoryInitial[Address >> 2][23:16];
                2: R_data = memoryInitial[Address >> 2][15:8];
                3: R_data = memoryInitial[Address >> 2][7:0];
            endcase 
        endcase
    end 
    if (W_en)
    begin
        case (memWriteCommand)
        0: memoryInitial[Address >> 2] = W_data;
        1: 
            case (Address - ((Address >> 2) << 2))
                0: memoryInitial[Address >> 2][15:0] = W_data[15:0];
                2: memoryInitial[Address >> 2][31:16] = W_data[15:0];
            endcase
        2: 
            case (Address - ((Address >> 2) << 2))
                0: memoryInitial[Address >> 2][31:24] = W_data[7:0];
                1: memoryInitial[Address >> 2][23:16] = W_data[7:0];
                2: memoryInitial[Address >> 2][15:8] = W_data[7:0];
                3: memoryInitial[Address >> 2][7:0] = W_data[7:0];
            endcase  
        endcase
    end

end

endmodule
