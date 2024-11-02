`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 03:01:49 PM
// Design Name: 
// Module Name: four_t_one_mux
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


module four_t_one_mux(
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [1:0] Sel,
    output [15:0] Q
    );
    
    assign Q = (A & {16{~Sel[1]}} & {16{~Sel[0]}}) | (B & {16{~Sel[1]}} & {16{Sel[0]}}) | (C & {16{Sel[1]}} & {16{~Sel[0]}}) | (D & {16{Sel[1]}} & {16{Sel[0]}});
   
endmodule
