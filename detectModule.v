`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:08 12/11/2016 
// Design Name: 
// Module Name:    detectModule 
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
module detectModule(clk, rstn, rx_pin_in, h2l_sig
    );

input clk;
input rstn;
input rx_pin_in;
output h2l_sig;

reg h2l_1;
reg h2l_2;

always @(posedge clk or negedge rstn)
begin
	if (!rstn)
	begin
		h2l_1 <= 1'b1;
		h2l_2 <= 1'b1;
	end;
	else
	begin
		h2l_1 <= rx_pin_in;
		h2l_2 <= h2l_1;
	end
		
assign h2l_sig = h2l_2 & !h2l_1;
end
endmodule
