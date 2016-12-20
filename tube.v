module tube(clk,rstn,data,seg,sel);
input clk;
input rstn;
input [15:0] data;
output[7:0] seg;
output [3:0] sel;

reg[25:0] count;
reg[3:0] tenth;
reg[3:0] unit;
reg[3:0] decade;
reg[3:0] sign;
reg[3:0] display;



always @ (data)
begin
	//if(!rstn) begin unit <= 0;tenth <= 0;hundred <= 0;thousand <= 0; end
	//else
	//begin
	//	if(is_done)
		//begin
		tenth <= data[3:0];
		unit <=  data[7:4];
		decade <= data[11:8];
		sign <= data[15:12];
			// unit     <= 5*data/510;
			// tenth    <= (50*data/510)%10;
			// hundred  <= (500*data/510)%10;
			// thousand <= (5000*data/510)%10;
	//	end
	//	else;
	//end
end


always @(posedge clk or negedge rstn) 
begin
	if (!rstn) count<=26'b0;
	else if(count==26'd20000) count<=26'b0;
	else count<= count+1;
end

wire timer_1000hz = (count == 26'd20000);
reg[3:0] selBuff;
reg[7:0] segBuff;
always @(posedge clk or negedge rstn) 
begin
	if (!rstn) selBuff<=4'b1000;
	else if (timer_1000hz)
	begin
		selBuff <= {selBuff[2:0],selBuff[3]};
		case (selBuff)
			4'd8: display <= sign;
			4'd1: display <= decade;
			4'd2: display <= unit;
			4'd4: display <= tenth;
			default:;
		endcase;
	end
	else;

end

parameter num0 = 8'b00111111,
		  num1 = 8'b00000110,
		  num2 = 8'b01011011,
		  num3 = 8'b01001111,
		  num4 = 8'b01100110,
		  num5 = 8'b01101101,
		  num6 = 8'b01111101,
		  num7 = 8'b00000111,
		  num8 = 8'b01111111,
		  num9 = 8'b01101111,
		  
		  unum0 = 8'b10111111,
		  unum1 = 8'b10000110,
		  unum2 = 8'b11011011,
		  unum3 = 8'b11001111,
		  unum4 = 8'b11100110,
		  unum5 = 8'b11101101,
		  unum6 = 8'b11111101,
		  unum7 = 8'b10000111,
		  unum8 = 8'b11111111,
		  unum9 = 8'b11101111,
		  minus = 8'b01000000;


 
always @(display)
begin
if(selBuff==4'd2)
begin
	case (display)
	4'd0: segBuff <= unum0;
	4'd1: segBuff <= unum1;
	4'd2: segBuff <= unum2;
	4'd3: segBuff <= unum3;
	4'd4: segBuff <= unum4;
	4'd5: segBuff <= unum5;
	4'd6: segBuff <= unum6;
	4'd7: segBuff <= unum7;
	4'd8: segBuff <= unum8;
	4'd9: segBuff <= unum9;
	default:;
	endcase;
end
else if(selBuff==4'd8)
begin
	case(display)
	4'd0: segBuff <= num0; 
	4'd1: segBuff <= minus;
	default:;
	endcase
end
else
begin
	case(display)
	4'd0: segBuff <= num0;
	4'd1: segBuff <= num1;
	4'd2: segBuff <= num2;
	4'd3: segBuff <= num3;
	4'd4: segBuff <= num4;
	4'd5: segBuff <= num5;
	4'd6: segBuff <= num6;
	4'd7: segBuff <= num7;
	4'd8: segBuff <= num8;
	4'd9: segBuff <= num9;
	default:;
	endcase;
end
end

assign sel = selBuff;
assign seg = segBuff;

endmodule