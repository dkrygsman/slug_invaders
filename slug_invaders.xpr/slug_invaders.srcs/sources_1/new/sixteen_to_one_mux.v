`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2023 03:10:44 PM
// Design Name: 
// Module Name: sixteen_to_one_mux
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


module sixteen_to_one_mux(
    input [15:0] A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,
    input [3:0] Sel,
    output [15:0] Q
    );
    
    wire [15:0] a_to_e, b_to_e, c_to_e, d_to_e;
    
   
    //mux A
    four_t_one_mux mux_A (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .Sel(Sel[1:0]),
    .Q(a_to_e)
    );
    
    //mux B
    four_t_one_mux mux_B (
    .A(E),
    .B(F),
    .C(G),
    .D(H),
    .Sel(Sel[1:0]),
    .Q(b_to_e)
    );
    
    //mux C
    four_t_one_mux mux_C (
    .A(I),
    .B(J),
    .C(K),
    .D(L),
    .Sel(Sel[1:0]),
    .Q(c_to_e)
    );
    
    //mux D
    four_t_one_mux mux_D (
    .A(M),
    .B(N),
    .C(O),
    .D(P),
    .Sel(Sel[1:0]),
    .Q(d_to_e)
    );
    
    //mux E
    four_t_one_mux mux_E (
    .A(a_to_e),
    .B(b_to_e),
    .C(c_to_e),
    .D(d_to_e),
    .Sel(Sel[3:2]),
    .Q(Q)
    );
    
endmodule
