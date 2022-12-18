`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 18:03:55
// Design Name: 
// Module Name: matrix_to_matrix_tb
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


module matrix_to_matrix_tb();
localparam T=10;
reg [7:0] m11, m12, m13, m14, m15, m16,
m21, m22, m23, m24, m25, m26,
m31, m32, m33, m34, m35, m36,
m41, m42, m43, m44, m45, m46,
m51, m52, m53, m54, m55, m56,
m61, m62, m63, m64, m65, m66;
wire [7:0] y11, y12, y13, y14, y15, y16,
y21, y22, y23, y24, y25, y26,
y31, y32, y33, y34, y35, y36,
y41, y42, y43, y44, y45, y46,
y51, y52, y53, y54, y55, y56,
y61, y62, y63, y64, y65, y66;

reg clk, rst_n, en, clr;

matrix_to_matrix m_to_m(
.clk(clk), .rst_n(rst_n), .en(en), .clr(clr),
.m11(m11), .m12(m12), .m13(m13), .m14(m14), .m15(m15), .m16(m16),
.m21(m21), .m22(m22), .m23(m23), .m24(m24), .m25(m25), .m26(m26),
.m31(m31), .m32(m32), .m33(m33), .m34(m34), .m35(m35), .m36(m36),
.m41(m41), .m42(m42), .m43(m43), .m44(m44), .m45(m45), .m46(m46),
.m51(m51), .m52(m52), .m53(m53), .m54(m54), .m55(m55), .m56(m56),
.m61(m61), .m62(m62), .m63(m63), .m64(m64), .m65(m65), .m66(m66),
.y11(y11), .y12(y12), .y13(y13), .y14(y14), .y15(y15), .y16(y16),
.y21(y21), .y22(y22), .y23(y23), .y24(y24), .y25(y25), .y26(y26),
.y31(y31), .y32(y32), .y33(y33), .y34(y34), .y35(y35), .y36(y36),
.y41(y41), .y42(y42), .y43(y43), .y44(y44), .y45(y45), .y46(y46),
.y51(y51), .y52(y52), .y53(y53), .y54(y54), .y55(y55), .y56(y56),
.y61(y61), .y62(y62), .y63(y63), .y64(y64), .y65(y65), .y66(y66)
    );
    
always
begin
clk=0;
#(T/2);
clk=1;
#(T/2);
end

initial 
begin
rst_n = 1;
en = 1;
clr = 1;
#T;
m11=8'd0; m12=8'd0; m13=8'd0; m14=8'd1; m15=8'd2; m16=8'd3;
m21=8'd0; m22=8'd1; m23=8'd0; m24=8'd2; m25=8'd3; m26=8'd3;
m31=8'd0; m32=8'd0; m33=8'd0; m34=8'd2; m35=8'd3; m36=8'd4;
m41=8'd1; m42=8'd3; m43=8'd1; m44=8'd5; m45=8'd4; m46=8'd5;
m51=8'd0; m52=8'd0; m53=8'd0; m54=8'd3; m55=8'd2; m56=8'd4;
m61=8'd2; m62=8'd1; m63=8'd0; m64=8'd1; m65=8'd2; m66=8'd3;

#T;
 rst_n = 1;
 clr=0;
 en = 1;
 #T;
end
    
    
    
    
endmodule