
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter WL = 0, WR=1, FL=2, FR=3, DGL=4, DGR=5;
    reg [2:0] state, next_state;
    
    // State register
    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= WL;
        else
            state <= next_state;
    end
    
    // Next-state logic
    always @(*) begin
        case (state)
        
            WL: begin
                if (!ground)
                    next_state = FL;
                else if (dig && ground)
                    next_state = DGL;
                else if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
            end
            
            WR: begin
                if (!ground)
                    next_state = FR;
                else if (dig && ground)
                    next_state = DGR;
                else if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            end
            
            FL: begin
                if (!ground)
                    next_state = FL;
                else
                    next_state = WL;
            end
            
            FR: begin
                if (!ground)
                    next_state = FR;
                else
                    next_state = WR;
            end
            
            DGL: begin
                if (!ground)
                    next_state = FL;
                else
                    next_state = DGL;
            end
            
            DGR: begin
                if (!ground)
                    next_state = FR;
                else
                    next_state = DGR;
            end
            
            default: next_state = WL;
        endcase
    end
    
    assign walk_left  = (state == WL);
    assign walk_right = (state == WR);
    assign aaah       = (state == FL) || (state == FR);
    assign digging    = (state == DGL) || (state == DGR);

endmodule
