/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"

#define x_dimension 6
#define y_dimension 6
#define BASE_ADDRESS 0x40000000

typedef u32 matrix_image[x_dimension][y_dimension];
typedef u16 matrix_address[x_dimension][y_dimension];

int main()
{
    init_platform();

    /* address start */
    u16 adress_start= 0x00;
    /* address done */
    u16 adress_done= 0x04;
    /* state set address*/
    u16 state_address =0x0c;


    /* clear, rest_n, en address
     * 	x3=aen, w1=aclr, w2=rst_n
     *  */
    u16 aen_addr = 0x10;
    u16 aclr_addr= 0x14;
    u16 rst_n_addr = 0x18;





    /* input adress */

    matrix_address mi_addr={
    		{0x24, 0x28, 0x2c, 0x30, 0x34, 0x38},
			{0x3c, 0x40, 0x44, 0x48, 0x4c, 0x50},
			{0x54, 0x58, 0x5c, 0x60, 0x64, 0x68},
			{0x6c, 0x70, 0x74, 0x78, 0x7c, 0x80},
			{0x84, 0x88, 0x8c, 0x90, 0x94, 0x98},
			{0x9c, 0xa0, 0xa4, 0xa8, 0xac, 0xb0},
    };

    /* output adress */
    matrix_address mo_addr={
    		{0xb4, 0xb8, 0xbc, 0xc0, 0xc4, 0xc8},
			{0xcc, 0xd0, 0xd4, 0xd8, 0xdc, 0xe0},
			{0xe4, 0xe8, 0xec, 0xf0, 0xf4, 0xf8},
			{0xfc, 0x100, 0x104, 0x108, 0x10c, 0x110},
			{0x114, 0x118, 0x11c, 0x120, 0x124, 0x128},
			{0x12c, 0x130, 0x134, 0x138, 0x13c, 0x140},
    };

    /* declare input for matrix to test */

    /* matrix from matlab 1 loop */
    matrix_image mi={
    		{0,0,0,1,2,3},
    		{0,1,0,2,3,3},
			{0,0,0,2,3,4},
			{1,3,1,5,4,5},
			{0,0,0,3,2,4},
			{2,1,0,1,2,3},
    };


    /* matrix which is need more loops */

    matrix_image mi2={
        		{1,2,3,4,5,6},
        		{1,2,3,4,5,6},
    			{1,2,3,4,5,6},
    			{1,2,3,4,5,6},
    			{1,2,3,4,5,6},
    			{1,2,3,4,5,6},
        };

    xil_printf("\r\n AUs12\r\n");
    /* insert into processor */
    xil_printf("\r\n Done : %d\r\n", Xil_In32(BASE_ADDRESS+0x4));
    /* o */

    xil_printf("\r\n input matrix \r\n");

    for (u8 index_row =0; index_row<6; index_row++){
    	for (u8 index_col =0; index_col<6; index_col++){
    		xil_printf(" %d ", mi[index_row][index_col]);
    	 }

    	xil_printf("\r\n");

    }

    /* write to hardware */
    for (u8 index_row =0; index_row<6; index_row++){
        	for (u8 index_col =0; index_col<6; index_col++){
        		Xil_Out32(BASE_ADDRESS+mi_addr[index_row][index_col], mi[index_row][index_col]);
        	 }

        	xil_printf("\r\n");

        }
    /* set to start */
   // Xil_Out32(BASE_ADDRESS, 1);
    xil_printf("\r\n Done : %d\r\n", Xil_In32(BASE_ADDRESS+0x4));
    /* clear */
    Xil_Out32(BASE_ADDRESS+state_address, 0);
    xil_printf("\r\n start : %d\r\n", Xil_In32(BASE_ADDRESS));
    xil_printf("\r\n Done : %d\r\n", Xil_In32(BASE_ADDRESS+0x4));
    xil_printf("\r\n state : %d\r\n", Xil_In32(BASE_ADDRESS+state_address));

    xil_printf("\r\n en : %d\r\n", Xil_In32(BASE_ADDRESS+aen_addr));
    xil_printf("\r\n clr : %d\r\n", Xil_In32(BASE_ADDRESS+aclr_addr));
    xil_printf("\r\n rst_n : %d\r\n", Xil_In32(BASE_ADDRESS+rst_n_addr));
    /* lets run */
    Xil_Out32(BASE_ADDRESS+state_address, 4212);
    Xil_Out32(BASE_ADDRESS+0x10, 4213);
    xil_printf("\r\n state : %d\r\n", Xil_In32(BASE_ADDRESS+state_address));
    xil_printf("\r\n en : %d\r\n", Xil_In32(BASE_ADDRESS+aen_addr));
    xil_printf("\r\n clr : %d\r\n", Xil_In32(BASE_ADDRESS+aclr_addr));
    xil_printf("\r\n rst_n : %d\r\n", Xil_In32(BASE_ADDRESS+rst_n_addr));

    /* check if done */
   // sleep(5);

    xil_printf("\r\n start : %d\r\n", Xil_In32(BASE_ADDRESS));
       xil_printf("\r\n Done : %d\r\n", Xil_In32(BASE_ADDRESS+0x4));
       xil_printf("\r\n state : %d\r\n", Xil_In32(BASE_ADDRESS+state_address));

    /* display output */
    xil_printf("\r\nOutput Matrix w\r\n");
    for (u8 index_row =0; index_row<6; index_row++){
        	for (u8 index_col =0; index_col<6; index_col++){
        		xil_printf(" %d ",  Xil_In32(BASE_ADDRESS+mo_addr[index_row][index_col]));
        	 }

        	xil_printf("\r\n");

        }

    xil_printf("\r\nOutput ram 13 asa\r\n");
    for (u8 index_row =0; index_row<6; index_row++){
           	for (u8 index_col =0; index_col<6; index_col++){
           		xil_printf(" %u ",  Xil_In32(BASE_ADDRESS+mo_addr[index_row][index_col]));
           	 }

           	xil_printf("\r\n");

           }



    for(u8 index_row=0; index_row<100; index_row++){
    	xil_printf(" %x : %d \r\n", BASE_ADDRESS+(index_row*4), Xil_In32(BASE_ADDRESS+(index_row*4)));

    }

    xil_printf("segala\r\n");

    cleanup_platform();
    return 0;
}

