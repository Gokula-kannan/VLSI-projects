module pe_tb;
reg [7:0] msg;

pearson dut(msg);

initial
begin
	msg = 8'd123;
end

endmodule
