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
  always@(posedge clk, posedge reset)
    begin
      if(reset) m <= '0;
      else m <= n;
    end 
  
  always_comb
    begin 
      for(int n=0; n<= NUM_PORTS; n++)
        begin 
          if(req_i[n]==1 && ( n==0 || n > m))
            begin 
              gnt_o[n]=1'b1;
            end
          else gnt_o[n] =1'b0;
        end
    end
  
endmodule
