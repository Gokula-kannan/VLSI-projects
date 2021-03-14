`timescale 1ns / 1ps



module Pearson_hash_v2(input clk,reset,en, output [7:0] out);

reg [7:0] S [255:0];
integer i,j;

reg comp;
localparam IDLE = 3'b000,
		   S1 = 3'b001,
		   S2 = 3'b010,
		   S3 = 3'b011;
		   
reg [7:0] hash;
reg [2:0] state,state_next;


//For assigning the Values for Msg Bits.
wire [7:0] msg [0:7];

assign msg[0] = 8'd47;
assign msg[1] = 8'd17;
assign msg[2] = 8'd48;
assign msg[3] = 8'd12;
assign msg[4] = 8'd26;
assign msg[5] = 8'd28;
assign msg[6] = 8'd40;
assign msg[7] = 8'd21;


always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		state <= IDLE;
	end
	
	else 
	begin
		state <= state_next;
	end 
end 

initial
begin
    for(i=8'd0;i<256;i=i+8'd1)
    begin
        S[i] <= i;
    end
end  



always@(state or en)
begin
	state_next = state;
	
	case(state)
		IDLE:
		begin
				if(en==8'd1)
				begin
					state_next = S1;
					comp=8'd0;
					j = 8'd0;
				end
				
				else
				begin
				   state_next = IDLE;	
				   comp= 8'dx;		
				end 			
		end
		
		// Initialisation
		S1:
		begin   
				   
				    j = 8'd0;
				    hash = 8'd0;
				    state_next = S2;
		end 
		
		//State for Pearson Algorith Calculation
		S2:
		begin
				for(j=0;j<8;j=j+1)
				begin
					hash = S[hash ^ msg[j]];
				end 
				state_next = S3;				
		end 
		
		//State for outout enable
		S3:
		begin
				comp = 8'd1;
		end 
		
		default:
		      hash = 8'd0;
	endcase 
end

assign out = (comp==8'd1) ? hash : 8'd0; 

endmodule

