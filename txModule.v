module txModule(clk,rstn,tx_data,tx_en_sig,tx_done_sig,tx_pin_out);

input clk;
input rstn;
input [7:0]tx_data;
input tx_en_sig;
output tx_done_sig;
output tx_pin_out;

wire bps_clk;

bpsModule U1(.clk(clk),.rstn(rstn),.count_sig(tx_en_sig),.bps_clk(bps_clk));

txControlModule U2(.clk(clk),.rstn(rstn),.tx_en_sig(tx_en_sig),.tx_data(tx_data),.bps_clk(bps_clk),.tx_done_sig(tx_done_sig),.tx_pin_out(tx_pin_out));

endmodule