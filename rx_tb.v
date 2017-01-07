`timescale 1ns / 1ns

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:45:28 01/07/2017
// Design Name:   rxModule
// Module Name:   D:/CODE/FPGA/uart/rx_tb.v
// Project Name:  uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rxModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rx_tb;

	// Inputs
	reg clk;
	reg rstn;
	reg rx_pin_in;
	reg rx_en_sig;

	// Outputs
	wire rx_done_sig;
	wire [7:0] rx_data;

	// Instantiate the Unit Under Test (UUT)
	rxModule uut (
		.clk(clk), 
		.rstn(rstn), 
		.rx_pin_in(rx_pin_in), 
		.rx_en_sig(rx_en_sig), 
		.rx_done_sig(rx_done_sig), 
		.rx_data(rx_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rstn = 0;
		rx_pin_in = 0;
		rx_en_sig = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

