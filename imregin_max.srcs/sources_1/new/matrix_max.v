`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 10:25:50
// Design Name: 
// Module Name: matrix_max
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


module matrix_max(
input [7:0] tengah, n0_0, n0_1, n0_2, n1_0, n1_2, n2_0, n2_1, n2_2, 
input wire clk, rst_n, en, clr,
output wire[7:0] out_max, onezero );

wire [7:0] max1_out, max2_out, max3_out, max4_out, max5_out, max6_out, max7_out, max8_out, onezero_out;
wire [7:0] max1_in, max2_in, max3_in,max4_in, max5_in, max6_in, max7_in, max8_in, onezero_in;
// get maximum stage 1
maximum ma1(n0_0, n0_1, max1_out);
maximum ma2(n0_2, n1_0, max2_out);
maximum ma3(n1_2, n2_0, max3_out);
maximum ma4(n2_1, n2_2, max4_out);

//get maximum state 2
maximum ma5(max1_in, max2_in, max5_out);
maximum ma6(max3_in, max4_in, max6_out);

//get maximum state 3 
maximum ma7(max5_in, max6_in, max7_out);
getonezero one_ze(tengah, n0_0, n0_1, n0_2, 
n1_0, n1_2, n2_0, n2_1, n2_2, out_max, onezero );

register reg_max1(clk, rst_n, en, clr, max1_out, max1_in);
register reg_max2(clk, rst_n, en, clr, max2_out, max2_in);
register reg_max3(clk, rst_n, en, clr, max3_out, max3_in);
register reg_max4(clk, rst_n, en, clr, max4_out, max4_in);
register reg_max5(clk, rst_n, en, clr, max5_out, max5_in);
register reg_max6(clk, rst_n, en, clr, max6_out, max6_in);
register reg_max7(clk, rst_n, en, clr, max7_out, out_max);
register reg_oz(clk, rst_n, en, clr, onezero_out, onezero);

/* set output wire 1 or zero */







endmodule
