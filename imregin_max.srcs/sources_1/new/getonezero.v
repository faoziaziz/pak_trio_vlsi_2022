`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 11:29:17
// Design Name: 
// Module Name: getonezero
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


module getonezero(input [7:0] tengah, n0_0, n0_1, n0_2, n1_0, n1_2, n2_0, n2_1, n2_2, max, output reg[7:0] onezero);



always @* 
begin
    if (tengah<max)
      onezero = 0;
    else if(tengah==max)
    begin
    if((n0_0==0)||(n0_1==0)||( n0_2==0) ||( n1_0==0)||( n1_2==0)||( n2_0==0)||( n2_1==0)||( n2_2==0))
        onezero=0;
    end
    else
    begin
    onezero=1;
    end
      
  end

endmodule
