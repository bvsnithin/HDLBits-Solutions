module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter WL = 2'b00, WR = 2'b01, FL = 2'b10, FR = 2'b11;
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state <= WL;
        end
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            WL: begin
                if(!ground) begin
                    next_state = FL;
                end
                else begin
                    next_state = bump_left?WR:WL;
                end
                
            end
            WR: begin
                if(!ground) begin
                    next_state = FR;
                end
                else begin
                    next_state = bump_right?WL:WR;
                end
            end
            FL: begin
                next_state = ground?WL:FL;
            end
            FR: begin
                next_state = ground?WR:FR;
            end
        endcase
    end
    
    assign walk_left = state == WL;
    assign walk_right = state == WR;
    assign aaah = (state == FL) || (state ==FR);
    

endmodule
