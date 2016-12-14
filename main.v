`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:47 12/08/2016 
// Design Name: 
// Module Name:    main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module main(clk,rstn,ad_data,ad_cs,ad_clk,seg,sel);
input clk;
input rstn;
input ad_data;
output  [7:0]seg;
output  [3:0]sel;
output  ad_clk;
output  ad_cs;

wire is_done;
wire[7:0] buffer;
ad U1(.clk(clk),.rstn(rstn),.ad_data(ad_data),.adcs(ad_cs),.adclk(ad_clk),.data(buffer),.isdone(is_done));
tube U2(.clk(clk),.rstn(rstn),.data(buffer),.seg(seg),.sel(sel));

endmodule