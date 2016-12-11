`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:31 12/11/2016 
// Design Name: 
// Module Name:    bpsModule 
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
module bpsModule(clk,rstn,count_sig,bps_clk)
    );

input clk;
input rstn;
input count_sig;
output bps_clk;

reg [11:0] count;
always @(posedge clk or negedge rstn) 
begin
	if (!rstn) 
		count <= 12'd0;
	else if (count == 12'd2082)
		count <= 12'd0;
	else if (count_sig)  
		count <= count + 1'b1;
	else
		count <= 12'd0;
end
assign bps_clk = (count > 12'd1041) ? 1'b1:1'b0;
endmodule
