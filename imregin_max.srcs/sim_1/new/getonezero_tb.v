`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 11:44:16
// Design Name: 
// Module Name: getonezero_tb
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


module getonezero_tb();

localparam T=10;

reg [7:0] tengah,  n0_0, n0_1, n0_2, n1_0, n1_2, n2_0, n2_1, n2_2, max; 
wire[7:0] onezero;
reg aclk;
getonezero one_ze(.tengah(tengah), .n0_0(n0_0), .n0_1(n0_1), .n0_2(n0_2), 
.n1_0(n1_0), .n1_2(n1_2), .n2_0(n2_0), .n2_1(n2_1), .n2_2(n2_2), .max(max), .onezero(onezero) );
always
begin
aclk=0;
#(T/2);
aclk=1;
#(T/2);
end

initial 
begin
n0_0=1; n0_1=2 ;n0_2=3; 
n1_0=2; tengah=3; n1_2=3; 
n2_0=2; n2_1=3; n2_2=4; max=4;
#T;
n0_0=0; n0_1=0 ;n0_2=0; 
n1_0=2;tengah=1; n1_2=0; 
n2_0=0; n2_1=0;n2_2=0; max=1;
#T;
n0_0=0; n0_1=0 ;n0_2=0; 
n1_0=2;tengah=0; n1_2=1; 
n2_0=0; n2_1=0;n2_2=0; max=1;
#T;
n0_0=0; n0_1=2 ;n0_2=3; 
n1_0=1;tengah=5; n1_2=4; 
n2_0=0; n2_1=3;n2_2=2; max=4;
end



endmodule
