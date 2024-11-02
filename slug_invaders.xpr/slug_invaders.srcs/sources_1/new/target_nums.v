`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2023 10:26:15 AM
// Design Name: 
// Module Name: target
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


module target_nums(
    input [15:0] D,
    input CE,
    input clk,
    output [15:0] Q
    );
    
    
    FDRE #(.INIT(16'b0) ) ff_A [15:0](.C({16{clk}}), .R(16'b0), .CE({16{CE}}), .D(D), .Q(Q));
    
    
    
endmodule
