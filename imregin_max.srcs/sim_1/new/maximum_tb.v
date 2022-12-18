`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2022 18:24:35
// Design Name: 
// Module Name: maximum_tb
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


module maximum_tb;
reg [8:0] a, b;
wire out;
localparam period = 20;

maximum max(.a(a), .b(b), .out(out));

inital
begin 
a = 2;
b = 3;
#period 

a = 2;
b = 1; 
#period
a = 2;
b = 1; 
#period

end 
endmodule
