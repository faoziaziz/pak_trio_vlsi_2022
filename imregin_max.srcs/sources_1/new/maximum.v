`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2022 18:21:41
// Design Name: 
// Module Name: maximum
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


module maximum (input wire[7:0] a, 
            input wire[7:0] b, 
            output reg [7:0] out);
            
  always @* begin
    if (a>=b)
      out = a;
    else
      out = b;
  end
endmodule
