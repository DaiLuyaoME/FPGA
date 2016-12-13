`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:47 12/08/2016 
// Design Name: 
// Module Name:    main 
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
module main(clk,rstn,ad_data,ad_cs,ad_clk,seg,sel);
input clk;
input rstn;
input ad_data;
output reg[7:0] seg;
output reg[3:0] sel;
output  ad_clk;
output  ad_cs;

//reg ad_data;
reg[25:0] count;
reg[3:0] unit;
reg[3:0] tenth;
reg[3:0] hundred;
reg[3:0] thousand;
reg[3:0] display;

always @(posedge clk or negedge rstn) 
begin
	if (!rstn) count<=26'b0;
	else if(count==26'd20000) count<=26'b0;
	else count<= count+1;
end

wire timer_1000hz = (count == 26'd20000);

always @(posedge clk or negedge rstn) 
begin
	if (!rstn) sel<=4'b1000;
	else if (timer_1000hz)
	begin
		sel <= {sel[2:0],sel[3]};
		case (sel)
			4'd8: display <= unit;
			4'd1: display <= tenth;
			4'd2: display <= hundred;
			4'd4: display <= thousand;
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
		  unum9 = 8'b11101111;
 
always @(display)
begin
if(sel==4'd1)
begin
	case (display)
	4'd0: seg <= unum0;
	4'd1: seg <= unum1;
	4'd2: seg <= unum2;
	4'd3: seg <= unum3;
	4'd4: seg <= unum4;
	4'd5: seg <= unum5;
	4'd6: seg <= unum6;
	4'd7: seg <= unum7;
	4'd8: seg <= unum8;
	4'd9: seg <= unum9;
	default:;
	endcase;
end
else 
begin
	case(display)
	4'd0: seg <= num0;
	4'd1: seg <= num1;
	4'd2: seg <= num2;
	4'd3: seg <= num3;
	4'd4: seg <= num4;
	4'd5: seg <= num5;
	4'd6: seg <= num6;
	4'd7: seg <= num7;
	4'd8: seg <= num8;
	4'd9: seg <= num9;
	default:;
	endcase;
end
end

wire is_done;
wire[7:0] buffer;
ad U1(.clk(clk),.rstn(rstn),.ad_data(ad_data),.adcs(ad_cs),.adclk(ad_clk),.data(buffer),.isdone(is_done));


always @ (buffer)
begin
	//if(!rstn) begin unit <= 0;tenth <= 0;hundred <= 0;thousand <= 0; end
	//else
	//begin
	//	if(is_done)
		//begin
			unit     <= 5*buffer/510;
			tenth    <= (50*buffer/510)%10;
			hundred  <= (500*buffer/510)%10;
			thousand <= (5000*buffer/510)%10;
	//	end
	//	else;
	//end
end


endmodule