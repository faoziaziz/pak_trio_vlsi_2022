// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Dec 22 13:52:39 2022
// Host        : DESKTOP-OP8FFJB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/repo/kuliah/vlsi/imregin_max/imregin_max.gen/sources_1/bd/design_1/ip/design_1_axi_wrapper_0_1/design_1_axi_wrapper_0_1_stub.v
// Design      : design_1_axi_wrapper_0_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axi_wrapper,Vivado 2022.2" *)
module design_1_axi_wrapper_0_1(aclk, aresetn, s_axi_awready, s_axi_awaddr, 
  s_axi_awvalid, s_axi_wready, s_axi_wdata, s_axi_wstrb, s_axi_wvalid, s_axi_bready, 
  s_axi_bresp, s_axi_bvalid, s_axi_arready, s_axi_araddr, s_axi_arvalid, s_axi_rready, 
  s_axi_rdata, s_axi_rresp, s_axi_rvalid)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,s_axi_awready,s_axi_awaddr[31:0],s_axi_awvalid,s_axi_wready,s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wvalid,s_axi_bready,s_axi_bresp[1:0],s_axi_bvalid,s_axi_arready,s_axi_araddr[31:0],s_axi_arvalid,s_axi_rready,s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rvalid" */;
  input aclk;
  input aresetn;
  output s_axi_awready;
  input [31:0]s_axi_awaddr;
  input s_axi_awvalid;
  output s_axi_wready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  input s_axi_bready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  output s_axi_arready;
  input [31:0]s_axi_araddr;
  input s_axi_arvalid;
  input s_axi_rready;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
endmodule
