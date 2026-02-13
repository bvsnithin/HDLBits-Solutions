module top_module ( );
    
    logic clk;
    
    dut DUT(clk);
    
    initial clk = 0;
    always #5 clk = ~clk;
    
endmodule
