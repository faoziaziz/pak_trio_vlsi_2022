`timescale 1ns / 1ps

module axi_wrapper
	(
	    // ### Clock and reset signals #########################################
		input  wire        aclk,
		input  wire        aresetn,
		// ### AXI4-lite slave signals #########################################
		// *** Write address signals ***
        output wire        s_axi_awready,
		input  wire [31:0] s_axi_awaddr,
		input  wire        s_axi_awvalid,
		// *** Write data signals ***
        output wire        s_axi_wready,
		input  wire [31:0] s_axi_wdata,
		input  wire [3:0]  s_axi_wstrb,
		input  wire        s_axi_wvalid,
		// *** Write response signals ***
        input  wire        s_axi_bready,
		output wire [1:0]  s_axi_bresp,
		output wire        s_axi_bvalid,
		// *** Read address signals ***
        output wire        s_axi_arready,
		input  wire [31:0] s_axi_araddr,
		input  wire        s_axi_arvalid,
		// *** Read data signals ***	
        input  wire        s_axi_rready,
		output wire [31:0] s_axi_rdata,
		output wire [1:0]  s_axi_rresp,
		output wire        s_axi_rvalid
		// ### User signals ####################################################
	);

    // ### Register map ########################################################
	localparam C_ADDR_BITS = 10, ALWS_EN=1'b1;
	// *** Address ***
	localparam C_ADDR_START = 10'h00,
			   C_ADDR_READY = 10'h04,
			   C_ADDR_X1 = 10'h08,
			   C_ADDR_X2 = 10'h0c,
			   C_ADDR_X3 = 10'h10,
			   C_ADDR_W1 = 10'h14,
			   C_ADDR_W2 = 10'h18,
			   C_ADDR_W3 = 10'h1c,
			   C_ADDR_Y = 10'h20,
			   
			   //address untuk imreg input 
			   C_ADDR_M11=10'h24, C_ADDR_M12=10'h28, C_ADDR_M13=10'h2c, C_ADDR_M14=10'h30, C_ADDR_M15=10'h34, C_ADDR_M16=10'h38,
			   C_ADDR_M21=10'h3c, C_ADDR_M22=10'h40, C_ADDR_M23=10'h44, C_ADDR_M24=10'h48, C_ADDR_M25=10'h4c, C_ADDR_M26=10'h50,
			   C_ADDR_M31=10'h54, C_ADDR_M32=10'h58, C_ADDR_M33=10'h5c, C_ADDR_M34=10'h60, C_ADDR_M35=10'h64, C_ADDR_M36=10'h68,
			   C_ADDR_M41=10'h6c, C_ADDR_M42=10'h70, C_ADDR_M43=10'h74, C_ADDR_M44=10'h78, C_ADDR_M45=10'h7c, C_ADDR_M46=10'h80,
			   C_ADDR_M51=10'h84, C_ADDR_M52=10'h88, C_ADDR_M53=10'h8c, C_ADDR_M54=10'h90, C_ADDR_M55=10'h94, C_ADDR_M56=10'h98,
			   C_ADDR_M61=10'h9c, C_ADDR_M62=10'ha0, C_ADDR_M63=10'ha4, C_ADDR_M64=10'ha8, C_ADDR_M65=10'hac, C_ADDR_M66=10'hb0,
			   
			   //address imreg read ouput
			   C_ADDR_R11=10'hb4, C_ADDR_R12=10'hb8, C_ADDR_R13=10'hbc, C_ADDR_R14=10'hc0, C_ADDR_R15=10'hc4, C_ADDR_R16=10'hc8,
			   C_ADDR_R21=10'hcc, C_ADDR_R22=10'hd0, C_ADDR_R23=10'hd4, C_ADDR_R24=10'hd8, C_ADDR_R25=10'hdc, C_ADDR_R26=10'he0,
			   C_ADDR_R31=10'he4, C_ADDR_R32=10'he8, C_ADDR_R33=10'hec, C_ADDR_R34=10'hf0, C_ADDR_R35=10'hf4, C_ADDR_R36=10'hf8,
			   C_ADDR_R41=10'hfc, C_ADDR_R42=10'h100, C_ADDR_R43=10'h104, C_ADDR_R44=10'h108, C_ADDR_R45=10'h10c, C_ADDR_R46=10'h110,
			   C_ADDR_R51=10'h114, C_ADDR_R52=10'h118, C_ADDR_R53=10'h11c, C_ADDR_R54=10'h120, C_ADDR_R55=10'h124, C_ADDR_R56=10'h128,
			   C_ADDR_R61=10'h12c, C_ADDR_R62=10'h130, C_ADDR_R63=10'h134, C_ADDR_R64=10'h138, C_ADDR_R65=10'h13c, C_ADDR_R66=10'h140;
			   
	// *** AXI write FSM ***
	localparam S_WRIDLE = 2'd0,
			   S_WRDATA = 2'd1,
			   S_WRRESP = 2'd2;
	// *** AXI read FSM ***
	localparam S_RDIDLE = 2'd0,
			   S_RDDATA = 2'd1;
			   
    /* state machine identification */
    localparam S_STATE_1 = 7'h1, S_STATE_2 = 7'h2, S_STATE_3 = 7'h3, S_STATE_4 = 7'h4, S_STATE_5 = 7'h5, S_STATE_6 = 7'h6,
    S_STATE_7 = 7'h7, S_STATE_8 = 7'h8, S_STATE_9 = 7'h9, S_STATE_10 = 7'h10;
	reg [6:0] cs, ns;
	// *** AXI write ***
	reg [1:0] wstate_cs, wstate_ns;
	reg [C_ADDR_BITS-1:0] waddr;
	reg [31:0] check_var;
	wire [31:0] wmask;
	wire aw_hs, w_hs;
	// *** AXI read ***
	reg [1:0] rstate_cs, rstate_ns;
	wire [C_ADDR_BITS-1:0] raddr;
	reg [31:0] rdata;
	wire ar_hs;
	// *** Registers ***
	reg start;
	
	/* just for state management */
	//reg [8:0] cs, ns;
    reg [31:0] y_cv, y_nv;
    
    reg [31:0] x1_in;
    reg [31:0] x2_in;
    reg [31:0] x3_in;
    reg [31:0] w1_in;
    reg [31:0] w2_in;
    reg [31:0] w3_in;
    reg aclr, rst_n, done2;
    
    reg[1:0] done;
    
    reg [31:0] m11, m12, m13, m14, m15, m16,
        m21, m22, m23, m24, m25, m26,
        m31, m32, m33, m34, m35, m36,
        m41, m42, m43, m44, m45, m46,
        m51, m52, m53, m54, m55, m56,
        m61, m62, m63, m64, m65, m66;

    reg [31:0] y11, y12, y13, y14, y15, y16,
        y21, y22, y23, y24, y25, y26,
        y31, y32, y33, y34, y35, y36,
        y41, y42, y43, y44, y45, y46,
        y51, y52, y53, y54, y55, y56,
        y61, y62, y63, y64, y65, y66;
    reg [31:0] m21_out, m22_out;
    reg [31:0] done3;
    reg [31:0] m23_out;
    reg [31:0] m24_out;
    reg [31:0] state1, state2, state3, state4, state5, state6, state7, state8, state9, state10, state11;
    wire [31:0] m33_out;
    
    reg [31:0] y11_out_final, y44_out_final;
   
    wire ready_tmp;
    wire [31:0] y_tmp;
    
	// ### AXI write ###########################################################
	assign s_axi_awready = (wstate_cs == S_WRIDLE);
	assign s_axi_wready = (wstate_cs == S_WRDATA);
	
	assign s_axi_bresp = 2'b00;    // OKAY
	assign s_axi_bvalid = (wstate_cs == S_WRRESP);
	assign wmask = {{8{s_axi_wstrb[3]}}, {8{s_axi_wstrb[2]}}, {8{s_axi_wstrb[1]}}, {8{s_axi_wstrb[0]}}};
	assign aw_hs = s_axi_awvalid & s_axi_awready;
	assign w_hs = s_axi_wvalid & s_axi_wready;

	// *** Write state register ***
	always @(posedge aclk)
	begin
		if (!aresetn)
			wstate_cs <= S_WRIDLE;
		else
			wstate_cs <= wstate_ns;
	end
	
	// *** Write state next ***
	always @(*)
	begin
		case (wstate_cs)
			S_WRIDLE:
				if (s_axi_awvalid)
					wstate_ns = S_WRDATA;
				else
					wstate_ns = S_WRIDLE;
			S_WRDATA:
				if (s_axi_wvalid)
					wstate_ns = S_WRRESP;
				else
					wstate_ns = S_WRDATA;
			S_WRRESP:
				if (s_axi_bready)
					wstate_ns = S_WRIDLE;
				else
					wstate_ns = S_WRRESP;
			default:
				wstate_ns = S_WRIDLE;
		endcase
	end
	
	// *** Write address register ***
	always @(posedge aclk)
	begin
		if (aw_hs)
			waddr <= s_axi_awaddr[C_ADDR_BITS-1:0];
	end
	
	// ### AXI read ############################################################
	assign s_axi_arready = (rstate_cs == S_RDIDLE);
	assign s_axi_rdata = rdata;
	assign s_axi_rresp = 2'b00;    // OKAY
	assign s_axi_rvalid = (rstate_cs == S_RDDATA);
	assign ar_hs = s_axi_arvalid & s_axi_arready;
	assign raddr = s_axi_araddr[C_ADDR_BITS-1:0];
	/* declare variable for processing */
	/* set initial */
    wire [2:0] counter;
    reg [4:0] counter2;
    /* declare buffer input */
    reg [31:0] w11_in, w12_in, w13_in, w14_in, w15_in, w16_in,
    w21_in, w22_in, w23_in, w24_in, w25_in, w26_in,
    w31_in, w32_in, w33_in, w34_in, w35_in, w36_in,
    w41_in, w42_in, w43_in, w44_in, w45_in, w46_in,
    w51_in, w52_in, w53_in, w54_in, w55_in, w56_in,
    w61_in, w62_in, w63_in, w64_in, w65_in, w66_in;
    
    /* declare buffer output */
    wire [31:0] w11_out, w12_out, w13_out, w14_out, w15_out, w16_out,
    w21_out, w22_out, w23_out, w24_out, w25_out, w26_out,
    w31_out, w32_out, w33_out, w34_out, w35_out, w36_out,
    w41_out, w42_out, w43_out, w44_out, w45_out, w46_out,
    w51_out, w52_out, w53_out, w54_out, w55_out, w56_out,
    w61_out, w62_out, w63_out, w64_out, w65_out, w66_out;
    
    /* declare buffer output */
    reg [31:0] w11_out_last, w12_out_last, w13_out_last, w14_out_last, w15_out_last, w16_out_last,
    w21_out_last, w22_out_last, w23_out_last, w24_out_last, w25_out_last, w26_out_last,
    w31_out_last, w32_out_last, w33_out_last, w34_out_last, w35_out_last, w36_out_last,
    w41_out_last, w42_out_last, w43_out_last, w44_out_last, w45_out_last, w46_out_last,
    w51_out_last, w52_out_last, w53_out_last, w54_out_last, w55_out_last, w56_out_last,
    w61_out_last, w62_out_last, w63_out_last, w64_out_last, w65_out_last, w66_out_last;
	// *** Read state register ***
	always @(posedge aclk)
	begin
		if (!aresetn)
			rstate_cs <= S_RDIDLE;
		else
			rstate_cs <= rstate_ns;
	end

	// *** Read state next ***
	always @(*) 
	begin
		case (rstate_cs)
			S_RDIDLE:
				if (s_axi_arvalid)
					rstate_ns = S_RDDATA;
				else
					rstate_ns = S_RDIDLE;
			S_RDDATA:
				if (s_axi_rready)
					rstate_ns = S_RDIDLE;
				else
					rstate_ns = S_RDDATA;
			default:
				rstate_ns = S_RDIDLE;
		endcase
	end
	
	
	
	// *** Read data register ***
	always @(posedge aclk)
	begin
	    if (!aresetn)
	    begin
	        rdata <= 0;
	        aclr <=0;
	        
	        /* untuk memulai
	        rst_n = 1;
            clr=0;
            en = 1;*/
	        end
		else if (ar_hs)
			case (raddr)
			
			        /*
			         aen<=1;
			     aclr<=0;
			     rst_n<=1;  
			        */
				C_ADDR_START: 
					rdata <= {{31{1'b0}}, start};
				C_ADDR_READY:
				    rdata <= {{31{1'b0}}, done};
				C_ADDR_X1:
				    rdata <= 32'd4332;
				C_ADDR_X2:
				    rdata <= x2_in[31:0];
				C_ADDR_X3:
				    rdata <=  x3_in[31:0];
				C_ADDR_W1:
				    rdata <= aclr;
				C_ADDR_W2:
				    rdata <= rst_n;
				C_ADDR_W3:
				    rdata <= y44[31:0];
				C_ADDR_Y:
				    rdata <= y_tmp[31:0];
				//address untuk imreg input 
			   C_ADDR_M11:
			         rdata <= m11[31:0];
			   C_ADDR_M12:
			         rdata <= m12[31:0];
			   C_ADDR_M13:
			         rdata <= m13[31:0]; 
			   C_ADDR_M14:
			         rdata <= m14[31:0];
			   C_ADDR_M15:
			         rdata <= m15[31:0]; 
			   C_ADDR_M16:
			         rdata <= m16[31:0];
			   C_ADDR_M21:
			         rdata <= m21[31:0]; 
			   C_ADDR_M22:
			         rdata <= m22[31:0]; 
			   C_ADDR_M23:
			         rdata <= m23[31:0]; 
			   C_ADDR_M24:
			         rdata <= m24[31:0]; 
			   C_ADDR_M25:
			         rdata <= m25[31:0]; 
			   C_ADDR_M26:
			         rdata <= m26[31:0];
			   C_ADDR_M31:
			         rdata <= m31[31:0]; 
			   C_ADDR_M32:
			         rdata <= m32[31:0]; 
			   C_ADDR_M33:
			         rdata <= m33[31:0];
			   C_ADDR_M34:
			         rdata <= m34[31:0]; 
			   C_ADDR_M35:
			         rdata <= m35[31:0];
			   C_ADDR_M36:
			         rdata <= m36[31:0];
			   C_ADDR_M41:
			         rdata <= m41[31:0]; 
			   C_ADDR_M42:
			         rdata <= m42[31:0]; 
			   C_ADDR_M43:
			         rdata <= m43[31:0]; 
			   C_ADDR_M44:
			         rdata <= m44[31:0]; 
			   C_ADDR_M45:
			         rdata <= m45[31:0]; 
			   C_ADDR_M46:
			         rdata <= m46[31:0];
			   C_ADDR_M51:
			         rdata <= m51[31:0]; 
			   C_ADDR_M52:
			         rdata <= m52[31:0]; 
			   C_ADDR_M53:
			         rdata <= m53[31:0]; 
			   C_ADDR_M54:
			         rdata <= m54[31:0]; 
			   C_ADDR_M55:
			         rdata <= m55[31:0]; 
			   C_ADDR_M56:
			         rdata <= m56[31:0];
			   C_ADDR_M61:
			         rdata <= m61[31:0]; 
			   C_ADDR_M62:
			         rdata <= m62[31:0]; 
			   C_ADDR_M63:
			         rdata <= m63[31:0]; 
			   C_ADDR_M64:
			         rdata <= m64[31:0]; 
			   C_ADDR_M65:
			         rdata <= m65[31:0]; 
			   C_ADDR_M66:
			         rdata <= m66[31:0];
			   
			   //address imreg read ouput
			   
			   /*tow 1*/
			   C_ADDR_R11:
			         rdata <= y11;
			   C_ADDR_R12:
			         rdata <=y12; 
			   C_ADDR_R13:
			         rdata <= y13; 
			   C_ADDR_R14:
			         rdata <= y14[31:0]; 
			   C_ADDR_R15:
			         rdata <= y15; 
			   C_ADDR_R16:
			         rdata <= y16;
			   /*tow 2*/
			   C_ADDR_R21:
			         rdata <= y21;
			   C_ADDR_R22:
			         rdata <= y22; 
			   C_ADDR_R23:
			         rdata <= y23; 
			   C_ADDR_R24:
			         rdata <= y24; 
			   C_ADDR_R25:
			         rdata <= y25; 
			   C_ADDR_R26:
			         rdata <= y26;
			    /*tow 3*/
			   C_ADDR_R31:
			         rdata <= y31;
			   C_ADDR_R32:
			         rdata <= y32; 
			   C_ADDR_R33:
			         rdata <= y33; 
			   C_ADDR_R34:
			         rdata <= y34; 
			   C_ADDR_R35:
			         rdata <= y35; 
			   C_ADDR_R36:
			         rdata <= y36;
			   /*tow 4*/
			   C_ADDR_R41:
			         rdata <= y41;
			   C_ADDR_R42:
			         rdata <= y42; 
			   C_ADDR_R43:
			         rdata <= y43; 
			   C_ADDR_R44:
			         rdata <= y44; 
			   C_ADDR_R45:
			         rdata <= y45; 
			   C_ADDR_R46:
			         rdata <= y46;
			    /*tow 5*/
			   C_ADDR_R51:
			         rdata <= {{31{1'b0}}, y51[1:0]};
			   C_ADDR_R52:
			         rdata <= {{31{1'b0}}, y52[1:0]}; 
			   C_ADDR_R53:
			         rdata <= {{31{1'b0}}, y53[1:0]}; 
			   C_ADDR_R54:
			         rdata <= {{31{1'b0}}, y54[1:0]}; 
			   C_ADDR_R55:
			         rdata <= {{31{1'b0}}, y55[1:0]}; 
			   C_ADDR_R56:
			         rdata <= {{31{1'b0}}, y56[1:0]};
			   
			    /*tow 6*/
			   C_ADDR_R61:
			         rdata <= y61;
			   C_ADDR_R62:
			         rdata <= y62; 
			   C_ADDR_R63:
			         rdata <= y63;
			   C_ADDR_R64:
			         rdata <= y64;
			   C_ADDR_R65:
			         rdata <= y65;
			   C_ADDR_R66:
			         rdata <= y66;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
			endcase
	end
	
    // ### Registers ############################################################    
	always @(posedge aclk)
	begin
	    if (!aresetn)
	    begin
	    //aen<=1;
	        start <= 0;
            x1_in <= 0; 
            x2_in <= 0;
            x3_in <= 0;
            w1_in <= 0;
            w2_in <= 0;
            w3_in <= 0;
            
            /* clear initiate*/
            /*
            rst_n <= 0;
            aclr <=1;
            aen <= 1;*/
        end
		else if (w_hs && waddr == C_ADDR_START)
		begin
		
		/*
		rst_n = 0;
en = 1;
clr = 1;
		*/
		start <= 1;
		
		    /* start dimulai */
		    /*

			start <= 1;
			aen<=1;
			aclr<=0;
			rst_n<=1;
			*/  
	        //rst_n = 1;
            //clr=0;
            //en = 1;
			done<=0;
	    end
		else if (w_hs && waddr == C_ADDR_X1)
        begin
            x1_in[31:0] <= (s_axi_wdata[31:0] & wmask) | (x1_in[31:0] & ~wmask);
        end
		else if (w_hs && waddr == C_ADDR_X2)
        begin
            x2_in[31:0] <= (s_axi_wdata[31:0] & wmask) | (x2_in[31:0] & ~wmask);
        end
		else if (w_hs && waddr == C_ADDR_X3)
        begin
            x3_in[31:0] <= (s_axi_wdata[31:0] & wmask) | (x3_in[31:0] & ~wmask);
        end
		else if (w_hs && waddr == C_ADDR_W1)
        begin
            w1_in[31:0] <= (s_axi_wdata[31:0] & wmask) | (w1_in[31:0] & ~wmask);
        end
		else if (w_hs && waddr == C_ADDR_W2)
        begin
            w2_in[31:0] <= (s_axi_wdata[31:0] & wmask) | (w2_in[31:0] & ~wmask);
        end
		else if (w_hs && waddr == C_ADDR_W3)
        begin
            w3_in[31:0] <= (s_axi_wdata[31:0] & wmask) | (w3_in[31:0] & ~wmask);
        end
        /* row 1 */
        else if (w_hs && waddr == C_ADDR_M11)
        begin
            m11[31:0] <= (s_axi_wdata[31:0] & wmask) | (m11[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M12)
        begin
            m12[31:0] <= (s_axi_wdata[31:0] & wmask) | (m12[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M13)
        begin
            m13[31:0] <= (s_axi_wdata[31:0] & wmask) | (m13[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M14)
        begin
            m14[31:0] <= (s_axi_wdata[31:0] & wmask) | (m14[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M15)
        begin
            m15[31:0] <= (s_axi_wdata[31:0] & wmask) | (m15[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M16)
        begin
            m16[31:0] <= (s_axi_wdata[31:0] & wmask) | (m16[31:0] & ~wmask);
        end
        
        /* row 2 */
        else if (w_hs && waddr == C_ADDR_M21)
        begin
            m21[31:0] <= (s_axi_wdata[31:0] & wmask) | (m21[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M22)
        begin
            m22[31:0] <= (s_axi_wdata[31:0] & wmask) | (m22[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M23)
        begin
            m23[31:0] <= (s_axi_wdata[31:0] & wmask) | (m23[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M24)
        begin
            m24[31:0] <= (s_axi_wdata[31:0] & wmask) | (m24[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M25)
        begin
            m25[31:0] <= (s_axi_wdata[31:0] & wmask) | (m25[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M26)
        begin
            m26[31:0] <= (s_axi_wdata[31:0] & wmask) | (m26[31:0] & ~wmask);
        end
        
        /* row 3 */
        else if (w_hs && waddr == C_ADDR_M31)
        begin
            m31[31:0] <= (s_axi_wdata[31:0] & wmask) | (m31[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M32)
        begin
            m32[31:0] <= (s_axi_wdata[31:0] & wmask) | (m32[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M33)
        begin
            m33[31:0] <= (s_axi_wdata[31:0] & wmask) | (m33[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M34)
        begin
            m34[31:0] <= (s_axi_wdata[31:0] & wmask) | (m34[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M35)
        begin
            m35[31:0] <= (s_axi_wdata[31:0] & wmask) | (m35[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M36)
        begin
            m36[31:0] <= (s_axi_wdata[31:0] & wmask) | (m36[31:0] & ~wmask);
        end
        
        /* row 4 */
        else if (w_hs && waddr == C_ADDR_M41)
        begin
            m41[31:0] <= (s_axi_wdata[31:0] & wmask) | (m41[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M42)
        begin
            m42[31:0] <= (s_axi_wdata[31:0] & wmask) | (m42[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M43)
        begin
            m43[31:0] <= (s_axi_wdata[31:0] & wmask) | (m43[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M44)
        begin
            m44[31:0] <= (s_axi_wdata[31:0] & wmask) | (m44[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M45)
        begin
            m45[31:0] <= (s_axi_wdata[31:0] & wmask) | (m45[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M46)
        begin
            m46[31:0] <= (s_axi_wdata[31:0] & wmask) | (m46[31:0] & ~wmask);
        end
        /* row 5 */
        else if (w_hs && waddr == C_ADDR_M51)
        begin
            m51[31:0] <= (s_axi_wdata[31:0] & wmask) | (m51[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M52)
        begin
            m52[31:0] <= (s_axi_wdata[31:0] & wmask) | (m52[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M53)
        begin
            m53[31:0] <= (s_axi_wdata[31:0] & wmask) | (m53[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M54)
        begin
            m54[31:0] <= (s_axi_wdata[31:0] & wmask) | (m54[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M55)
        begin
            m55[31:0] <= (s_axi_wdata[31:0] & wmask) | (m55[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M56)
        begin
            m56[31:0] <= (s_axi_wdata[31:0] & wmask) | (m56[31:0] & ~wmask);
        end
        /* row 6 */
        else if (w_hs && waddr == C_ADDR_M61)
        begin
            m61[31:0] <= (s_axi_wdata[31:0] & wmask) | (m61[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M62)
        begin
            m62[31:0] <= (s_axi_wdata[31:0] & wmask) | (m62[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M63)
        begin
            m63[31:0] <= (s_axi_wdata[31:0] & wmask) | (m63[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M64)
        begin
            m64[31:0] <= (s_axi_wdata[31:0] & wmask) | (m64[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M65)
        begin
            m65[31:0] <= (s_axi_wdata[31:0] & wmask) | (m65[31:0] & ~wmask);
        end
        else if (w_hs && waddr == C_ADDR_M66)
        begin
            m66[31:0] <= (s_axi_wdata[31:0] & wmask) | (m66[31:0] & ~wmask);
        end
        else
        begin
            start <= 0;
            //aen<=1;
        end

            
          
            
	end
	
	
	/*
	single_neuron_core single_neuron_core_0
    (
        .clk(aclk),
        .rst_n(aresetn),
        .start(start),
        .ready(ready_tmp),
        .x1_in(x1_in[7:0]),
        .x2_in(x2_in[7:0]),
        .x3_in(x3_in[7:0]),
        .w1_in(w1_in[7:0]),
        .w2_in(w2_in[7:0]),
        .w3_in(w3_in[7:0]),
        .y(y_tmp)
    );*/
    /* set from initial input */
    
    /* process*/
     matrix_to_matrix process_matrix_0(
        .clk(aclk), .rst_n(rst_n), .en(ALWS_EN), .clr(aclr),
        .m11(w11_in), .m12(w12_in), .m13(w13_in), .m14(w14_in), .m15(w15_in), .m16(w16_in),
        .m21(w21_in), .m22(w22_in), .m23(w23_in), .m24(w24_in), .m25(w25_in), .m26(w26_in),
        .m31(w31_in), .m32(w32_in), .m33(w33_in), .m34(w34_in), .m35(w35_in), .m36(w36_in),
        .m41(w41_in), .m42(w42_in), .m43(w43_in), .m44(w44_in), .m45(w45_in), .m46(w46_in),
        .m51(w51_in), .m52(w52_in), .m53(w53_in), .m54(w54_in), .m55(w55_in), .m56(w56_in),
        .m61(w61_in), .m62(w62_in), .m63(w63_in), .m64(w64_in), .m65(w65_in), .m66(w66_in), 
        .y11(w11_out), .y12(w12_out), .y13(w13_out), .y14(w14_out), .y15(w15_out), .y16(w16_out),
        .y21(w21_out), .y22(w22_out), .y23(w23_out), .y24(w24_out), .y25(w25_out), .y26(w26_out),
        .y31(w31_out), .y32(w32_out), .y33(w33_out), .y34(w34_out), .y35(w35_out), .y36(w36_out),
        .y41(w41_out), .y42(w42_out), .y43(w43_out), .y44(w44_out), .y45(w45_out), .y46(w46_out),
        .y51(w51_out), .y52(w52_out), .y53(w53_out), .y54(w54_out), .y55(w55_out), .y56(w56_out),
        .y61(w61_out), .y62(w62_out), .y63(w63_out), .y64(w64_out), .y65(w65_out), .y66(w66_out), .counter(counter)
    );
    
    
    /* just for state management*/
    always @(posedge aclk)
    begin
        if (!aresetn)
        begin
            cs = 7'd0;
            
                    //aen <= 1;
                    
                  
            //y_cv <= 0;
            done=0;
            
        end
        else
        begin
            //m33_out<=32'd65;
          //  m21_out<=32'd21;
            cs = ns;
         //   y_cv <= y_nv;
        end
    end
    
    /* case state */
    always @(*)
    begin
        ns = cs;
        //y_nv = y_cv;
        case (cs)
            7'd0:
            begin
                
                      aclr=1;
			         rst_n=0;  

                    /* zerro initialization */
                      w11_out_last=32'd0; w12_out_last=32'd0; w13_out_last=32'd0; w14_out_last=32'd0; w15_out_last=32'd0; w16_out_last=32'd0;
                     w21_out_last=32'd0; w22_out_last=32'd0; w23_out_last=32'd0; w24_out_last=32'd0; w25_out_last=32'd0; w26_out_last=32'd0;
                     w31_out_last=32'd0; w32_out_last=32'd0; w33_out_last=32'd0; w34_out_last=32'd0; w35_out_last=32'd0; w36_out_last=32'd0;
                     w41_out_last=32'd0; w42_out_last=32'd0; w43_out_last=32'd0; w44_out_last=32'd0; w45_out_last=32'd0; w46_out_last=32'd0;
                     w51_out_last=32'd0; w52_out_last=32'd0; w53_out_last=32'd0; w54_out_last=32'd0; w55_out_last=32'd0; w56_out_last=32'd0;
                     w61_out_last=32'd0; w62_out_last=32'd0; w63_out_last=32'd0; w64_out_last=32'd0; w65_out_last=32'd0; w66_out_last=32'd0;
                    ns = S_STATE_1;
                
            end
            S_STATE_1:
            begin
           
                state2=32'd2;
                w11_in=m11; w12_in=m12; w13_in=m13; w14_in=m14; w15_in=m11; w16_in=m16;
                w21_in=m21; w22_in=m22; w23_in=m23; w24_in=m24; w25_in=m25; w26_in=m26;
                w31_in=m31; w32_in=m32; w33_in=m33; w34_in=m34; w35_in=m35; w36_in=m36;
                w41_in=m41; w42_in=m42; w43_in=m43; w44_in=m44; w45_in=m45; w46_in=m46;
                w51_in=m51; w52_in=m52; w53_in=m53; w54_in=m54; w55_in=m55; w56_in=m56;
                w61_in=m61; w62_in=m62; w63_in=m63; w64_in=m64; w65_in=m65; w66_in=m66;
                //x2_in=32'd1212;
                
                ns = S_STATE_2;
                counter2= counter2+1;
               // y_nv = w1_in*x1_in + w2_in*x2_in + w3_in*x3_in;
              
             
            end
            S_STATE_2:  
            begin
                state3=32'd3;
            /* start the process */
            /* initiate start */
                 //aen<=1;
			     aclr=0;
			     rst_n=1;  
			     ns=S_STATE_3;
			     counter2= counter2+1;
            end
            S_STATE_3:  
            begin
                /* just delay */  
                state4=32'd4;
			     ns=S_STATE_4;
			    // counter2= counter2+1;
            end
            S_STATE_4:  
            begin
                /* just delay */ 
              //  state5=32'd5 ;
			     ns=S_STATE_5;
			    //ounter2<= counter2+1;
            end
            S_STATE_5:  
            begin
                /* just delay */  
			     ns=S_STATE_6;
			    // counter2<= counter2+1;
            end
            
            S_STATE_6:  
            begin
                /* just delay */  
                //counter2<= counter2+1;
			     ns=S_STATE_7;
			     end
			S_STATE_7:  
            begin
                /* just delay */  
                //counter2<= counter2+1;
			     ns=S_STATE_8;
            end
            S_STATE_8:  
            begin
            /* compare the output */
            /* start the process */
            /* initiate start */
            if((w11_out===w11_out_last)||(w12_out===w12_out_last)||(w13_out===w13_out_last)||(w14_out===w14_out_last)||(w15_out===w15_out_last)||(w16_out===w16_out_last)||
                (w21_out===w21_out_last)||(w22_out===w22_out_last)||(w23_out===w23_out_last)||(w24_out===w24_out_last)||(w25_out===w25_out_last)||(w26_out===w26_out_last)||
                (w31_out===w31_out_last)||(w32_out===w32_out_last)||(w33_out===w33_out_last)||(w34_out===w34_out_last)||(w35_out===w35_out_last)||(w36_out===w36_out_last)||
                (w41_out===w41_out_last)||(w42_out===w42_out_last)||(w43_out===w43_out_last)||(w44_out===w44_out_last)||(w45_out===w45_out_last)||(w46_out===w46_out_last)||
                (w51_out===w51_out_last)||(w52_out===w52_out_last)||(w53_out===w53_out_last)||(w54_out===w54_out_last)||(w55_out===w55_out_last)||(w56_out===w56_out_last)||
                (w61_out===w61_out_last)||(w62_out===w62_out_last)||(w63_out===w63_out_last)||(w64_out===w64_out_last)||(w65_out===w65_out_last)||(w66_out===w66_out_last)
                ) begin
                
                
                
                /*done */
                y11=w11_out; y12=w12_out; y13=w13_out; y14=w14_out; y15=w15_out; y16=w16_out;
                y21=w21_out; y22=w22_out; y23=w23_out; y24=w24_out; y25=w25_out; y26=w26_out;
                y31=w31_out; y32=w32_out; y33=w33_out; y34=w34_out; y35=w35_out; y36=w36_out;
                y41=w41_out; y42=w42_out; y43=w43_out; y44=w44_out; y45=w45_out; y46=w46_out;
                y51=w51_out; y52=w52_out; y53=w53_out; y54=w54_out; y55=w55_out; y56=w56_out;
                y61=w61_out; y62=w62_out; y63=w63_out; y64=w64_out; y65=w65_out; y66=w66_out;
                
                ns=S_STATE_9;/* done */
                //done3=32'd3;
                state8=32'd8;
                state6=32'd6;
                end   
                else 
                begin 
                
                w11_in= w11_out_last; w12_in= w12_out_last; w13_in= w13_out_last; w14_in= w14_out_last; w15_in= w15_out_last; w16_in= w16_out_last;
                w21_in= w21_out_last; w22_in= w22_out_last; w23_in= w23_out_last; w24_in= w24_out_last; w25_in= w25_out_last; w26_in= w26_out_last;
                w31_in= w31_out_last; w32_in= w32_out_last; w33_in= w33_out_last; w34_in= w34_out_last; w35_in= w35_out_last; w36_in= w36_out_last;
                w41_in= w41_out_last; w42_in= w42_out_last; w43_in= w43_out_last; w44_in= w44_out_last; w45_in= w45_out_last; w46_in= w46_out_last;
                w51_in= w51_out_last; w52_in= w52_out_last; w53_in= w53_out_last; w54_in= w54_out_last; w55_in= w55_out_last; w56_in= w56_out_last;
                w61_in= w61_out_last; w62_in= w62_out_last; w63_in= w63_out_last; w64_in= w64_out_last; w65_in= w65_out_last; w66_in= w66_out_last;
                ns=S_STATE_3;
                done3=32'd4;
                state9=32'd9;
                counter2= counter2+1;
                end
            end
            S_STATE_9:  
            begin
                y11_out_final=y11;
                y44_out_final=y44;
                /* just done  */
                 counter2= counter2+1; 
			     done=0;
			     state7=32'd7;
			     ns=7'd0;
            end
            
            default:
                begin 
                 state7=32'd7;
                end
            
        endcase
    end
    /* if counter 5 */
    
    
    
        
    
    
endmodule