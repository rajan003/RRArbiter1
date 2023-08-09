// Round robin arbiter

module rr_arbiter #(
  parameter NUM_PORTS = 4
)(
  input     logic        			clk,
  input     logic        			reset,

  input     logic[NUM_PORTS-1:0]   	req_i,
  output    logic[NUM_PORTS-1:0]  	gnt_o
);

  // Write your logic here...
  logic [NUM_PORTS-1:0]m;
	logic [NUM_PORTS-1:0]req_i_masked;  //// Masked Request with last Served Input bit
 logic [NUM_PORTS-1:0]gnt_local;
 logic [NUM_PORTS-1:0]pos_r;
 logic [NUM_PORTS-1:0]pos;

 always@(posedge clk, posedge reset)
    begin
      if(reset) begin 
	m <= '0;
	pos_r <= '0;
	end
      else begin 
	pos_r <= pos;
	m<= gnt_o;
	end
    end 
  
always_comb
begin 
gnt_local=4'b0;
if(req_i==m) gnt_local=m;
else if(req_i_masked>m ) begin   /////////If the Requested Clients(masked) value is Greater than the Last Granted value//////
   for( int n=pos_r; n<= NUM_PORTS-1; n++)
	begin 
	 if(req_i_masked[n]==1)
            begin 
              gnt_local[n]=1'b1;
            end
          else begin 
		gnt_local[n] =1'b0;
               end
	end
  end
  else if(req_i_masked<=gnt_o ) begin  /////////If the Requested Clients value is less than or equal to  the Last Granted value//////
   for( int n=0; n<= pos; n++)
	begin 
	if(req_i_masked[n]==1)
            begin 
              gnt_local[n-1]=1'b1;
            end
          else begin 
		gnt_local[n] =1'b0;
        end
	end
  end
else gnt_local= 4'b0;
end

assign  req_i_masked = req_i & ~m;
assign gnt_o= gnt_local &  ~(gnt_local-1); //// this calculates the Right Most 1 bit
assign pos = $clog2(gnt_o); ///// This will calculate the position of the Last Granted request in the array
	
endmodule
