`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2023 12:25:59 PM
// Design Name: 
// Module Name: RGB_still
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


module RGB_still(
    input btnL,
    input btnR,
    input btnC,
    input btnD,
    input edge_scre,
    input edge_two,
    input clk,
    input [15:0] Hor,
    input [15:0] Vert,
    output ground,
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output [6:0] checks,
    output [6:0] inputs,
    output [7:0] score
    );
    
    wire when_reload;
    //Still objects 
    wire Rup, Rdown, Rleft, Rright, brown, grass;
    assign Rup = (Hor>=16'd0) & (Hor<=16'd639) & (Vert>=16'd0) & (Vert<=16'd7);
    assign Rdown = (Hor>=16'd0) & (Hor<=16'd639) & (Vert>=16'd472) & (Vert<=16'd479);
    assign Rleft = (Hor>=16'd0) & (Hor<=16'd7) & (Vert>=16'd0) & (Vert<=16'd479);
    assign Rright = (Hor>=16'd632) & (Hor<=16'd639) & (Vert>=16'd0) & (Vert<=16'd479);
    assign brown = (Hor>=16'd8) & (Hor<=16'd631) & (Vert>=16'd408) & (Vert<=16'd471);
    assign grass = (Hor>=16'd8) & (Hor<=16'd631) & (Vert>=16'd400) & (Vert<=16'd407);
   
   wire stop_player_big;
   //Player ///////////////////////////////////////////////////////////////////////////////////
    wire slug;  
    Player player_a(
    .Horizontal(Hor),
    .Verticle(Vert),
    .stop_player_big(stop_player_big),
    .clk(clk),
    .btnL(btnL),
    .btnR(btnR),
    .btnD(btnD),
    .edge_scre(edge_scre),
    .Slug(slug)
    );
    
   
//    //Big State Machine ///////////////////////////////////////////////////////////////////////////////////////////
    wire time_one_big,special_reload_big, reset_time_big,GoA,GoB,GoC,GoD,GoE,stop_big_out,big_stop_in,stop_out_A,stop_out_B, stop_out_C,stop_out_D,stop_out_E;
    wire [7:0] time_big;
    assign big_stop_in = stop_out_A | stop_out_B | stop_out_C | stop_out_D | stop_out_E;
    big_state_machine Big_state_machine_A(
    .T1(time_one_big),
    .btnC(btnC),
    .stop_in(big_stop_in),
    .clk(clk),
    .Go_A(GoA),
    .Go_B(GoB),
    .Go_C(GoC),
    .Go_D(GoD),
    .Go_E(GoE),
    .stop_out(stop_big_out),
    .Reset_time_Top(reset_time_big),
    .special_reload_big(special_reload_big),
    .stop_player(stop_player_big),
    .states(checks)
    );
    wire screen_time_one_Big;
    time_count time_counter_Big(
    .inc(edge_scre),
    .r(reset_time_big),
    .clk(clk),
    .Q(time_big)
    );
    assign time_one_big = time_big == 8'd62;
    wire occ_flash_A, occ_flash_B,occ_flash_C, occ_flash_D, occ_flash_E;
    //Ship State Machine A ///////////////////////////////////////////////////////////////////////////////////////////////////
    wire groundA,reset_time_A,time_one_A,flashA,time_three_A,show_ship_A,show_occ_A,reload_A,ship_move_A,ship_coll_A,occ_coll_A,point_A;
    wire ship_a,occ_a;
    wire [7:0] time_A;
    ship_state_machine ship_state_machine_A(
    .start(btnC),
    .stop_in(stop_big_out),
    .ground(groundA),
    .screen_time_one(time_one_A),
    .screen_time_three(time_three_A),
    .ship_coll(ship_coll_A),
    .occ_coll(occ_coll_A),
    .clk(clk),
    .Special_reload_big(special_reload_big),
    .show_ship(show_ship_A),
    .show_occ(show_occ_A),
    .reset_screen_time(reset_time_A),
    .reload(reload_A),
    .ship_move(ship_move_A),
    .flash(flashA),
    .point(point_A),
    .flash_occ(occ_flash_A),
    .stop_out(stop_out_A)
  //  .checks(checks),
    //.inputs(inputs)
    );
    assign ship_coll_A = ship_a & slug;
    assign occ_coll_A = occ_a & slug;
    time_count time_counterA(
    .inc(edge_scre & ~stop_player_big),
    .r(reset_time_A),
    .clk(clk),
    .Q(time_A)
    );
    assign time_one_A = time_A == 8'd63;
    assign time_three_A = time_A == 8'd188;
    Ship ship_A(
    .edge_x2(edge_two),
    .show_ship(show_ship_A),
    .show_occ(show_occ_A),       
    .ship_move(ship_move_A),
    .reload(reload_A),
    .special_reload(1'b0),
    .clk(clk),
    .Horizontal(Hor),
    .Verticle(Vert),
    .Ship(ship_a),
    .Occupant(occ_a),
    .ground(groundA)
    );

    //Ship State Machine B ///////////////////////////////////////////////////////////////////////////////////////////////////
    wire groundB,reset_time_B,time_one_B,flashB,time_three_B,show_ship_B,show_occ_B,reload_B,ship_move_B,ship_coll_B,occ_coll_B,point_B;
    wire ship_b,occ_b;
    wire [7:0] time_B;
    ship_state_machine ship_state_machine_B(
    .start(GoB),
    .stop_in(stop_big_out),
    .ground(groundB),
    .screen_time_one(time_one_B),
    .screen_time_three(time_three_B),
    .ship_coll(ship_coll_B),
    .occ_coll(occ_coll_B),
    .clk(clk),
    .Special_reload_big(special_reload_big),
    .show_ship(show_ship_B),
    .show_occ(show_occ_B),
    .reset_screen_time(reset_time_B),
    .reload(reload_B),
    .ship_move(ship_move_B),
    .flash(flashB),
    .point(point_B),
    .flash_occ(occ_flash_B),
    .stop_out(stop_out_B)
  //  .checks(checks),
    //.inputs(inputs)
    );
    assign ship_coll_B = ship_b & slug;
    assign occ_coll_B = occ_b & slug;
    time_count time_counterB(
    .inc(edge_scre & ~stop_player_big),
    .r(reset_time_B),
    .clk(clk),
    .Q(time_B)
    );
    assign time_one_B = time_B == 8'd64;
    assign time_three_B = time_B == 8'd186;
    Ship ship_B(
    .edge_x2(edge_two),
    .show_ship(show_ship_B),
    .show_occ(show_occ_B),       
    .ship_move(ship_move_B),
    .reload(reload_B),
    .special_reload(special_reload_big),
    .clk(clk),
    .Horizontal(Hor),
    .Verticle(Vert),
    .Ship(ship_b),
    .Occupant(occ_b),
    .ground(groundB)
    );
    
    
    
    //state machoine C
    wire groundC,reset_time_C,time_one_C,flashC,time_three_C,show_ship_C,show_occ_C,reload_C,ship_move_C,ship_coll_C,occ_coll_C,point_C;
    wire ship_c,occ_c;
    wire [7:0] time_C;
    ship_state_machine ship_state_machine_C(
    .start(GoC),
    .stop_in(stop_big_out),
    .ground(groundC),
    .screen_time_one(time_one_C),
    .screen_time_three(time_three_C),
    .ship_coll(ship_coll_C),
    .occ_coll(occ_coll_C),
    .clk(clk),
    .Special_reload_big(special_reload_big),
    .show_ship(show_ship_C),
    .show_occ(show_occ_C),
    .reset_screen_time(reset_time_C),
    .reload(reload_C),
    .ship_move(ship_move_C),
    .flash(flashC),
    .point(point_C),
    .flash_occ(occ_flash_C),
    .stop_out(stop_out_C)
  //  .checks(checks),
    //.inputs(inputs)
    );
    assign ship_coll_C = ship_c & slug;
    assign occ_coll_C = occ_c & slug;
    time_count time_counterC(
    .inc(edge_scre & ~stop_player_big),
    .r(reset_time_C),
    .clk(clk),
    .Q(time_C)
    );
    assign time_one_C = time_C == 8'd64;
    assign time_three_C = time_C == 8'd186;
    Ship ship_C(
    .edge_x2(edge_two),
    .show_ship(show_ship_C),
    .show_occ(show_occ_C),       
    .ship_move(ship_move_C),
    .reload(reload_C),
    .special_reload(special_reload_big),
    .clk(clk),
    .Horizontal(Hor),
    .Verticle(Vert),
    .Ship(ship_c),
    .Occupant(occ_c),
    .ground(groundC)
    );


//state machoine D
    wire groundD,reset_time_D,time_one_D,flashD,time_three_D,show_ship_D,show_occ_D,reload_D,ship_move_D,ship_coll_D,occ_coll_D,point_D;
    wire ship_d,occ_d;
    wire [7:0] time_D;
    ship_state_machine ship_state_machine_D(
    .start(GoD),
    .stop_in(stop_big_out),
    .ground(groundD),
    .screen_time_one(time_one_D),
    .screen_time_three(time_three_D),
    .ship_coll(ship_coll_D),
    .occ_coll(occ_coll_D),
    .clk(clk),
    .Special_reload_big(special_reload_big),
    .show_ship(show_ship_D),
    .show_occ(show_occ_D),
    .reset_screen_time(reset_time_D),
    .reload(reload_D),
    .ship_move(ship_move_D),
    .flash(flashD),
    .point(point_D),
    .flash_occ(occ_flash_D),
    .stop_out(stop_out_D)
  //  .checks(checks),
    //.inputs(inputs)
    );
    assign ship_coll_D = ship_d & slug;
    assign occ_coll_D = occ_d & slug;
    time_count time_counterD(
    .inc(edge_scre & ~stop_player_big),
    .r(reset_time_D),
    .clk(clk),
    .Q(time_D)
    );
    assign time_one_D = time_D == 8'd64;
    assign time_three_D = time_D == 8'd186;
    Ship ship_D(
    .edge_x2(edge_two),
    .show_ship(show_ship_D),
    .show_occ(show_occ_D),       
    .ship_move(ship_move_D),
    .reload(reload_D),
    .special_reload(special_reload_big),
    .clk(clk),
    .Horizontal(Hor),
    .Verticle(Vert),
    .Ship(ship_d),
    .Occupant(occ_d),
    .ground(groundD)
    );



    
//state machoine E
    wire groundE,reset_time_E,time_one_E,flashE,time_three_E,show_ship_E,show_occ_E,reload_E,ship_move_E,ship_coll_E,occ_coll_E,point_E;
    wire ship_e,occ_e;
    wire [7:0] time_E;
    ship_state_machine ship_state_machine_E(
    .start(GoE),
    .stop_in(stop_big_out),
    .ground(groundE),
    .screen_time_one(time_one_E),
    .screen_time_three(time_three_E),
    .ship_coll(ship_coll_E),
    .occ_coll(occ_coll_E),
    .clk(clk),
    .Special_reload_big(special_reload_big),
    .show_ship(show_ship_E),
    .show_occ(show_occ_E),
    .reset_screen_time(reset_time_E),
    .reload(reload_E),
    .ship_move(ship_move_E),
    .flash(flashE),
    .point(point_E),
    .flash_occ(occ_flash_E),
    .stop_out(stop_out_E)
  //  .checks(checks),
    //.inputs(inputs)
    );
    assign ship_coll_E = ship_e & slug;
    assign occ_coll_E = occ_e & slug;
    time_count time_counterE(
    .inc(edge_scre & ~stop_player_big),
    .r(reset_time_E),
    .clk(clk),
    .Q(time_E)
    );
    assign time_one_E = time_E == 8'd64;
    assign time_three_E = time_E == 8'd186;
    Ship ship_E(
    .edge_x2(edge_two),
    .show_ship(show_ship_E),
    .show_occ(show_occ_E),       
    .ship_move(ship_move_E),
    .reload(reload_E),
    .special_reload(special_reload_big),
    .clk(clk),
    .Horizontal(Hor),
    .Verticle(Vert),
    .Ship(ship_e),
    .Occupant(occ_e),
    .ground(groundE)
    );





    wire combine_up;
    assign combine_up = point_A | point_B | point_C| point_D| point_E;

    wire [15:0] score_out;
    //SCORE COUNTER
    sixteen_bit_counter score_counter(
    .sw(16'h0000),
    .Up(combine_up),
    .Dw(1'b0),
    .LD(special_reload_big),
    .clk(clk),
    .Q(score_out)
    );
    assign score = score_out [7:0] ;
    
    wire reset_time_flash,time_one_flash,New_flash;
    wire [7:0] time_flash;
    time_count time_counter_flash(
    .inc(edge_scre),
    .r(1'b0),
    .clk(clk),
    .Q(time_flash)
    );

    wire global_flash;
    assign global_flash = time_flash[5]; 
    wire total_flash;
    assign total_flash = flashA | flashB | flashC | flashE | flashD;
    wire total_occ_flash;
    
    wire occ_anew, occ_bnew,occ_cnew,occ_dnew,occ_enew;
    assign occ_anew = occ_a & (~occ_flash_A | (occ_flash_A  & global_flash));
    assign occ_bnew = occ_b & (~occ_flash_B  | (occ_flash_B  & global_flash));
    assign occ_cnew = occ_c & (~occ_flash_C  | (occ_flash_C  & global_flash));
    assign occ_dnew = occ_d & (~occ_flash_D  | (occ_flash_D  & global_flash));
    assign occ_enew = occ_e & (~occ_flash_E  | (occ_flash_E  & global_flash));



    assign R = ({4'b1111} & {4{(Rup | Rdown | Rleft | Rright) & (~total_flash | (total_flash & global_flash))}}) | ({4'b0101} & {4{brown}}) | ({4'b1111} & {4{(slug & (~total_flash | (total_flash & global_flash)))}}) | ({4'b1111} & {4{(occ_anew&~Rup) | (occ_bnew&~Rup)| (occ_cnew&~Rup) | (occ_dnew&~Rup)| (occ_enew&~Rup)}});
    assign G = ({4'b1111} & {4{grass}}) | ({4'b0010} & {4{brown}}) | ({4'b1111} & {4{slug & (~total_flash | (total_flash & global_flash))}}) | ({4'b1111} & {4{(occ_anew&~Rup) | (occ_bnew&~Rup)| (occ_cnew&~Rup) | (occ_dnew&~Rup)| (occ_enew&~Rup)}});
    assign B = ({4'b1111} & {4{(ship_a&~Rup) | (ship_b&~Rup)| (ship_c&~Rup) | (ship_d&~Rup) | (ship_e&~Rup)}})  | ({4'b1111} & {4{(occ_anew&~Rup) | (occ_bnew&~Rup)| (occ_cnew&~Rup) | (occ_dnew&~Rup)| (occ_enew&~Rup)}});
    
    
endmodule