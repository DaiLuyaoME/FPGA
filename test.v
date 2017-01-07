`timescale 1ns/1ps

module test;

	// Inputs
	reg clk;
	reg rstn;
	reg ad_data;

	// Outputs
	wire adcs;
	wire adclk;
	wire [7:0] data;
	wire isdone;

	// Instantiate the Unit Under Test (UUT)
	ad uut (
		.clk(clk), 
		.rstn(rstn), 
		.ad_data(ad_data), 
		.adcs(adcs), 
		.adclk(adclk), 
		.data(data), 
		.isdone(isdone)
	);

	initial begin
		ad_data = 0;
		clk=1'b0;
		rstn = 0;

		// Wait 100 ns for global reset to finish
		#1 rstn = 1;
        
		// Add stimulus here

	end


always #1
begin
	clk=~clk;
	$display("%d, In%m clock=%b",$time,clk);
end


      
endmodule
