module multiplexer(input  [7:0] a,b,c,d,e,f,g,h, input [2:0] S,input en, output [7:0] out);

reg [7:0] out_o;
always@(a or b or c or d or e or f or g or h or en or S)
begin

if(en)
begin
case (S)
3'b000 : out_o <= a;
3'b001 : out_o <= b;
3'b010 : out_o <= c;
3'b011 : out_o <= d;
3'b100 : out_o <= e;
3'b101 : out_o <= f;
3'b110 : out_o <= g;
3'b111 : out_o <= h;
endcase
end
else
out_o <= 8'd0;
end
assign out = out_o;
endmodule