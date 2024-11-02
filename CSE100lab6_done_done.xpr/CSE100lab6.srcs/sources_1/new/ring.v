`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 10:08:05 AM
// Design Name: 
// Module Name: ring_counter
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


module ring(
    input clk,
    input Inc,
    output [3:0] Q
    );
    
    wire a_to_b, b_to_c, c_to_d, d_to_a;
    
    FDRE #(.INIT(1'b1) ) ff_A (.C(clk), .CE(Inc), .D(d_to_a), .Q(a_to_b));
    FDRE #(.INIT(1'b0) ) ff_B (.C(clk), .CE(Inc), .D(a_to_b), .Q(b_to_c));
    FDRE #(.INIT(1'b0) ) ff_C (.C(clk), .CE(Inc), .D(b_to_c), .Q(c_to_d));
    FDRE #(.INIT(1'b0) ) ff_D (.C(clk), .CE(Inc), .D(c_to_d), .Q(d_to_a));
    
    assign Q[0] = a_to_b;
    assign Q[1] = b_to_c;
    assign Q[2] = c_to_d;
    assign Q[3] = d_to_a;
    
endmodule