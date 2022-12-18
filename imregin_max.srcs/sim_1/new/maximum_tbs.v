`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2022 18:34:10
// Design Name: 
// Module Name: maximum_tbs
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


module maximum_tbs();
localparam T = 10;
reg [7:0] a=8'd2, b=8'd3,c=8'd2, d=8'd2,e=8'd2, f=8'd2, g=8'd2, h=8'd2, i=8'd2;
wire [7:0] out; 
reg aclk;
maximum dut(.a(a), .b(b), .out(out));

always 
begin 
aclk = 0;
#(T/2);
aclk=1;
#(T/2);
end

initial 
begin

a = 8'd2;
b = 8'd3;
#T;
a = 8'd3;
b = 8'd2;
#T ;
a = 8'd4;
b = 8'd5;

end

endmodule
