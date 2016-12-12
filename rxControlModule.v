`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:00 12/11/2016 
// Design Name: 
// Module Name:    rxControlModule 
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
module rxControlModule( clk,rstn,h2l_sig,rx_pin_in,bps_clk,rx_en_sig,count_sig,rx_data,rx_done_sig
    );
input clk;
input rstn;

input h2l_sig;
input rx_en_sig;
input rx_pin_in;
input bps_clk;

output count_sig;
output [7:0] rx_data；
output rx_done_sig;

reg [3:0] state;
reg [7:0] rData;
reg isCount;
reg isDone;

always @ ( posedge clk, or negedge rstn )
begin
	if( !rstn )
	begin
		state   <= 4'd0;
		rData   <= 8'd0;
		isCount <= 1'b0;
		isDone  <= 1'b0;
	end
	else if (rx_en_sig)
	begin
		case (state)
		4'd0 ：
		if(h2l_sig) begin state <= state + 1'b1; isCount <= 1'b1; end
		4'd1 :
		if(bps_clk) begin state <= state + 1'b1; end
		4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9 :
		if(bps_clk) begin state <= state + 1'b1; rData[state-2] <= rx_pin_in;end
		4'd10 :
		if(bps_clk) begin state <= state + 1'b1; end
		4'd11 :
		if(bps_clk) begin state <= state + 1'b1; end
		4'd12 :
		begin state <= state + 1'b1; isDone <= 1'b1; isCount <= 1'b0; end
		4'd13 :
		begin state <= 1'b0; isDone <= 1'b0; end
		endcase
	end
assign count_sig = isCount;
assign rx_data = rData;
assign rx_done_sig = isDone;



endmodule
