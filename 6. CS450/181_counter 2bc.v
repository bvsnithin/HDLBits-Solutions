module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    
    parameter SNT = 0, WNT = 1, WT = 2, ST = 3;
    
    reg[1:0] next_state;
    
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state <= WNT;
        end
        else state <= next_state;
    end
    
    always @(*) begin
        next_state = state;
        case(state)
            SNT: begin
                if(train_valid) begin
                    next_state = train_taken?WNT:SNT;
                end
                else next_state = state;
            end
            WNT: begin
                if(train_valid) begin
                    next_state = train_taken?WT:SNT;
                end
                else next_state = state;
            end
            WT: begin
                if(train_valid) begin
                    next_state = train_taken?ST:WNT;
                end
                else next_state = state;
            end
            ST: begin
                if(train_valid) begin
                    next_state = train_taken?ST:WT;
                end
                else next_state = state;
            end
        endcase
    end

endmodule
