module top_module ();
	
    logic clk;
    logic reset;
    logic t;
    logic q;
    
    tff TFF(.*);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        reset = 0;
        t  = 0;
        
        @(posedge clk);
        reset = 1;
        t = 1;
        
        @(posedge clk);
        reset = 0;
        
        repeat(2) @(posedge clk);
        t = 0;
    end
    
    
    
endmodule
