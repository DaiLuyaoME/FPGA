`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:13 12/11/2016 
// Design Name: 
// Module Name:    rx_module 
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
module rxModule(clk,rstn,rx_pin_in,rx_en_sig,rx_done_sig,rx_data
    );
input clk;
input rstn;
input rx_pin_in;
input rx_en_sig;
output rx_done_sig;
output [7:0]rx_data;

wire h2l_sig;
detectModule U1
( 
	.clk(clk),
	.rstn(rstn),
	.rx_pin_in(rx_pin_in),
	.h2l_sig(h2l_sig) 
);

wire bps_clk;

bpsModule U2
(
	.clk(clk),
	.rstn(rstn),
	.count_sig(count_sig),
	.bps_clk(bps_clk)
);

wire count_sig;

rxControlModule U3
(
	.clk(clk),
	.rstn(rstn),
	.h2l_sig(h2l_sig),
	.rx_en_sig(rx_en_sig),
	.rx_pin_in(rx_pin_in),
	.bps_clk(bps_clk),
	.count_sig(count_sig),
	.rx_data(rx_data),
	.rx_done_sig(rx_done_sig)
);

endmodule
