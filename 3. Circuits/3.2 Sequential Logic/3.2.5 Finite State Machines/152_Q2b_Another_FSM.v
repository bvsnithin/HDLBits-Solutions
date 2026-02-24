module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    typedef enum reg [3:0] {
        A,
        B,
        S0, S1, S2,
        G0, G1, G2, G3
    } state_t;
    
    state_t state, next_state;
    
    always @(posedge clk) begin
        if(!resetn) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A: next_state = resetn ? B:A;
            B: next_state = S0;
            S0: begin
                next_state = x?S1:S0;
            end
            S1: begin
                next_state = x?S1:S2;
            end
            S2: begin
            	next_state = x?G0:S0;
            end
            G0: begin
                next_state = y?G2:G1;
            end
            G1: begin
                next_state = y?G2:G3;
            end
            G2: next_state = G2;
            G3: next_state = G3;
        endcase
    end
    
    assign f = (state == B);
    assign g = (state == G1) | (state==G2) | (state == G0);

endmodule
