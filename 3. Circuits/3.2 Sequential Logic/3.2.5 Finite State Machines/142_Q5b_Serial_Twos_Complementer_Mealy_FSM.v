module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 0, B =1;
    reg state, next_state;
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        if(state == A) begin
            next_state = x?B:A;
            z = x;
        end
        else begin
            next_state = B;
            z = ~x;
        end
    end

endmodule

