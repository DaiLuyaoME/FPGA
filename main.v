module main(clk, rstn, one_wire, seg, sel);
input clk;
input rstn;
inout one_wire;
output[7:0] seg;
output [3:0] sel;

wire [15:0] data;
Temperature u1(.clk(clk),.rstn(rstn),.one_wire(one_wire), .temperature(data));
tube u2(.clk(clk),.rstn(rstn),.data(data),.seg(seg),.sel(sel));

endmodule
