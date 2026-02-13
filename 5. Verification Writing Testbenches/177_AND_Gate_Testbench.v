module top_module();
	
    logic [1:0] in;
    logic out;
    
    andgate ANDGATE(.*);
    
    initial begin
        in[1] = 0;
        in[0] = 0;
        #10;
        in[0] = 1;
        #10;
        in[1] = 1;
        in[0] = 0;
        #10;
        in[0] = 1;
    end
    
endmodule
