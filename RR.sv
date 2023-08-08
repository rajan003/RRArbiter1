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
 logic [NUM_PORTS-1:0]gnt_local;
 logic [NUM_PORTS-1:0]pos_r;
 logic [NUM_PORTS-1:0]pos;
// logic [$clog2(NUM_PORTS)-1:0]m;
//  logic [$clog2(NUM_PORTS)-1:0]p;
 // logic [NUM_PORTS-1:0]reg_in;
 always@(posedge clk, posedge reset)
    begin
      if(reset) begin 
	m <= '0;
	pos_r <= '0
	end
      else begin 
	//m <= p;
	m<= gnt_o;
	end
    end 
  
always_comb
begin 
always_comb
begin 
gnt_local=4'b0;
if(req_i>m ) begin   /////////If the Requested Clients value is Greater than the Last Granted value//////
   for( int n=pos_r+1; n<= NUM_PORTS-1; n++)
	begin 
          if(req_i[n]==1)// && p==2'b00)
            begin 
              gnt_o[n]=1'b1;
		break;
		//p=2'b01;
            end
          else begin 
		gnt_o[n] =1'b0;
		//p=2'b00;
               end
	end
  end
else if(req_i<=gnt_o ) begin  /////////If the Requested Clients value is less than or equal to  the Last Granted value//////
   for( int n=0; n<= pos; n++)
	begin 
          if(req_i[n]==1 && p==2'b00)
            begin 
              gnt_o[n-1]=1'b1;
            end
          else begin 
		gnt_o[n] =1'b0;
		//p=2'b00;
        end
	end
  end
else gnt_o= 4'b0;
end
end

assign gnt_o= gnt_local &  ~(gnt_local-1); //// this calculates the Right Most 1 bit
assign pos = $clog2(gnt_o)-1;
	
endmodule
