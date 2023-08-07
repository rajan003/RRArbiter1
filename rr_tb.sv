// Code your testbench here
// or browse Examples
module day15_tb ();
  
  parameter NUM_PORTS = 4;

  logic         clk;
  logic         reset;

  logic [NUM_PORTS-1:0]   req_i;
  logic [NUM_PORTS-1:0]   gnt_o;
  logic [NUM_PORTS-1:0]   gnt_exp;  
  logic [NUM_PORTS-1:0]   req;
  logic 				  mismatch;

  // Instatiate the module
  // Golden module
  //day15 #(NUM_PORTS) DAY15 (.*, .gnt_o(gnt_exp));
  rr_arbiter #(NUM_PORTS) RR (.*);  

  // Clock
  always begin
    clk = 1'b1;
    #5;
    clk = 1'b0;
    #5;
  end

  // Stimulus
  initial begin
    reset <= 1'b1;
    req_i <= {NUM_PORTS{1'b0}};
    @(posedge clk);
    reset <= 1'b0;
    @(posedge clk);
    @(posedge clk);
    for (int i =0; i<32; i++) begin
      req_i <= $urandom_range(0, {NUM_PORTS{1'b1}});
      @(posedge clk);
    end
    req = NUM_PORTS'(1'b1);
    for (int i =0; i<NUM_PORTS; i++) begin
      req_i <= req;
      req = (req<<1) | req;
      @(posedge clk);
    end
    repeat(10) @(posedge clk);
    $finish();
  end
  
  //assign mismatch = |(gnt_o ^ gnt_exp);

  // VCD dump
  initial begin
    $dumpfile("day15.vcd");
    $dumpvars(0, day15_tb);
  end

endmodule
