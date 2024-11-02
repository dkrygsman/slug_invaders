`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2023 10:20:47 AM
// Design Name: 
// Module Name: Ship
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


module Ship(
    input edge_x2,          
    input ship_move,
    input clk,
    input reload,
    input [15:0] Horizontal,
    input [15:0] Verticle,
    input show_ship,
    input show_occ,
    input special_reload,
    output Ship,
    output Occupant,
    output ground
    );
    
    wire [7:0] rand;
    
    rando_num rando_A(
    //input [3:0] Din,
    .clk(clk),
    .rnd(rand)
    );

    
    
    wire [15:0] position, width, point, ship_point;
    wire [15:0] position_to_target, width_to_target, point_to_target;
    
    sixteen_to_one_mux MUX_position(
    .A(16'd8),
    .B(16'd39),
    .C(16'd70),
    .D(16'd101),
    .E(16'd132),
    .F(16'd163),
    .G(16'd194),
    .H(16'd225),
    .I(16'd256),
    .J(16'd287),
    .K(16'd318),
    .L(16'd349),
    .M(16'd380),
    .N(16'd411),
    .O(16'd442),
    .P(16'd504),
    .Sel(rand[3:0]),
    .Q(position_to_target)
    );
    
    four_t_one_mux MUX_Width(
    .A(16'd31),
    .B(16'd63),
    .C(16'd95),
    .D(16'd127),
    .Sel(rand[1:0]),
    .Q(width_to_target)
    );
    
    four_t_one_mux MUX_point(
    .A(16'd12),
    .B(16'd28),
    .C(16'd44),
    .D(16'd60),
    .Sel(rand[1:0]),
    .Q(point_to_target)
    );
    
    target_nums target_position(
    .D(position_to_target),
    .CE(reload),
    .clk(clk),
    .Q(position)
    );
    
    target_nums target_width(
    .D(width_to_target),
    .CE(reload),
    .clk(clk),
    .Q(width)
    );
    
    target_nums target_point(
    .D(point_to_target),
    .CE(reload),
    .clk(clk),
    .Q(point)
    );
    
    wire ship_move_temp;
    
    sixteen_bit_counter #(.INIT(16'd0)) ship_counter
    (.sw(16'd65534),
    .Up(ship_move_temp),
    .Dw(1'b0),
    .LD(reload | special_reload),
    .clk(clk),
    .Q(ship_point)   
    );
    
    assign ship_move_temp = ship_move & edge_x2;
    assign Ship = ((Horizontal>=position) & (Horizontal<=(position+width)) & (Verticle>=ship_point) & (Verticle<=(ship_point+16'd9))) & show_ship;
    assign ground = (ship_point+16'd9) > 16'd398;
    assign Occupant = ((Horizontal>=(position+point)) & (Horizontal<=((position+point)+16'd7)) & (Verticle>=(ship_point+16'd1)) & (Verticle<=(ship_point+16'd8))) & show_occ;
    
    
endmodule
