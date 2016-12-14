module main(clk,rstn,rx_pin_in,tx_pin_out,ad_data,ad_clk,ad_cs,seg,sel);
input clk;
input rstn;
input rx_pin_in;
input ad_data;
output tx_pin_out;
output ad_clk;
output ad_cs;
output [7:0] seg;
output [3:0] sel;

reg[25:0] count;

always @ (posedge clk or negedge rstn)
begin
	if(!rstn) count <= 26'b0;
	else
	begin
		if(count==10000000) count <= 26'b0;
		else count <= count + 1;
	end
end

wire halfSec=(count==10000000)?1'b1:1'b0;
wire[7:0] tx_data;
wire tx_en_sig;
wire tx_done_sig;
reg tx_en;


txModule u1(.clk(clk),.rstn(rstn),.tx_data(tx_data),.tx_en_sig(tx_en_sig),.tx_done_sig(tx_done_sig),.tx_pin_out(tx_pin_out));

always @ (posedge clk, negedge rstn)
begin
	if(!rstn) tx_en <= 1'b0;
	else
	begin
		if(halfSec) begin tx_en <= 1'b1;end
		else;
		if(tx_done_sig) tx_en <= 1'b0;
		else;
	end
end
assign tx_en_sig = tx_en;
wire isdone;
ad u2(.clk(clk),.rstn(rstn),.ad_data(ad_data),.adcs(ad_cs),.adclk(ad_clk),.data(tx_data),.isdone(isdone));
tube u3(.clk(clk),.rstn(rstn),.data(tx_data),.seg(seg),.sel(sel));

endmodule