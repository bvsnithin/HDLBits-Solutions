module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always @(posedge clk) begin
        if(reset) q <= 0;
        else if(slowena) begin
            if(q == 9) begin
                q <= 0;
            end else begin
                q <= q + 4'b0001;
            end
        end
        else begin
            q <= q;
        end
    end

endmodule
