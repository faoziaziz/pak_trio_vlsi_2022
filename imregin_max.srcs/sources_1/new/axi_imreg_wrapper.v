`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2022 20:54:18
// Design Name: 
// Module Name: axi_imreg_wrapper
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


module axi_imreg_wrapper(

        // *** AXI4 clock and reset port ***
        input  wire        aclk,
        input  wire        aresetn,
        // *** AXI4-lite slave port ***
        output wire        s_axi_awready,
        input  wire [31:0] s_axi_awaddr,
        input  wire        s_axi_awvalid,
        output wire        s_axi_wready,
        input  wire [3:0]  s_axi_wstrb,
        input  wire [31:0] s_axi_wdata,
        input  wire        s_axi_wvalid,
        input  wire        s_axi_bready,
        output wire [1:0]  s_axi_bresp,
        output wire        s_axi_bvalid,
        output wire        s_axi_arready,
        input  wire [31:0] s_axi_araddr,
        input  wire        s_axi_arvalid,
        input  wire        s_axi_rready,
        output wire [31:0] s_axi_rdata,     
        output wire [1:0]  s_axi_rresp,
        output wire        s_axi_rvalid
    );
    
    
    // *** Register map ***
    // 0x000: busy
    //        bit 0 = busy_reg (R)
    // 0x004: reserved
    // 0x008: reserved
    // 0x00C: reserved
    // 0x010: weight register 0
    //        bit 15~0 = w000[15:0] (R/W)
    // -----: -----
    // 0x20C: weight register 127
    //        bit 15~0 = w127[15:0] (R/W)
    // 0x210: i/o register 0
    //        bit 15~0 = io00[15:0] (R/W)
    // -----: -----
    // 0x30C: i/o register 63
    //        bit 15~0 = io63[15:0] (R/W)  
    localparam C_ADDR_BITS = 10;
    // *** Memory-mapped Address ***
    localparam C_ADDR_CTRL0 = 10'h000,
               // *** Weight ***
               C_ADDR_W000 = 10'h010, C_ADDR_W001 = 10'h014, C_ADDR_W002 = 10'h018, C_ADDR_W003 = 10'h01c,
               C_ADDR_W004 = 10'h020, C_ADDR_W005 = 10'h024, C_ADDR_W006 = 10'h028, C_ADDR_W007 = 10'h02c,
               C_ADDR_W008 = 10'h030, C_ADDR_W009 = 10'h034, C_ADDR_W010 = 10'h038, C_ADDR_W011 = 10'h03c,
               C_ADDR_W012 = 10'h040, C_ADDR_W013 = 10'h044, C_ADDR_W014 = 10'h048, C_ADDR_W015 = 10'h04c,
               C_ADDR_W016 = 10'h050, C_ADDR_W017 = 10'h054, C_ADDR_W018 = 10'h058, C_ADDR_W019 = 10'h05c,
               C_ADDR_W020 = 10'h060, C_ADDR_W021 = 10'h064, C_ADDR_W022 = 10'h068, C_ADDR_W023 = 10'h06c,
               C_ADDR_W024 = 10'h070, C_ADDR_W025 = 10'h074, C_ADDR_W026 = 10'h078, C_ADDR_W027 = 10'h07c,
               C_ADDR_W028 = 10'h080, C_ADDR_W029 = 10'h084, C_ADDR_W030 = 10'h088, C_ADDR_W031 = 10'h08c,
               C_ADDR_W032 = 10'h090, C_ADDR_W033 = 10'h094, C_ADDR_W034 = 10'h098, C_ADDR_W035 = 10'h09c,
               C_ADDR_W036 = 10'h0a0, C_ADDR_W037 = 10'h0a4, C_ADDR_W038 = 10'h0a8, C_ADDR_W039 = 10'h0ac,
               C_ADDR_W040 = 10'h0b0, C_ADDR_W041 = 10'h0b4, C_ADDR_W042 = 10'h0b8, C_ADDR_W043 = 10'h0bc,
               C_ADDR_W044 = 10'h0c0, C_ADDR_W045 = 10'h0c4, C_ADDR_W046 = 10'h0c8, C_ADDR_W047 = 10'h0cc,          
               C_ADDR_W048 = 10'h0d0, C_ADDR_W049 = 10'h0d4, C_ADDR_W050 = 10'h0d8, C_ADDR_W051 = 10'h0dc,
               C_ADDR_W052 = 10'h0e0, C_ADDR_W053 = 10'h0e4, C_ADDR_W054 = 10'h0e8, C_ADDR_W055 = 10'h0ec,
               C_ADDR_W056 = 10'h0f0, C_ADDR_W057 = 10'h0f4, C_ADDR_W058 = 10'h0f8, C_ADDR_W059 = 10'h0fc,
               C_ADDR_W060 = 10'h100, C_ADDR_W061 = 10'h104, C_ADDR_W062 = 10'h108, C_ADDR_W063 = 10'h10c,
               C_ADDR_W064 = 10'h110, C_ADDR_W065 = 10'h114, C_ADDR_W066 = 10'h118, C_ADDR_W067 = 10'h11c,
               C_ADDR_W068 = 10'h120, C_ADDR_W069 = 10'h124, C_ADDR_W070 = 10'h128, C_ADDR_W071 = 10'h12c,
               C_ADDR_W072 = 10'h130, C_ADDR_W073 = 10'h134, C_ADDR_W074 = 10'h138, C_ADDR_W075 = 10'h13c,
               C_ADDR_W076 = 10'h140, C_ADDR_W077 = 10'h144, C_ADDR_W078 = 10'h148, C_ADDR_W079 = 10'h14c,
               C_ADDR_W080 = 10'h150, C_ADDR_W081 = 10'h154, C_ADDR_W082 = 10'h158, C_ADDR_W083 = 10'h15c,
               C_ADDR_W084 = 10'h160, C_ADDR_W085 = 10'h164, C_ADDR_W086 = 10'h168, C_ADDR_W087 = 10'h16c,
               C_ADDR_W088 = 10'h170, C_ADDR_W089 = 10'h174, C_ADDR_W090 = 10'h178, C_ADDR_W091 = 10'h17c,
               C_ADDR_W092 = 10'h180, C_ADDR_W093 = 10'h184, C_ADDR_W094 = 10'h188, C_ADDR_W095 = 10'h18c,
               C_ADDR_W096 = 10'h190, C_ADDR_W097 = 10'h194, C_ADDR_W098 = 10'h198, C_ADDR_W099 = 10'h19c,
               C_ADDR_W100 = 10'h1a0, C_ADDR_W101 = 10'h1a4, C_ADDR_W102 = 10'h1a8, C_ADDR_W103 = 10'h1ac,
               C_ADDR_W104 = 10'h1b0, C_ADDR_W105 = 10'h1b4, C_ADDR_W106 = 10'h1b8, C_ADDR_W107 = 10'h1bc,
               C_ADDR_W108 = 10'h1c0, C_ADDR_W109 = 10'h1c4, C_ADDR_W110 = 10'h1c8, C_ADDR_W111 = 10'h1cc,
               C_ADDR_W112 = 10'h1d0, C_ADDR_W113 = 10'h1d4, C_ADDR_W114 = 10'h1d8, C_ADDR_W115 = 10'h1dc,
               C_ADDR_W116 = 10'h1e0, C_ADDR_W117 = 10'h1e4, C_ADDR_W118 = 10'h1e8, C_ADDR_W119 = 10'h1ec,
               C_ADDR_W120 = 10'h1f0, C_ADDR_W121 = 10'h1f4, C_ADDR_W122 = 10'h1f8, C_ADDR_W123 = 10'h1fc,
               C_ADDR_W124 = 10'h200, C_ADDR_W125 = 10'h204, C_ADDR_W126 = 10'h208, C_ADDR_W127 = 10'h20c,
               // *** I/O ***
               C_ADDR_IO00 = 10'h210, C_ADDR_IO01 = 10'h214, C_ADDR_IO02 = 10'h218, C_ADDR_IO03 = 10'h21c,
               C_ADDR_IO04 = 10'h220, C_ADDR_IO05 = 10'h224, C_ADDR_IO06 = 10'h228, C_ADDR_IO07 = 10'h22c,
               C_ADDR_IO08 = 10'h230, C_ADDR_IO09 = 10'h234, C_ADDR_IO10 = 10'h238, C_ADDR_IO11 = 10'h23c,
               C_ADDR_IO12 = 10'h240, C_ADDR_IO13 = 10'h244, C_ADDR_IO14 = 10'h248, C_ADDR_IO15 = 10'h24c,
               C_ADDR_IO16 = 10'h250, C_ADDR_IO17 = 10'h254, C_ADDR_IO18 = 10'h258, C_ADDR_IO19 = 10'h25c,
               C_ADDR_IO20 = 10'h260, C_ADDR_IO21 = 10'h264, C_ADDR_IO22 = 10'h268, C_ADDR_IO23 = 10'h26c,
               C_ADDR_IO24 = 10'h270, C_ADDR_IO25 = 10'h274, C_ADDR_IO26 = 10'h278, C_ADDR_IO27 = 10'h27c,
               C_ADDR_IO28 = 10'h280, C_ADDR_IO29 = 10'h284, C_ADDR_IO30 = 10'h288, C_ADDR_IO31 = 10'h28c,
               C_ADDR_IO32 = 10'h290, C_ADDR_IO33 = 10'h294, C_ADDR_IO34 = 10'h298, C_ADDR_IO35 = 10'h29c,
               C_ADDR_IO36 = 10'h2a0, C_ADDR_IO37 = 10'h2a4, C_ADDR_IO38 = 10'h2a8, C_ADDR_IO39 = 10'h2ac,
               C_ADDR_IO40 = 10'h2b0, C_ADDR_IO41 = 10'h2b4, C_ADDR_IO42 = 10'h2b8, C_ADDR_IO43 = 10'h2bc,
               C_ADDR_IO44 = 10'h2c0, C_ADDR_IO45 = 10'h2c4, C_ADDR_IO46 = 10'h2c8, C_ADDR_IO47 = 10'h2cc;
    
      loop_matrix lm0(
        .clk(aclk), .rst_n(aresetn), .en(aen), .clr(aclr),
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
        .y61(y61), .y62(y62), .y63(y63), .y64(y64), .y65(y65), .y66(y66), .done(done)
    );
endmodule
