module txControlModule(clk,rstn,tx_en_sig,tx_data,bps_clk,tx_done_sig,tx_pin_out);
input clk;
input rstn;
input tx_en_sig;
input [7:0]tx_data;
input bps_clk;
output tx_done_sig;
output tx_pin_out;

reg [3:0] state;
reg rtx;
reg isdone;

always @ (posedge clk or negedge rstn)
	if(! rstn)
	begin
		state  <= 4'd0;
		rtx    <= 1'b1;
		isDone <= 1'b0;
	end
	else if(tx_en_sig)
	begin
		case (state)
		4'd0 ：
		if(bps_clk) begin state <= state + 1'b1; rtx <= 1'b0; end
		4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8:
		if(bps_clk) begin state <= state + 1'b1; rtx <= tx_data[state-1]; end
		4'd9,4'd10 :
		if(bps_clk) begin state <= state + 1'b1; rtx <= 1'b1; end
		4'd11 :
		if(bps_clk) begin state <= state + 1'b1; isDone <= 1'b1; end
		4'd12 :
		begin state <= 1'b0; isDone <= 1'b0; end
		endcase
	end

	assign tx_pin_out = rtx;
	assign tx_done_sig = isDone;
endmodule