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
        p=m;  ////Putting default to m 
        gnt_o=4'b0; /// putting default to 0 
      for(int n=1; n<= NUM_PORTS; n++)
        begin 
          if(req_i[n-1]==1 && ( n >= m && m==p))  /////////taking care of 1 grant per clock cycle
            begin 
              gnt_o[n]=1'b1;
              p=n;
            end
          else gnt_o[n] =1'b0;
        end
    end
  
endmodule
