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


module pix_Sim();
    
    
    reg clk;
    
    wire [15:0] Hor;
    wire [15:0] Vert;
    
    pix_address UUT(
    .clk(clk),
    .Hor(Hor),
    .Vert(Vert)
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
    
    
    #500;
    
//    clkin = clkin;
    
    
    end

endmodule
