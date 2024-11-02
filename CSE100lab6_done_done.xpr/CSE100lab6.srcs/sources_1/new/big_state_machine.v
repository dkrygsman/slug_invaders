`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/02/2023 05:30:13 PM
// Design Name: 
// Module Name: big_state_machine
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


module big_state_machine(
    input T1,
    input btnC,
    input stop_in,
    input clk,
    output Go_A,
    output Go_B,
    output Go_C,
    output Go_D,
    output Go_E,
    output stop_out,
    output Reset_time_Top,
    output special_reload_big,
    output stop_player,
    output [6:0] states
    );
    
    wire [6:0] s;
    wire next_chill, next_RA, next_RB, next_RC, next_RD, next_RE, next_GMO;
     
    
    assign next_chill = (s[0] & ~btnC);
    assign next_RA = (s[0] & btnC) | (s[1] & ~T1 & ~stop_in) | (s[6] & btnC);
    assign next_RB = (s[1] & T1) | (s[2] & ~T1 & ~stop_in);
    assign next_RC = (s[2] & T1) | (s[3] & ~T1 & ~stop_in);
    assign next_RD = (s[3] & T1) | (s[4] & ~T1 & ~stop_in);
    assign next_RE = (s[4] & T1) | (s[5] & ~stop_in);
    assign next_GMO = (s[1] & stop_in) | (s[2] & stop_in) | (s[3] & stop_in) | (s[4] & stop_in) | (s[5] & stop_in) | (s[6] & ~btnC);
    
    FDRE #(.INIT(1'b1) ) state_0 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_chill), .Q(s[0]));
    FDRE #(.INIT(1'b0) ) state_1 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_RA), .Q(s[1]));
    FDRE #(.INIT(1'b0) ) state_2 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_RB), .Q(s[2]));
    FDRE #(.INIT(1'b0) ) state_3 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_RC), .Q(s[3]));
    FDRE #(.INIT(1'b0) ) state_4 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_RD), .Q(s[4]));
    FDRE #(.INIT(1'b0) ) state_5 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_RE), .Q(s[5]));
    FDRE #(.INIT(1'b0) ) state_6 (.C(clk), .R(1'b0), .CE(1'b1), .D(next_GMO), .Q(s[6]));
    
    assign Go_A = (s[0] & btnC);
    assign Go_B = (s[1] & T1);
    assign Go_C = (s[2] & T1);
    assign Go_D = (s[3] & T1);
    assign Go_E = (s[4] & T1);
    assign Reset_time_Top = (s[0] & btnC) | (s[1] & T1) | (s[2] & T1) | (s[3] & T1) | (s[6] & btnC);
    assign stop_out = s[6];
    assign special_reload_big = s[6] & btnC;
    assign stop_player = s[6];
    
    assign states = s;
    
    
endmodule
