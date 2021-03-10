module Pearson_tb;

wire [7:0] msg,hash;

reg clk,reset;
pearson dut(msg,clk,reset,hash);



initial begin 
clk=0;
forever #5 clk=~clk;
end

assign msg = 8'd75;

initial begin
reset=1; 
#20;
reset=0;
#100 $finish;
end

endmodule
