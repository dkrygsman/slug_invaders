`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/24/2023 10:07:19 AM
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
    input [15:0] horizontal,
    input [15:0] verticle,
    output e,
    output e_x2
    );
    
    
    assign e = (horizontal == 16'd641) & (verticle == 16'd480);
    
    assign e_x2 = ((horizontal==16'd641)&(verticle==16'd480)) | ((horizontal==16'd752)&(verticle==16'd520));
    
    
endmodule