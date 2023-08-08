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
  logic [$clog2(NUM_PORTS)-1:0]m;
  logic [$clog2(NUM_PORTS)-1:0]p;

  int n; ///
  always@(posedge clk, posedge reset)
    begin
      if(reset) m <= '0;
      else m <= p;  /////// Pointer to locate the bit which was granted access last time..
    end 
  
 always_comb
begin 
gnt_local=4'b0;
if(req_i>gnt_o ) begin
 for( int n=m; n<= NUM_PORTS-1; n++)
	begin 
          if(req_i[n]==1)// && p==2'b00)
            begin 
              gnt_o[n]=1'b1;
            end
          else begin 
		gnt_o[n] =1'b0;
		//p=2'b00;
               end
	end
end
else if(req_i<=gnt_o ) begin 
//p=2'b00;
 for( int n=0; n<= m; n++)
	begin 
          if(req_i[n]==1 && p==2'b00)
            begin 
              gnt_o[n-1]=1'b1;
            end
          else begin 
		gnt_o[n] =1'b0;
        end
	end
end
else gnt_o= 4'b0;
end
///// Logic o find the Right Most bit in Sequence
	assign gnt_o= gnt_local & ~(gnt_local-1); //// This will find the RIght Most 1 Bit.
	
endmodule
