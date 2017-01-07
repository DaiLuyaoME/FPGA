module ad(clk,rstn,ad_data,adcs,adclk,data,isdone);
input clk;
input rstn;
input ad_data;
output adcs;
output adclk;
output [7:0] data;
output isdone;

reg[7:0] cnt=0;
reg ad_clk;
always @(posedge clk ) 
begin
	if(cnt==40) cnt<=0;
	else
	begin
	 	if(cnt < 20) ad_clk <= 0;
	 	else ad_clk <= 1;
	 	cnt <= cnt+1;
	end

end

assign adclk = ad_clk;

reg [4:0] conv_bit_cnt;

always @(posedge ad_clk or negedge rstn) 
begin
	if (!rstn) conv_bit_cnt<=0;
	else 
	begin 
		if(conv_bit_cnt==18) conv_bit_cnt <=0;
		else conv_bit_cnt <= conv_bit_cnt+1;
	end
end

reg [7:0] buffer;
reg [7:0] databuf;
reg is_done;
reg ad_cs;
// reg [7:0] buff;
always @(posedge ad_clk or negedge rstn)

begin
	if(!rstn) begin is_done <= 0; databuf <= 0; end
	case(conv_bit_cnt)
		4'h0 : ad_cs <= 0;
		4'h1 : buffer[7] <= ad_data;
		4'h2 : buffer[6] <= ad_data;
		4'h3 : buffer[5] <= ad_data;
		4'h4 : buffer[4] <= ad_data;
		4'h5 : buffer[3] <= ad_data;
		4'h6 : buffer[2] <= ad_data;
		4'h7 : buffer[1] <= ad_data;
		4'h8 : begin
				buffer[0] <= ad_data;
				ad_cs     <= 1;
				//is_done   <= 1;
			   end
		4'h9 : begin is_done <= 1;databuf <= buffer;end
		4'h10 :begin is_done <= 0;end

		default:;
	endcase		
end
assign adcs = ad_cs;
assign data = databuf;
assign isdone = is_done;

endmodule
