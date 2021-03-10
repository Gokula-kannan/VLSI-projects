module ram_ph (
address     , // Address Input
data        , // Data bi-directional
cs          , // Chip Select
we          , // Write Enable/Read Enable
oe            // Output Enable
);          
parameter DATA_WIDTH = 8 ;


//--------------Input Ports----------------------- 
input [7:0] address ;
input cs;
input we;
input oe; 

//--------------Inout Ports----------------------- 
output [DATA_WIDTH-1:0] data;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0]   data_out ;
reg [DATA_WIDTH-1:0] mem [0:255];

//--------------Code Starts Here------------------ 

// Tri-State Buffer control 
// output : When we = 0, oe = 1, cs = 1
assign data = (cs && oe && !we) ? data_out : 8'bz; 

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
/* always @ (address or data or cs or we)
begin : MEM_WRITE
   if ( cs && we ) begin
       mem[address] = data;
   end
end */
  
  integer i;
   initial 
   begin  
        for(i=0;i<256;i=i+1)  
            mem[i] <= 8'd0 + i;  
   end  

// Memory Read Block 
// Read Operation : When we = 0, oe = 1, cs = 1
always @ (address or cs or we or oe)
begin : MEM_READ
    if (cs && !we && oe)  begin
         data_out = mem[address];
    end
	else
	    data_out = 8'd0;
end

endmodule // End of Module ram_sp_ar_aw