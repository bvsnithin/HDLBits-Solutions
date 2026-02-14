module top_module();
	logic clk;
    logic in;
    logic [2:0] s;
    logic out;
    
    q7 Q7(.*);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        in = 0;
        s = 3'd2;
        
        @(negedge clk);
        s = 3'd6;
        
        @(negedge clk);
        s = 3'd2;
        in = 1'b1;
        
        @(negedge clk);
        s = 3'd7;
        in = 0;
        
        @(negedge clk);
        in =1;
        s = 3'd0;
        
        repeat(3) @(negedge clk);
        in = 0;
    end
endmodule

