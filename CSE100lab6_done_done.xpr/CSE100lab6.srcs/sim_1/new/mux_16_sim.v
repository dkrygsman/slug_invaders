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


module mux_16_sim();
    
    reg [15:0] A;
    reg [15:0] B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
    reg [3:0] Sel;
    wire [15:0] Q;
    
    sixteen_to_one_mux UUT(
    .A(A),.B(B),.C(C),.D(D),.E(E),.F(F),.G(G),.H(H),.I(I),.J(J),.K(K),.L(L),.M(M),.N(N),.O(O),.P(P),
    .Sel(Sel),
    .Q(Q)
    );
   
   
    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;

    initial    // Clock process for clkin
    begin
        
  
    A = 16'b0000;
    B = 16'h1111;
    C = 16'h2222;
    D = 16'h3333;
    E = 16'h4444;
    F = 16'h5555;
    G = 16'h6666;
    H = 16'h7777;
    I  = 16'h8888;
    J  = 16'h9999;
    K  = 16'hAaaa;
    L = 16'hBbbb;
    M = 16'hCccc;
    N = 16'hDddd;
    O = 16'hEeee; 
    P  = 16'hFfff;
                    
    
    Sel = 4'h0;
    #10;
    Sel = 4'h1;
    #10;
    Sel = 4'h2;
    #10;
    Sel = 4'h3;
    #10;
    Sel = 4'h4;
    #10;
    Sel = 4'h5;
    #10;
    Sel = 4'h6;
    #10;
    Sel = 4'h7;
    #10;
    Sel = 4'h8;
    #10;
    Sel = 4'h9;
    #10;
    Sel = 4'ha;
    #10;
    Sel = 4'hb;
    #10;
    Sel = 4'hc;
    #10;
    Sel = 4'hd;
    #10;
    Sel = 4'he;
    #10;
    Sel = 4'hf;
    
    
    
    
    end

endmodule
