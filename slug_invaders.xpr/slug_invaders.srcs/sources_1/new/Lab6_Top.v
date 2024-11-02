`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2023 01:08:18 PM
// Design Name: 
// Module Name: Lab6_Top
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


module Lab6_Top(
    input clkin,
    input btnU,
    input btnC,
    input btnL,
    input btnR,
    input btnD,
    input [15:0] sw,
    output Hsync,
    output Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg,
    output dp
    );
    
    
    wire clk, digsel, fastclk;
    wire [15:0] Horizontal, Verticle;
    wire tempHsync, tempVsync;
    wire [3:0] tempRsync, tempGsync, tempBsync;
    wire reset_screen_time;
    
    //Pixel Address
    pix_address pix_address_A(
    .clk(clk),
    .Hor(Horizontal),
    .Vert(Verticle)
    );
    
    wire [15:0] score;
    
    
    
    
    
    wire edge_num2;
    //EDGE DETECT
    wire edge_s;
    edge_detector screen_edge(
    .horizontal(Horizontal),
    .verticle(Verticle),
    .e(edge_s),
    .e_x2(edge_num2)
    );
    
    
    
    
    
    
    //Syncs
    pix_sync pix_sync_A(
    .Hor(Horizontal),
    .Vert(Verticle),
    .Vsync(tempVsync),
    .Hsync(tempHsync)
    );
    FDRE #(.INIT(1'b1) ) Hsync_sync (.C(clk), .R(1'b0), .CE(1'b1), .D(tempHsync), .Q(Hsync));
    FDRE #(.INIT(1'b1) ) Vsync_sync (.C(clk), .R(1'b0), .CE(1'b1), .D(tempVsync), .Q(Vsync));
    
    wire [7:0] my_score;
    wire [6:0] checks;
    wire [6:0] inputs;
    //Still Objects
    RGB_still rgb_still_a(
    .btnL(btnL),
    .btnR(btnR),
    .btnD(btnD),
    .btnC(btnC),
    .edge_scre(edge_s),
    .edge_two(edge_num2),
    .clk(clk),
    .Hor(Horizontal),
    .Vert(Verticle),
    .R(tempRsync),
    .G(tempGsync),
    .B(tempBsync),
    .checks(checks),
    .inputs(inputs),
    .score(my_score)
    );
    FDRE #(.INIT(1'b1) ) red_sync[3:0] (.C(clk), .R(1'b0), .CE(1'b1), .D(tempRsync), .Q(vgaRed));
    FDRE #(.INIT(1'b0) ) green_sync[3:0] (.C(clk), .R(1'b0), .CE(1'b1), .D(tempGsync), .Q(vgaGreen));
    FDRE #(.INIT(1'b0) ) blue_sync[3:0] (.C(clk), .R(1'b0), .CE(1'b1), .D(tempBsync), .Q(vgaBlue));
    
    
    //CLOCKS
    labVGA_clks clocks(
    .clkin(clkin),
    .greset(btnU),  //btnR
    .clk(clk),
    .digsel(digsel),
    //output qsec,
    .fastclk(fastclk)
    );
    
    
    wire [3:0] four;
    ring RingA(
    .clk(clk),
    .Inc(digsel),
    .Q(four)                  //4
    );
    
    wire [3:0] sel;
    select selA(
    .sel(four),              //4
    .N({8'b0, my_score}),                     //16
    .M(sel)                      //4
    );
    
    sev sevA(
    .n(sel),                     //4
    .seg(seg)                      //7
    );
    
    
    
    
    assign dp = {1'b1};
  
    assign an = {1'b1,1'b1,~four[1],~four[0]};
    
    assign led [15:0] = 16'b1;
endmodule
