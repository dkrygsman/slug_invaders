`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2023 05:13:28 PM
// Design Name: 
// Module Name: Random_num
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


module rando_num(
    //input [3:0] Din,
    input clk,
    output [7:0] rnd
    );
   
   
   
    FDRE #(.INIT(1'b0) ) ff_A (.C(clk), .CE(1'b1), .D(rnd[0]^rnd[5]^rnd[6]^rnd[7]), .Q(rnd[0]));
    FDRE #(.INIT(1'b0) ) ff_B (.C(clk), .CE(1'b1), .D(rnd[0]), .Q(rnd[1]));
    FDRE #(.INIT(1'b1) ) ff_c (.C(clk), .CE(1'b1), .D(rnd[1]), .Q(rnd[2]));
    FDRE #(.INIT(1'b0) ) ff_d (.C(clk), .CE(1'b1), .D(rnd[2]), .Q(rnd[3]));
    FDRE #(.INIT(1'b0) ) ff_e (.C(clk), .CE(1'b1), .D(rnd[3]), .Q(rnd[4]));
    FDRE #(.INIT(1'b0) ) ff_f (.C(clk), .CE(1'b1), .D(rnd[4]), .Q(rnd[5]));
    FDRE #(.INIT(1'b0) ) ff_g (.C(clk), .CE(1'b1), .D(rnd[5]), .Q(rnd[6]));
    FDRE #(.INIT(1'b0) ) ff_h (.C(clk), .CE(1'b1), .D(rnd[6]), .Q(rnd[7]));
    
endmodule