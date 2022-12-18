`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 11:25:06
// Design Name: 
// Module Name: matrix_max_tb
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


module matrix_max_tb();

localparam T=10;

reg [7:0] tengah,  n0_0, n0_1, n0_2, n1_0, n1_2, n2_0, n2_1, n2_2;
wire [7:0] max;
wire[7:0] onezero;
reg aclk, arst_n, aclr, aen;


matrix_max matmax(
.n0_0(n0_0), .n0_1(n0_1), .n0_2(n0_2), 
.n1_0(n1_0),.tengah(tengah), .n1_2(n1_2), 
.n2_0(n2_0), .n2_1(n2_1), .n2_2(n2_2), .clk(aclk), .rst_n(arst_n), .en(aen), .clr(aclr), .out_max(max), .onezero(onezero));
always
begin
aclk=0;
#(T/2);
aclk=1;
#(T/2);
end

initial 
begin
arst_n = 1;
aen = 1;
aclr = 1;

#T; 
n0_0=8'd0; n0_1=8'd0 ;n0_2=8'd0; 
n1_0=8'd2; tengah=8'd1; n1_2=8'd0; 
n2_0=8'd0; n2_1=8'd0; n2_2=8'd0;
/*
n0_0=8'd0; n0_1=8'd0 ;n0_2=8'd1; 
n1_0=8'd1; tengah=8'd0; n1_2=8'd2; 
n2_0=8'd0; n2_1=8'd0; n2_2=8'd2;
*/
/*
n0_0=8'd1; n0_1=8'd2 ;n0_2=8'd3; 
n1_0=8'd2; tengah=8'd9; n1_2=8'd3; 
n2_0=8'd2; n2_1=8'd3; n2_2=8'd4;
*/
#T;
 arst_n = 1;
 aclr=0;
 aen = 1;
 #T;
 #T;
 #T;
 /*
n0_0=0; n0_1=0 ;n0_2=0; 
n1_0=2;tengah=1; n1_2=0; 
n2_0=0; n2_1=0;n2_2=0;
#T;
n0_0=0; n0_1=0 ;n0_2=0; 
n1_0=2;tengah=0; n1_2=1; 
n2_0=0; n2_1=0;n2_2=0;
#T;
n0_0=0; n0_1=2 ;n0_2=3; 
n1_0=1;tengah=5; n1_2=4; 
n2_0=0; n2_1=3;n2_2=2;



*/
end


endmodule
