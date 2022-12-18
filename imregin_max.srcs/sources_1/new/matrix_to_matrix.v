`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2022 15:12:57
// Design Name: 
// Module Name: matrix_to_matrix
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


module matrix_to_matrix(
input wire clk, rst_n, en, clr,
input [7:0] m11, m12, m13, m14, m15, m16,
m21, m22, m23, m24, m25, m26,
m31, m32, m33, m34, m35, m36,
m41, m42, m43, m44, m45, m46,
m51, m52, m53, m54, m55, m56,
m61, m62, m63, m64, m65, m66,

output [7:0] y11, y12, y13, y14, y15, y16,
y21, y22, y23, y24, y25, y26,
y31, y32, y33, y34, y35, y36,
y41, y42, y43, y44, y45, y46,
y51, y52, y53, y54, y55, y56,
y61, y62, y63, y64, y65, y66
    );
    
    /* delcare padding top */
    reg [7:0] m00=8'd0, m01=8'd0, m02=8'd0, m03=8'd0, m04=8'd0, m05=8'd0, m06=8'd0, m07=8'd0;
    /* declare padding left */
    reg [7:0] m10=8'd0, m20=8'd0, m30=8'd0, m40=8'd0, m50=8'd0, m60=8'd0;
    /* declare padding rigth */
    reg [7:0] m17=8'd0, m27=8'd0, m37=8'd0, m47=8'd0, m57=8'd0, m67=8'd0;
    /* declare padding bottom */
    reg [7:0] m70=8'd0, m71=8'd0, m72=8'd0, m73=8'd0, m74=8'd0, m75=8'd0, m76=8'd0, m77=8'd0;
    
    /* declare buffer input */
    wire [7:0] w11_in, w12_in, w13_in, w14_in, w15_in, w16_in,
    w21_in, w22_in, w23_in, w24_in, w25_in, w26_in,
    w31_in, w32_in, w33_in, w34_in, w35_in, w36_in,
    w41_in, w42_in, w43_in, w44_in, w45_in, w46_in,
    w51_in, w52_in, w53_in, w54_in, w55_in, w56_in,
    w61_in, w62_in, w63_in, w64_in, w65_in, w66_in;
    
    /* declare buffer output */
    wire [7:0] w11_out, w12_out, w13_out, w14_out, w15_out, w16_out,
    w21_out, w22_out, w23_out, w24_out, w25_out, w26_out,
    w31_out, w32_out, w33_out, w34_out, w35_out, w36_out,
    w41_out, w42_out, w43_out, w44_out, w45_out, w46_out,
    w51_out, w52_out, w53_out, w54_out, w55_out, w56_out,
    w61_out, w62_out, w63_out, w64_out, w65_out, w66_out;
    
    /* wire register maksimal */
    wire [7:0] max11_out, max12_out, max13_out, max14_out, max15_out, max16_out,
    max21_out, max22_out, max23_out, max24_out, max25_out, max26_out,
    max31_out, max32_out, max33_out, max34_out, max35_out, max36_out,
    max41_out, max42_out, max43_out, max44_out, max45_out, max46_out,
    max51_out, max52_out, max53_out, max54_out, max55_out, max56_out,
    max61_out, max62_out, max63_out, max64_out, max65_out, max66_out;
    
    /* compute row 1 */
    matrix_max mm11(m11, m00, m01, m02, m10, m12, m20, m21, m22, clk, rst_n, en, clr, max11_out, w11_out);
    matrix_max mm12(m12, m01, m02, m10, m11, m13, m21, m22, m23, clk, rst_n, en, clr, max12_out, w12_out);
    matrix_max mm13(m13, m02, m03, m04, m12, m14, m22, m23, m24, clk, rst_n, en, clr, max13_out, w13_out);
    matrix_max mm14(m14, m03, m04, m05, m13, m15, m23, m24, m25, clk, rst_n, en, clr, max14_out, w14_out);
    matrix_max mm15(m15, m04, m05, m06, m14, m16, m24, m25, m26, clk, rst_n, en, clr, max15_out, w15_out);
    matrix_max mm16(m16, m05, m06, m07, m15, m17, m25, m26, m27, clk, rst_n, en, clr, max16_out, w16_out);
    
    /* compute row 2 */
    matrix_max mm21(m21, m10, m11, m12, m20, m22, m30, m31, m32, clk, rst_n, en, clr, max21_out, w21_out);
    matrix_max mm22(m22, m11, m12, m13, m21, m23, m31, m32, m33, clk, rst_n, en, clr, max22_out, w22_out);
    matrix_max mm23(m23, m12, m13, m14, m22, m24, m32, m33, m34, clk, rst_n, en, clr, max23_out, w23_out);
    matrix_max mm24(m24, m13, m14, m15, m23, m25, m33, m34, m35, clk, rst_n, en, clr, max24_out, w24_out);
    matrix_max mm25(m25, m14, m15, m16, m24, m26, m34, m35, m36, clk, rst_n, en, clr, max25_out, w25_out);
    matrix_max mm26(m26, m15, m16, m17, m25, m27, m35, m36, m37, clk, rst_n, en, clr, max26_out, w26_out);
    
    /* compute row 3 */
    matrix_max mm31(m31, m20, m21, m22, m30, m32, m40, m41, m42, clk, rst_n, en, clr, max31_out, w31_out);
    matrix_max mm32(m32, m21, m22, m23, m31, m33, m41, m42, m43, clk, rst_n, en, clr, max32_out, w32_out);
    matrix_max mm33(m33, m22, m23, m24, m32, m34, m42, m43, m44, clk, rst_n, en, clr, max33_out, w33_out);
    matrix_max mm34(m34, m23, m24, m25, m33, m35, m43, m44, m45, clk, rst_n, en, clr, max34_out, w34_out);
    matrix_max mm35(m35, m24, m25, m26, m34, m36, m44, m45, m46, clk, rst_n, en, clr, max35_out, w35_out);
    matrix_max mm36(m36, m25, m26, m27, m35, m37, m45, m46, m47, clk, rst_n, en, clr, max36_out, w36_out);
    
    /* compute row 4 */
    matrix_max mm41(m41, m30, m31, m32, m40, m42, m50, m51, m52, clk, rst_n, en, clr, max41_out, w41_out);
    matrix_max mm42(m42, m31, m32, m33, m41, m43, m51, m52, m53, clk, rst_n, en, clr, max42_out, w42_out);
    matrix_max mm43(m43, m32, m33, m34, m42, m44, m52, m53, m54, clk, rst_n, en, clr, max43_out, w43_out);
    matrix_max mm44(m44, m33, m34, m35, m43, m45, m53, m54, m55, clk, rst_n, en, clr, max44_out, w44_out);
    matrix_max mm45(m45, m34, m35, m36, m44, m46, m54, m55, m56, clk, rst_n, en, clr, max45_out, w45_out);
    matrix_max mm46(m46, m35, m36, m37, m45, m47, m55, m56, m57, clk, rst_n, en, clr, max46_out, w46_out);
    
    /* compute row 5 */
    matrix_max mm51(m51, m40, m41, m42, m50, m52, m60, m61, m62, clk, rst_n, en, clr, max51_out, w51_out);
    matrix_max mm52(m52, m41, m42, m43, m51, m53, m61, m62, m63, clk, rst_n, en, clr, max52_out, w52_out);
    matrix_max mm53(m53, m42, m43, m44, m52, m54, m62, m63, m64, clk, rst_n, en, clr, max53_out, w53_out);
    matrix_max mm54(m54, m43, m44, m45, m53, m55, m63, m64, m65, clk, rst_n, en, clr, max54_out, w54_out);
    matrix_max mm55(m55, m44, m45, m46, m54, m56, m64, m65, m66, clk, rst_n, en, clr, max55_out, w55_out);
    matrix_max mm56(m56, m45, m46, m47, m55, m57, m65, m66, m67, clk, rst_n, en, clr, max56_out, w56_out);
    
    /* compute row 6 */
    matrix_max mm61(m61, m50, m51, m52, m60, m62, m70, m71, m72, clk, rst_n, en, clr, max61_out, w61_out);
    matrix_max mm62(m62, m51, m52, m53, m61, m63, m71, m72, m73, clk, rst_n, en, clr, max62_out, w62_out);
    matrix_max mm63(m63, m52, m53, m54, m62, m64, m72, m73, m74, clk, rst_n, en, clr, max63_out, w63_out);
    matrix_max mm64(m64, m53, m54, m55, m63, m65, m73, m74, m75, clk, rst_n, en, clr, max64_out, w64_out);
    matrix_max mm65(m65, m54, m55, m56, m64, m66, m74, m75, m76, clk, rst_n, en, clr, max65_out, w65_out);
    matrix_max mm66(m66, m55, m56, m57, m65, m67, m75, m76, m77, clk, rst_n, en, clr, max66_out, w66_out);
    
    /* row 1*/
    register reg_max11(clk, rst_n, en, clr, w11_out, y11);
    register reg_max12(clk, rst_n, en, clr, w12_out, y12);
    register reg_max13(clk, rst_n, en, clr, w13_out, y13);
    register reg_max14(clk, rst_n, en, clr, w14_out, y14);
    register reg_max15(clk, rst_n, en, clr, w15_out, y15);
    register reg_max16(clk, rst_n, en, clr, w16_out, y16);
    
    /* row 2*/
    register reg_max21(clk, rst_n, en, clr, w21_out, y21);
    register reg_max22(clk, rst_n, en, clr, w22_out, y22);
    register reg_max23(clk, rst_n, en, clr, w23_out, y23);
    register reg_max24(clk, rst_n, en, clr, w24_out, y24);
    register reg_max25(clk, rst_n, en, clr, w25_out, y25);
    register reg_max26(clk, rst_n, en, clr, w26_out, y26);
    
    /* row 3 */
    register reg_max31(clk, rst_n, en, clr, w31_out, y31);
    register reg_max32(clk, rst_n, en, clr, w32_out, y32);
    register reg_max33(clk, rst_n, en, clr, w33_out, y33);
    register reg_max34(clk, rst_n, en, clr, w34_out, y34);
    register reg_max35(clk, rst_n, en, clr, w35_out, y35);
    register reg_max36(clk, rst_n, en, clr, w36_out, y36);
    
    /* row  4 */
    register reg_max41(clk, rst_n, en, clr, w41_out, y41);
    register reg_max42(clk, rst_n, en, clr, w42_out, y42);
    register reg_max43(clk, rst_n, en, clr, w43_out, y43);
    register reg_max44(clk, rst_n, en, clr, w44_out, y44);
    register reg_max45(clk, rst_n, en, clr, w45_out, y45);
    register reg_max46(clk, rst_n, en, clr, w46_out, y46);
    
    /* row 5 */
    register reg_max51(clk, rst_n, en, clr, w51_out, y51);
    register reg_max52(clk, rst_n, en, clr, w52_out, y52);
    register reg_max53(clk, rst_n, en, clr, w53_out, y53);
    register reg_max54(clk, rst_n, en, clr, w54_out, y54);
    register reg_max55(clk, rst_n, en, clr, w55_out, y55);
    register reg_max56(clk, rst_n, en, clr, w56_out, y56);
    
    /* row 6 */
    register reg_max61(clk, rst_n, en, clr, w61_out, y61);
    register reg_max62(clk, rst_n, en, clr, w62_out, y62);
    register reg_max63(clk, rst_n, en, clr, w63_out, y63);
    register reg_max64(clk, rst_n, en, clr, w64_out, y64);
    register reg_max65(clk, rst_n, en, clr, w65_out, y65);
    register reg_max66(clk, rst_n, en, clr, w66_out, y66);
        
    
endmodule
