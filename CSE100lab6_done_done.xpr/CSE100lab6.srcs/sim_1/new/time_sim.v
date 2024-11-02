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


module time_sim();
    
    
    reg clk;
    reg inc;
    reg r;
    wire [7:0] Q;
    
    time_count UUT(
    .inc(inc),
    .r(r),
    .clk(clk),
    .Q(Q)
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
    r= 1'b1;
    inc = 1'b1;
    #15;
    r = 1'b0;
    
    end

endmodule

