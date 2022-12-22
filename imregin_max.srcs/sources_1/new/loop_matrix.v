`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 20:47:00
// Design Name: 
// Module Name: loop_matrix
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


module loop_matrix(input wire clk, rst_n, en, clr,
input wire [31:0] m11, m12, m13, m14, m15, m16,
m21, m22, m23, m24, m25, m26,
m31, m32, m33, m34, m35, m36,
m41, m42, m43, m44, m45, m46,
m51, m52, m53, m54, m55, m56,
m61, m62, m63, m64, m65, m66, 

output reg[31:0] y11, y12, y13, y14, y15, y16,
y21, y22, y23, y24, y25, y26,
y31, y32, y33, y34, y35, y36,
y41, y42, y43, y44, y45, y46,
y51, y52, y53, y54, y55, y56,
y61, y62, y63, y64, y65, y66,
output reg[1:0] done
);
    /* set initial */
    wire [2:0] counter;
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
    
    /* compare */
    
    
    /* set from initial input */
    
    /* process*/
    matrix_to_matrix process_matrix_0(
        .clk(clk), .rst_n(rst_n), .en(en), .clr(clr),
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
    /* if counter 5 */
    
    always @ (posedge clk) 
    begin  
    if (!rst_n)
        begin
        /*set initial value */  
        w11_in<=m11; w12_in<=m12; w13_in<=m13; w14_in<=m14; w15_in<=m11; w16_in<=m16;
        w21_in<=m21; w22_in<=m22; w23_in<=m23; w24_in<=m24; w25_in<=m25; w26_in<=m26;
        w31_in<=m31; w32_in<=m32; w33_in<=m33; w34_in<=m34; w35_in<=m35; w36_in<=m36;
        w41_in<=m41; w42_in<=m42; w43_in<=m43; w44_in<=m44; w45_in<=m45; w46_in<=m46;
        w51_in<=m51; w52_in<=m52; w53_in<=m53; w54_in<=m54; w55_in<=m55; w56_in<=m56;
        w61_in<=m61; w62_in<=m62; w63_in<=m63; w64_in<=m64; w65_in<=m65; w66_in<=m66;
        done <=0;
        w11_out_last<=0; w12_out_last<=0; w13_out_last<=0; w14_out_last<=0; w15_out_last<=0; w16_out_last<=0;
        w21_out_last<=0; w22_out_last<=0; w23_out_last<=0; w24_out_last<=0; w25_out_last<=0; w26_out_last<=0;
        w31_out_last<=0; w32_out_last<=0; w33_out_last<=0; w34_out_last<=0; w35_out_last<=0; w36_out_last<=0;
        w41_out_last<=0; w42_out_last<=0; w43_out_last<=0; w44_out_last<=0; w45_out_last<=0; w46_out_last<=0;
        w51_out_last<=0; w52_out_last<=0; w53_out_last<=0; w54_out_last<=0; w55_out_last<=0; w56_out_last<=0;
        w61_out_last<=0; w62_out_last<=0; w63_out_last<=0; w64_out_last<=0; w65_out_last<=0; w66_out_last<=0;
        end 
        else
        begin
            /* if counter ==5 kemudian compare */ 
            if(counter==5)
            begin 
                /* compare */
                
                if((w11_out==w11_out_last)||(w12_out==w12_out_last)||(w13_out==w13_out_last)||(w14_out==w14_out_last)||(w15_out==w15_out_last)||(w16_out==w16_out_last)||
                (w21_out==w21_out_last)||(w22_out==w22_out_last)||(w23_out==w23_out_last)||(w24_out==w24_out_last)||(w25_out==w25_out_last)||(w26_out==w26_out_last)||
                (w31_out==w31_out_last)||(w32_out==w32_out_last)||(w33_out==w33_out_last)||(w34_out==w34_out_last)||(w35_out==w35_out_last)||(w36_out==w36_out_last)||
                (w41_out==w41_out_last)||(w42_out==w42_out_last)||(w43_out==w43_out_last)||(w44_out==w44_out_last)||(w45_out==w45_out_last)||(w46_out==w46_out_last)||
                (w51_out==w51_out_last)||(w52_out==w52_out_last)||(w53_out==w53_out_last)||(w54_out==w54_out_last)||(w55_out==w55_out_last)||(w56_out==w56_out_last)||
                (w61_out==w61_out_last)||(w62_out==w62_out_last)||(w63_out==w63_out_last)||(w64_out==w64_out_last)||(w65_out==w65_out_last)||(w66_out==w66_out_last)
                ) begin
                
                
                /*done */
                
                y11<=w11_out;y12<=w12_out; y13<=w13_out; y14<=w14_out; y15<=w15_out; y16<=w16_out;
                y21<=w21_out; y22<=w22_out; y23<=w23_out; y24<=w24_out; y25<=w25_out; y26<=w26_out;
                y31<=w31_out; y32<=w32_out; y33<=w33_out; y34<=w34_out; y35<=w35_out; y36<=w36_out;
                y41<=w41_out; y42<=w42_out; y43<=w43_out; y44<=w44_out; y45<=w45_out; y46<=w46_out;
                y51<=w51_out; y52<=w52_out; y53<=w53_out; y54<=w54_out; y55<=w55_out; y56<=w56_out;
                y61<=w61_out; y62<=w62_out; y63<=w63_out; y64<=w64_out; y65<=w65_out; y66<=w66_out;
                
                done <=1;
                
                
                end
                else 
                begin
                /* loop again*/ 
                /* send buffer to last output */
                    w11_out_last<=w11_out; w12_out_last<=w12_out; w13_out_last<=w13_out; w14_out_last<=w14_out; w15_out_last<=w15_out; w16_out_last<=w16_out;
                    w21_out_last<=w21_out; w22_out_last<=w22_out; w23_out_last<=w23_out; w24_out_last<=w24_out; w25_out_last<=w25_out; w26_out_last<=w26_out;
                    w31_out_last<=w31_out; w32_out_last<=w32_out; w33_out_last<=w33_out; w34_out_last<=w34_out; w35_out_last<=w35_out; w36_out_last<=w36_out;
                    w41_out_last<=w41_out; w42_out_last<=w42_out; w43_out_last<=w43_out; w44_out_last<=w44_out; w45_out_last<=w45_out; w46_out_last<=w46_out;
                    w51_out_last<=w51_out; w52_out_last<=w52_out; w53_out_last<=w53_out; w54_out_last<=w54_out; w55_out_last<=w55_out; w56_out_last<=w56_out;
                    w61_out_last<=w61_out; w62_out_last<=w62_out; w63_out_last<=w63_out; w64_out_last<=w64_out; w65_out_last<=w65_out; w66_out_last<=w66_out;
                /* kalau counter >=7 */
                
                if(counter==6)
                begin
                    
                    
                    w11_in<= w11_out_last; w12_in<= w12_out_last; w13_in<= w13_out_last; w14_in<= w14_out_last; w15_in<= w15_out_last; w16_in<= w16_out_last;
                    w21_in<= w21_out_last; w22_in<= w22_out_last; w23_in<= w23_out_last; w24_in<= w24_out_last; w25_in<= w25_out_last; w26_in<= w26_out_last;
                    w31_in<= w31_out_last; w32_in<= w32_out_last; w33_in<= w33_out_last; w34_in<= w34_out_last; w35_in<= w35_out_last; w36_in<= w36_out_last;
                    w41_in<= w41_out_last; w42_in<= w42_out_last; w43_in<= w43_out_last; w44_in<= w44_out_last; w45_in<= w45_out_last; w46_in<= w46_out_last;
                    w51_in<= w51_out_last; w52_in<= w52_out_last; w53_in<= w53_out_last; w54_in<= w54_out_last; w55_in<= w55_out_last; w56_in<= w56_out_last;
                    w61_in<= w61_out_last; w62_in<= w62_out_last; w63_in<= w63_out_last; w64_in<= w64_out_last; w65_in<= w65_out_last; w66_in<= w66_out_last;
                    /* reset counter */
                end
                
                end
            end
        
        end
    end
    
endmodule
