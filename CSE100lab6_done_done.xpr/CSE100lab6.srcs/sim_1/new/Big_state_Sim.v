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


module Big_state_Sim();
    
    
    reg T1;
    reg btnC;
    reg stop_in;
    reg clk;
    wire Go_A;
    wire Go_B;
    wire Go_C;
    wire Go_D;
    wire Go_E;
    wire stop_out;
    wire Reset_time_Top;
    wire [6:0] states;
    
    
    
    big_state_machine(
    .T1(T1),
    .btnC(btnC),
    .stop_in(stop_in),
    .clk(clk),
    .Go_A(Go_A),
    .Go_B(Go_B),
    .Go_C(Go_C),
    .Go_D(Go_D),
    .Go_E(Go_E),
    .stop_out(stop_out),
    .Reset_time_Top(Reset_time_Top),
    .states(states)
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
    T1 = 1'b0;
    btnC = 1'b0;
    stop_in = 1'b0;
    #50;
    btnC = 1'b1;
    #15;
    btnC = 1'b0;
    #50;
    T1 = 1'b1;
    #15;
    T1 = 1'b0;
    #50;
    T1 = 1'b1;
    #15;
    T1 = 1'b0;
    #50;
    T1 = 1'b1;
    #15;
    T1 = 1'b0;
    #50;
    T1 = 1'b1;
    #15;
    T1 = 1'b0;
    #50;
    T1 = 1'b1;
    #15;
    T1 = 1'b0;
    
    
    
    
//    clkin = clkin;
    
    
    end

endmodule
