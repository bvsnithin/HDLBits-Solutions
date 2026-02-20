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
    output digging 
  ); 

    parameter WL=0, WR=1, FL=2, FR=3, DGL=4, DGR=5, SPLAT=6;

    reg [2:0] state, next_state;
    reg [6:0] count;

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= WL;
            count <= 0;
        end
        else if(state == FL || state == FR) begin
            count <= count + 1;
            state <= next_state;
        end
        else begin
            state <= next_state;
            count <= 0;
        end       
    end

    always @(*) begin
        case(state)
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
            FL : begin
                if(ground) begin
                    if(count > 19) next_state = SPLAT;
                    else next_state = WL;
                end
                else next_state = FL;
            end
            FR : begin
                if(ground) begin
                    if(count > 19) next_state = SPLAT;
                    else next_state = WR;
                end
                else next_state = FR;
            end
            DGL  : next_state = (ground) ? DGL : FL;
            DGR  : next_state = (ground) ? DGR : FR;
            SPLAT : next_state = SPLAT;
        endcase
    end

    assign walk_left = (state == WL);
    assign walk_right = (state == WR);
    assign aaah = ((state == FL) || (state == FR));
    assign digging = ((state == DGL) || (state == DGR));

endmodule
