`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2023 10:11:29 AM
// Design Name: 
// Module Name: ship_state_machine
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


module ship_state_machine(
    input start,
    input stop_in,
    input ground,
    input screen_time_one,
    input screen_time_three,
    input ship_coll,
    input occ_coll,
    input clk,
    input Special_reload_big,
    output show_ship,
    output show_occ,
    output reset_screen_time,
    output reload,
    output ship_move,
    output flash,
    output point,
    output flash_occ,
    output stop_out,
    output [6:0] checks,
    output [6:0] inputs
    );
    
    wire [7:0] s;
    wire next_chill, next_falling, next_still, next_still2, next_ship_hit, next_freeze, next_flash_occ,next_occ_only ;
    
    assign next_chill = (s[0] & ~start);
    assign next_falling = (s[0] & start) | (s[3] & screen_time_three) | (s[6] & screen_time_one) | (s[4] & start) | (s[1] & ~ground & ~ship_coll & ~stop_in) | (s[5] & start) | (s[7] & start);
    assign next_still = (s[1] & ground) | (s[2] & ~screen_time_one & ~ship_coll & ~stop_in);
    assign next_still2 = (s[2] & screen_time_one) | (s[3] & ~screen_time_three & ~occ_coll & ~stop_in);
    assign next_ship_hit = (s[1] & ship_coll) | (s[4] & ~start) | (s[2] & ship_coll);
    assign next_freeze = (s[1] & stop_in) | (s[5] & ~start) | (s[2] & stop_in);
    assign next_flash_occ = (s[3] & occ_coll) | (s[6] & ~screen_time_one);
    assign next_occ_only = (s[3] & stop_in) | (s[7] & ~start);
    
    
    
    FDRE #(.INIT(1'b1) ) state_0 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_chill), .Q(s[0]));
    FDRE #(.INIT(1'b0) ) state_1 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_falling), .Q(s[1]));
    FDRE #(.INIT(1'b0) ) state_2 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_still), .Q(s[2]));
    FDRE #(.INIT(1'b0) ) state_3 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_still2), .Q(s[3]));
    FDRE #(.INIT(1'b0) ) state_4 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_ship_hit), .Q(s[4]));
    FDRE #(.INIT(1'b0) ) state_5 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_freeze), .Q(s[5]));
    FDRE #(.INIT(1'b0) ) state_6 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_flash_occ), .Q(s[6]));
    FDRE #(.INIT(1'b0) ) state_7 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_occ_only), .Q(s[7]));

    
    assign show_ship = s[1] | s[2] | s[5];
    assign show_occ = s[1] | s[2] | s[3] | s[6] | s[5] | s[7];
    assign ship_move = s[1];
    assign flash = s[4];
    assign reset_screen_time = (s[1] & ground) | (s[2] & screen_time_one) | (s[3] & occ_coll);
    assign reload = (s[0] & start) | (s[3] & screen_time_three) | (s[4] & start) | (s[6] & screen_time_one) | (s[5] & start) | (s[7] & start);
    assign point = (s[3] & occ_coll);
    assign flash_occ = s[6];
    assign stop_out = (s[1] & ship_coll) | (s[2] & ship_coll);
   // assign checks = {s[0], s[1], s[2],s[3], s[4], s[5], s[6]};
    //assign inputs = {start, stop_in, ground, screen_time_one, screen_time_three, ship_coll, occ_coll};
    
    
    
    
    
    
    
    
endmodule
