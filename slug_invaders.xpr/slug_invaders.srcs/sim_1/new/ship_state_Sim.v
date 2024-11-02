`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2023 10:45:44 AM
// Design Name: 
// Module Name: sixteen_bit_Sim
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


module ship_state_Sim();
    
    
    
    reg start;
    reg stop_in;
    reg ground;
    reg screen_time_one;
    reg screen_time_three;
    reg ship_coll;
    reg occ_coll;
    reg clk;
    wire  show_ship;
    wire  show_occ;
    wire  reset_screen_time;
    wire  reload;
    wire  ship_move;
    wire  flash;
    wire  point;
    wire  flash_occ;
    wire  stop_out;
    wire  [6:0] checks;
    
    ship_state_machine UUT(
    .start(start),
    .stop_in(stop_in),
    .ground(ground),
    .screen_time_one(screen_time_one),
    .screen_time_three(screen_time_three),
    .ship_coll(ship_coll),
    .occ_coll(occ_coll),
    .clk(clk),
    .show_ship(show_ship),
    .show_occ(show_occ),
    .reset_screen_time(reset_screen_time),
    .reload(reload),
    .ship_move(ship_move),
    .flash(flash),
    .point(point),
    .flash_occ(flash_occ),
    .stop_out(stop_out),
    .checks(checks)
    //output [5:0] inputs
    );
   
   
    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

    initial    // Clock process for clkin
    begin
        #OFFSET
		  clk = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = ~clk;
        end
    end
   
    initial
    begin 
    
//    clkin = clkin;
    #50;
    start = 1'b0;
    stop_in = 1'b0;
    ground =1'b0;
    screen_time_one = 1'b0;
    screen_time_three = 1'b0;
    ship_coll = 1'b0;
    occ_coll = 1'b0;
    #50;
    start = 1'b1;
    #15;
    start = 1'b0;
    #50;
    ground = 1'b1;
    #15;
    ground = 1'b0;
    #50; 
    ship_coll = 1'b1;
    #15; 
    ship_coll = 1'b0;
    #50;
    screen_time_one = 1'b1;
    #15;
    screen_time_one = 1'b0;
    #50;
    occ_coll = 1'b1;
    #15;
    occ_coll = 1'b0;
    #50;
    screen_time_one = 1'b1;
    #15;
    screen_time_one = 1'b0;

    
    
    
//    clkin = clkin;
    
    
    end

endmodule

