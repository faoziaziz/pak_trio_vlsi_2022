`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 13:14:25
// Design Name: 
// Module Name: register
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


`timescale 1ns / 1ps

module register
    (
        input wire               clk,
        input wire               rst_n,
        input wire               en,
        input wire               clr,
        input wire signed [31:0] d,
        output reg signed [31:0] q
    );
    
    always @(posedge clk)
    begin
        if (!rst_n || clr)
            q <= 0;
        else if (en)
            q <= d;
    end
    
endmodule

