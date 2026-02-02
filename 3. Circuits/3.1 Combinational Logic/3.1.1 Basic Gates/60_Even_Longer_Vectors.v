module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    
    always @(*) begin
        out_both = 1'b0;
        out_any = 1'b0;
        out_different = 1'b0;
        for(int i = 98;i>=0;i--) begin
            out_both[i] = in[i+1]&in[i];
        end
        
        for(int i = 99;i>=1;i--) begin
            out_any[i] = in[i]|in[i-1];
        end
        
        for(int i = 0;i<=99;i++) begin
            if(i==99) begin
                out_different[i] = in[99]^in[0];
            end
            else begin
                out_different[i] = in[i]^in[i+1];
            end
        end
    end

endmodule
