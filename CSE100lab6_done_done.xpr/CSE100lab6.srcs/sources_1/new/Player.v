`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 10:49:16 AM
// Design Name: 
// Module Name: Player
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


module Player(
    input [15:0] Horizontal,
    input [15:0]Verticle,
    input stop_player_big,
    input clk,
    input btnL,
    input btnR,
    input btnD,
    input edge_scre,
    output Slug
    );
    
    
    wire [15:0] T_left, B_left;
    wire right_temp, left_temp;
    wire up_temp, down_temp;
    
    assign right_temp = (btnR & ~btnL & ~btnD & ((B_left+16'd15) < 16'd631) & (T_left == 16'd384)) & edge_scre; 
    assign left_temp = (btnL & ~btnR & ~btnD & (B_left > 16'd8) & (T_left == 16'd384)) & edge_scre; 
    assign down_temp = (btnD & ((T_left+16'd15) < 16'd471)) & edge_scre;
    assign up_temp = (~btnD & (T_left > 16'd384)) & edge_scre;

    //HORIZONTAL MOVEMENT
    sixteen_bit_counter #(.INIT(16'd320)) bottom_left
    (.sw(16'd0),
    .Up(right_temp & ~stop_player_big),
    .Dw(left_temp & ~stop_player_big),
    .LD(1'b0),
    .clk(clk),
    .Q(B_left)
    );
    
    //verticle movement
    sixteen_bit_counter #(.INIT(16'd384)) Top_left
    (.sw(16'd0),
    .Up(down_temp & ~stop_player_big),
    .Dw(up_temp & ~stop_player_big),
    .LD(1'b0),
    .clk(clk),
    .Q(T_left)   
    );
    
    
    
    
    assign Slug = (Horizontal>=B_left) & (Horizontal<=(B_left+16'd15)) & (Verticle>=T_left) & (Verticle<=(T_left+16'd15));
    
    
endmodule
