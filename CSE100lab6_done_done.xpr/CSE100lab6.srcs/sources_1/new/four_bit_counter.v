`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 12:52:24 PM
// Design Name: 
// Module Name: four_bit_counter
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


module four_bit_counter #(
    parameter [3:0] INIT = 4'b0
)(
    input clk,
    input Up,
    input Dw,
    input LD,
    input [3:0] Din,
    output [3:0] Q,
    output UTC,
    output DTC
    );
    
    wire [3:0] D;
    
    //assign D [0] = (LD&Din[0]) | (~LD & ((Q[0]^(Up))|(Q[0])^(Dw))&(Up^Dw));
    //assign D [1] = (LD&Din[1]) | (~LD & ((Q[1]^(Up&Q[0]))|(Q[1])^(Dw&~Q[0]))&(Up^Dw));
    //assign D [2] = (LD&Din[2]) | (~LD & ((Q[2]^(Up&Q[0]&Q[1]))|(Q[2])^(Dw&~Q[0]&~Q[1]))&(Up^Dw));
    //assign D [3] = (LD&Din[3]) | (~LD & ((Q[3]^(Up&Q[0]&Q[1]&Q[2]))|(Q[3])^(Dw&~Q[0]&~Q[1]&~Q[2]))&(Up^Dw));
    assign D [0] = (LD&Din[0])|(~LD&((Up&~Dw&(Q[0]^Up))|(~Up&Dw&(Q[0]^Dw))));
    assign D [1] = (LD&Din[1])|(~LD&((Up&~Dw&(Q[1]^(Up&Q[0])))|(~Up&Dw&(Q[1]^(Dw&~Q[0])))));
    assign D [2] = (LD&Din[2])|(~LD&((Up&~Dw&(Q[2]^(Up&Q[1]&Q[0])))|(~Up&Dw&(Q[2]^(Dw&~Q[1]&~Q[0])))));
    assign D [3] = (LD&Din[3])|(~LD&((Up&~Dw&(Q[3]^(Up&Q[2]&Q[1]&Q[0])))|(~Up&Dw&(Q[3]^(Dw&~Q[2]&~Q[1]&~Q[0])))));
    
  //  wire a_to_b, b_to_c, c_to_d, d_to_a;
    FDRE #(.INIT(INIT[0]) ) ff_counter_A (.C(clk), .R(1'b0), .CE(Up | Dw | LD), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(INIT[1]) ) ff_counter_B (.C(clk), .R(1'b0), .CE(Up | Dw | LD), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(INIT[2]) ) ff_counter_C (.C(clk), .R(1'b0), .CE(Up | Dw | LD), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(INIT[3]) ) ff_counter_D (.C(clk), .R(1'b0), .CE(Up | Dw | LD), .D(D[3]), .Q(Q[3]));

    assign UTC = (&Q);
    assign DTC = ~(|Q);
    
    
endmodule
