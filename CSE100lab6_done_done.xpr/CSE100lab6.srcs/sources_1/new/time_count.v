`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2023 05:31:08 PM
// Design Name: 
// Module Name: time_count
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


module time_count(
    input inc,
    input r,
    input clk,
    output [7:0] Q
    );
    
    wire ba,bb,bc,bd,be,bf,bg,bh;
    
    
    FDRE #(.INIT(1'b0) ) ff_a (.C(clk), .R(r), .CE(1'b1), .D(inc^ba), .Q(ba));
    FDRE #(.INIT(1'b0) ) ff_b (.C(clk), .R(r), .CE(1'b1), .D((inc&ba)^bb), .Q(bb));
    FDRE #(.INIT(1'b0) ) ff_c (.C(clk), .R(r), .CE(1'b1), .D(((inc&ba)&bb)^bc), .Q(bc));
    FDRE #(.INIT(1'b0) ) ff_d (.C(clk), .R(r), .CE(1'b1), .D((((inc&ba)&bb)&bc)^bd), .Q(bd));
    FDRE #(.INIT(1'b0) ) ff_e (.C(clk), .R(r), .CE(1'b1), .D(((((inc&ba)&bb)&bc)&bd)^be), .Q(be));
    FDRE #(.INIT(1'b0) ) ff_f (.C(clk), .R(r), .CE(1'b1), .D((((((inc&ba)&bb)&bc)&bd)&be)^bf), .Q(bf));
    FDRE #(.INIT(1'b0) ) ff_g (.C(clk), .R(r), .CE(1'b1), .D(((((((inc&ba)&bb)&bc)&bd)&be)&bf)^bg), .Q(bg));
    FDRE #(.INIT(1'b0) ) ff_h (.C(clk), .R(r), .CE(1'b1), .D((((((((inc&ba)&bb)&bc)&bd)&be)&bf)&bg)^bh), .Q(bh));
    
    
    assign Q = {bh, bg, bf, be, bd, bc, bb, ba};
    
    
endmodule
