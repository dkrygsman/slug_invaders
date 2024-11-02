`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 03:01:58 PM
// Design Name: 
// Module Name: sixteen_bit_counter
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


module sixteen_bit_counter #(
    parameter [15:0] INIT = 16'b0)
(
    input [15:0] sw,
    input Up,
    input Dw,
    input LD,
    input clk,
    output [15:0] Q,
    output UTC,
    output DTC
    );
    
    
    
    
    wire UTC_a, UTC_b, UTC_c, UTC_d, DTC_a, DTC_b, DTC_c, DTC_d;
    
    assign UTC = (UTC_a & UTC_b & UTC_c & UTC_d);
    assign DTC = (DTC_a & DTC_b & DTC_c & DTC_d);
    
    
    four_bit_counter #(.INIT(INIT[3:0])) counter_A (.clk(clk),.Up(Up),.Dw(Dw),.LD(LD),.Din(sw[3:0]),.Q(Q[3:0]),.UTC(UTC_a),.DTC(DTC_a));
    
    four_bit_counter #(.INIT(INIT[7:4])) counter_B(.clk(clk),.Up(UTC_a & Up),.Dw(DTC_a & Dw),.LD(LD),.Din(sw[7:4]),.Q(Q[7:4]),.UTC(UTC_b),.DTC(DTC_b));
    four_bit_counter #(.INIT(INIT[11:8])) counter_C(.clk(clk),.Up(UTC_a & UTC_b & Up),.Dw(DTC_a & DTC_b & Dw),.LD(LD),.Din(sw[11:8]),.Q(Q[11:8]),.UTC(UTC_c),.DTC(DTC_c));
    four_bit_counter #(.INIT(INIT[15:12])) counter_D(.clk(clk),.Up(UTC_a & UTC_b & UTC_c & Up),.Dw(DTC_a & DTC_b & DTC_c & Dw),.LD(LD),.Din(sw[15:12]),.Q(Q[15:12]),.UTC(UTC_d),.DTC(DTC_d));
    
    
endmodule
