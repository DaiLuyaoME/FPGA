`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:21:33 01/07/2017
// Design Name:   txModule
// Module Name:   D:/CODE/FPGA/uart/tx_tb.v
// Project Name:  uart
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: txModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tx_tb;

	// Inputs
	reg clk;
	reg rstn;
	reg [7:0] tx_data;
	reg tx_en_sig;

	// Outputs
	wire tx_done_sig;
	wire tx_pin_out;

	// Instantiate the Unit Under Test (UUT)
	txModule uut (
		.clk(clk), 
		.rstn(rstn), 
		.tx_data(tx_data), 
		.tx_en_sig(tx_en_sig), 
		.tx_done_sig(tx_done_sig), 
		.tx_pin_out(tx_pin_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rstn = 0;
		tx_data = 0;
		tx_en_sig = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

