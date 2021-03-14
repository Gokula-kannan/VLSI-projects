`timescale 1ns / 1ps


module Pearson_hash_v2_tb;

reg clk,reset,en;

wire [7:0] out;



Pearson_hash_v2 dut(clk,reset,en,out);

//Clk Generation
initial begin 
clk=0;
forever #5 clk=~clk;
end


initial begin
reset=1; en=1;
#20;
reset=0; 
#100 $finish;
end

endmodule
