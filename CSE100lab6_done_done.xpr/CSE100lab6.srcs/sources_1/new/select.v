`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 12:51:58 PM
// Design Name: 
// Module Name: four_bus_selector
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


module select(
    input [3:0] sel,
    input [15:0] N,
    output [3:0] M
    );
    
    assign M = ({4{sel[0]}}&N[3:0])|({4{sel[1]}}&N[7:4])|({4{sel[2]}}&N[11:8])|({4{sel[3]}}&N[15:12]);
    
endmodule
