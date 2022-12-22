`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2021 11:44:46 AM
// Design Name: 
// Module Name: axi_wrapper_tb
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

module axi_wrapper_tb();
    
    localparam T = 10;

    reg aclk;
    reg aresetn;
    wire s_axi_arready;
    reg [31:0] s_axi_araddr;
    reg s_axi_arvalid; 
    wire s_axi_awready;
    reg [31:0] s_axi_awaddr;
    reg s_axi_awvalid;  
    reg s_axi_bready;
    wire [1:0] s_axi_bresp;
    wire s_axi_bvalid;
    reg s_axi_rready;
    wire [31:0] s_axi_rdata;
    wire [1:0] s_axi_rresp;
    wire s_axi_rvalid;
    wire s_axi_wready;
    reg [31:0] s_axi_wdata;
    reg [3:0] s_axi_wstrb;
    reg s_axi_wvalid;

    axi_wrapper dut
    (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid)
    );

    always
    begin
        aclk = 0;
        #(T/2);
        aclk = 1;
        #(T/2);
    end

    initial
    begin
        s_axi_awaddr = 0;
        s_axi_awvalid = 0;
        s_axi_wstrb = 0;
        s_axi_wdata = 0;
        s_axi_wvalid = 0;
        s_axi_bready = 1;
        s_axi_araddr = 0;
        s_axi_arvalid = 0;
        s_axi_rready = 1;

        aresetn = 0;
        #(T*50);
        aresetn = 1;
        #(T*50);
    
        // Write input
        
        /* row 1*/
        axi_write(10'h24, 32'd0);
        axi_write(10'h28, 32'd0);
        axi_write(10'h2c, 32'd0);
        axi_write(10'h30, 32'd1);
        axi_write(10'h34, 32'd2);
        axi_write(10'h38, 32'd3);
        
        /* row 2*/
        axi_write(10'h3c, 32'd0);
        axi_write(10'h40, 32'd1);
        axi_write(10'h44, 32'd0);
        axi_write(10'h48, 32'd2);
        axi_write(10'h4c, 32'd3);
        axi_write(10'h50, 32'd3);
        
        /* row 3*/
        axi_write(10'h54, 32'd0);
        axi_write(10'h58, 32'd0);
        axi_write(10'h5c, 32'd0);
        axi_write(10'h60, 32'd2);
        axi_write(10'h64, 32'd3);
        axi_write(10'h68, 32'd4);
        
        /* row 4*/
        axi_write(10'h6c, 32'd1);
        axi_write(10'h70, 32'd3);
        axi_write(10'h74, 32'd1);
        axi_write(10'h78, 32'd5);
        axi_write(10'h7c, 32'd4);
        axi_write(10'h80, 32'd5);
        
        /* row 5*/
        axi_write(10'h84, 32'd0);
        axi_write(10'h88, 32'd0);
        axi_write(10'h8c, 32'd0);
        axi_write(10'h90, 32'd3);
        axi_write(10'h94, 32'd2);
        axi_write(10'h98, 32'd4);
        
        /* row 6*/
        axi_write(10'h9c, 32'd2);
        axi_write(10'ha0, 32'd1);
        axi_write(10'ha4, 32'd0);
        axi_write(10'ha8, 32'd1);
        axi_write(10'hac, 32'd2);
        axi_write(10'hb0, 32'd3);
        
        // Start
        axi_write(10'h00, 32'd1);
        axi_write(10'h0c, 32'd4212);
      
        
        // Read ready flag
        #(T*10);
        axi_read(32'h04);
        
        // Read output
        //row 1
        axi_read(32'hb4);
        axi_read(32'hb8);
        axi_read(32'hbc);
        axi_read(32'hc0);
        axi_read(32'hc4);
        axi_read(32'hc8);
        //row2
        axi_read(32'hcc);
        axi_read(32'hd0);
        axi_read(32'hd4);
        axi_read(32'hd8);
        axi_read(32'hdc);
        axi_read(32'he0);
        //row3
        axi_read(32'he4);
        axi_read(32'he8);
        axi_read(32'hec);
        axi_read(32'hf0);
        axi_read(32'hf4);
        axi_read(32'hf8);
        //row4
        axi_read(32'hfc);
        axi_read(32'h100);
        axi_read(32'h104);
        axi_read(32'h108);
        axi_read(32'h10c);
        axi_read(32'h110);
        //row5
        axi_read(32'h114);
        axi_read(32'h118);
        axi_read(32'h11c);
        axi_read(32'h120);
        axi_read(32'h124);
        axi_read(32'h128);
        
        //row6
        axi_read(32'h12c);
        axi_read(32'h130);
        axi_read(32'h134);
        axi_read(32'h138);
        axi_read(32'h13c);
        axi_read(32'h140);
        
        
        
        axi_read(32'h108);
        axi_read(32'h12c);
        
    end

    task axi_write;
        input [31:0] awaddr;
        input [31:0] wdata; 
        begin
            // *** Write address ***
            s_axi_awaddr = awaddr;
            s_axi_awvalid = 1;
            #T;
            s_axi_awvalid = 0;
            // *** Write data ***
            s_axi_wdata = wdata;
            s_axi_wstrb = 4'hf;
            s_axi_wvalid = 1; 
            #T;
            s_axi_wvalid = 0;
            #T;
        end
    endtask
    
    task axi_read;
        input [31:0] araddr;
        begin
            // *** Read address ***
            s_axi_araddr = araddr;
            s_axi_arvalid = 1;
            #T;
            s_axi_arvalid = 0;
            #T;
        end
    endtask

endmodule
