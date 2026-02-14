module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    always @(posedge clk) begin
        if(a==b) begin
            state <= a;
        end
        else begin
            state <= state;
        end
    end
    
    always @(*) begin
        if(a==b) begin
            q = state;
        end
        else begin
            q = ~state;
        end
    end

endmodule

