`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2023 10:46:25 AM
// Design Name: 
// Module Name: pix_address
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


module pix_address(
    input clk,
    output [15:0] Hor,
    output [15:0] Vert
    );
    
    wire [15:0] Hor_output, Vert_output;
    wire Hor_reset, Vert_reset;
    
    assign Hor_reset = Hor_output > 16'd798;
    assign Vert_reset = (Vert_output > 16'd523) & Hor_reset;
    
    sixteen_bit_counter sixteen_Hor(
    .sw(16'h0000),
    .Dw(1'b0),
    .Up(1'b1),
    .LD(Hor_reset),
    .clk(clk),
    .Q(Hor_output)
    );
    
    sixteen_bit_counter sixteen_Vert(
    .sw(16'h0000),
    .Dw(1'b0),
    .Up(Hor_reset),
    .LD(Vert_reset),
    .clk(clk),
    .Q(Vert_output)
    );
    
    assign Hor = Hor_output;
    assign Vert = Vert_output;
    
endmodule
