// The design consist of Two Multiplers, One XOR gate, and a Asynchronous Ram. 
            // The algorithmis given by
             /* algorithm pearson hashing is
                h := 0

               for each c in C loop
                   h := T[ h xor c ]
               end loop

               return h  */
//The hash function uses a Forloop and need to Access a Table of contents. Hence, I have used a RAM for Accessing Memory. And to accomadate the For Loop, I have used 
// a Counter design along with XOR gate and Multiplexers.
//The Schematic diagram attached would give a Good view of the design.

module pearson(input [7:0] msg_i,
                 input clk_i,reset_i,
                 output [7:0] hash_o);

wire [7:0] data_temp;
wire [7:0] addr;
 
wire [7:0] xor_i1,xor_i2;
reg [2:0] state;
wire [2:0] S;
wire [6:0] test;
 
wire [7:0] a,b,c,d,e,f,g,h;

//The Mux_1 consist of 8 inputs with 'State' as control bit. At each posedge, the 'State' will change the output.
//For the first input, 0 is given and other inputs are connected to the data_temp reg.
multiplexer mux_1(8'd0,data_temp,data_temp,data_temp,data_temp,data_temp,data_temp,data_temp,state,32'd1,xor_i1);
 
//The Mux_1 consist of 8 inputs with 'State' as control bit. At each posedge, the 'State' will change the output.
//The inputs ofthe Mux_2 were the msg_i input. In each state, One Bit from msg_i is given as input.
multiplexer mux_2(a,b,c,d,e,f,g,h,S,32'd1,xor_i2);

//The output of the two Mux's were given to inputs for XOR-Gate.
//The Output is the Addr for the RAM. 
xor_gate xor_gate1(xor_i1,xor_i2,addr);
 
//The Asynchronous read RAM is used to get the 'Addr' as input and provide the Data in that address as Output.
//The Output is feedbacked the input of multiplexers through data_temp; The Data in RAM is initialized.
RAM MEM1(addr,data_temp,1'b1,1'b0,1'b1);

 
assign S = state;

 
//Assigning inputs to the Multiplexer2
 assign test = 6'd0;
 assign a = {test,msg_o[0]};
 assign b = {test,msg_o[1]};
 assign c = {test,msg_o[2]};
 assign d = {test,msg_o[3]};
 assign e = {test,msg_o[4]};
 assign f = {test,msg_o[5]};
 assign g = {test,msg_o[6]};
 assign h = {test,msg_o[7]};

//Assigning States for  changing the Control_line of the Multiplexers
	always @(posedge clk_i or posedge reset_i)
	begin
		if (reset_i) 
			state <= 3'b000;					
		else  
			state <= state + 3'b001;
	end
	
//Assigning the value of data_temp at 'State' = 8, gives the value of Hash output.
assign hash = (state==3'd7) ? data_temp : 8'd0;

endmodule



