module ledmodule(data,ledout);
input [7:0] data;
output [7:0] ledout;

reg [7:0] ledBuffer;
always @ (*)
begin
	ledBuffer <= data;
end

assign ledout = ledBuffer;

endmodule