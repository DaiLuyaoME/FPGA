`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:59:27 12/13/2016
// Design Name:   main
// Module Name:   D:/CODE/FPGA/ad/dsfgs.v
// Project Name:  ad
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dsfgs;

	// Inputs
	reg clk;
	reg rstn;
	reg ad_data;

	// Outputs
	wire ad_cs;
	wire ad_clk;
	wire [7:0] seg;
	wire [3:0] sel;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.rstn(rstn), 
		.ad_data(ad_data), 
		.ad_cs(ad_cs), 
		.ad_clk(ad_clk), 
		.seg(seg), 
		.sel(sel)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rstn = 0;
		ad_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

