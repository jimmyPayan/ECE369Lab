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
    $readmemh("public_data_memory_lab6.mem", memoryInitial);
end

always @ (negedge Clock) begin

    if (R_en) 
    begin
        case (memReadCommand)
        // lw
        0: R_data = memoryInitial[Address >> 2];
        // lh
        1: 
            case (Address - ((Address >> 2) << 2))
                0:  begin 
//                    R_data <= memoryInitial[Address >> 2][31:16];
                    if (memoryInitial[Address >> 2][31])
                        R_data <= {16'hFFFF , memoryInitial[Address >> 2][31:16]};
                    else 
                        R_data <= {16'h0000 , memoryInitial[Address >> 2][31:16]};
                    end
                    
                2:  begin //R_data <= memoryInitial[Address >> 2][15:0];
                    if (memoryInitial[Address >> 2][15])
                        R_data <= {16'hFFFF , memoryInitial[Address >> 2][15:0]};
                    else 
                        R_data <= {16'h0000 , memoryInitial[Address >> 2][15:0]};                
                    end
                default: R_data <= 32'hXXXXZZZZ;
            endcase
        2: // lb
            case (Address - ((Address >> 2) << 2))
                0: begin 
                //R_data <= memoryInitial[Address >> 2][31:24];
                    if (memoryInitial[Address >> 2][31])
                        R_data <= {24'hFFFFFF, memoryInitial[Address >> 2][31:24]};
                    else 
                        R_data <= {24'h000000, memoryInitial[Address >> 2][31:24]};
                end
                
                1: begin 
                //R_data <= memoryInitial[Address >> 2][23:16];
                    if (memoryInitial[Address >> 2][23])
                        R_data <= {24'hFFFFFF, memoryInitial[Address >> 2][23:16]};
                    else 
                        R_data <= {24'h000000, memoryInitial[Address >> 2][23:16]};                
                end
                2: begin
                    if (memoryInitial[Address >> 2][15])
                        R_data <= {24'hFFFFFF, memoryInitial[Address >> 2][15:8]};
                    else 
                        R_data <= {24'h000000, memoryInitial[Address >> 2][15:8]};                
                //R_data <= memoryInitial[Address >> 2][15:8];
                end
                3: begin 
                //R_data <= memoryInitial[Address >> 2][7:0];
                    if (memoryInitial[Address >> 2][7])
                        R_data <= {24'hFFFFFF, memoryInitial[Address >> 2][7:0]};
                    else 
                        R_data <= {24'h000000, memoryInitial[Address >> 2][7:0]};                
                end
                default: R_data <= 32'hXXXXZZZZ;
            endcase 
        endcase
    end 
    else if (!R_en)
        R_data <= 0;
end

always @(posedge Clock) begin
    
    if (W_en)
    begin
        case (memWriteCommand)
        0: memoryInitial[Address >> 2] <= W_data;
        1: 
            case (Address - ((Address >> 2) << 2))
                0: memoryInitial[Address >> 2][15:0] <= W_data[15:0];
                2: memoryInitial[Address >> 2][31:16] <= W_data[15:0];
                default: begin end
            endcase
        2: 
            case (Address - ((Address >> 2) << 2))
                0: memoryInitial[Address >> 2][31:24] <= W_data[7:0];
                1: memoryInitial[Address >> 2][23:16] <= W_data[7:0];
                2: memoryInitial[Address >> 2][15:8] <= W_data[7:0];
                3: memoryInitial[Address >> 2][7:0] <= W_data[7:0];
            endcase 
        default: begin end
        endcase
    end

end

endmodule
