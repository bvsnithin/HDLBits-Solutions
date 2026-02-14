module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
	
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end
        else begin
            q[0] <= q[1];  // Because q[0] = q[-1] ^ q[1] and q[-1] = 0
            q[511] <= q[510];
            
            for(int i = 1; i<511; i = i + 1) begin
                q[i] <= q[i-1] ^ q[i+1];
            end

			/* q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0}; */ //This can also be used instead of a for loop. 

        end
    end
    
endmodule

