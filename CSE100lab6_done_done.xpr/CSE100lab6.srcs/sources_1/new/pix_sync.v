`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2023 11:41:31 AM
// Design Name: 
// Module Name: pix_sync
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


module pix_sync(
    input [15:0] Hor,
    input [15:0] Vert,
    output Vsync,
    output Hsync
    );
    
    assign Hsync = (Hor <= 16'd654) | (Hor >= 16'd751);
    assign Vsync = (Vert <= 16'd488) | (Vert >= 16'd491);
    
endmodule
