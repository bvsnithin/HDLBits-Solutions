module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    /* assign g[1] = r[1];
    
    always @(*) begin
        for(int i = 2;i<=3;i++) begin
            g[i] = r[i] & ~(|r[i-1:0]);
        end
    end
    
    */
    
    parameter A = 0, B = 1, C = 2, D = 3;
    reg [1:0] state, next_state;
    always @(posedge clk) begin
        if(!resetn) begin
            state <= A;
        end
        else state <= next_state;
    end
    
    always @(*) begin
        next_state = state;
        case(state)
        	A: begin
                if(r==3'b000) next_state = A;
                else if(r[1]) next_state = B;
                else if(~r[1] & r[2]) next_state = C;
                else if(~r[1] & ~r[2] & r[3]) next_state = D;
            end
            B: begin
                if(~r[1]) next_state = A;
                else if(r[1]) next_state = B;
            end
            C: begin
                if(~r[2]) next_state = A;
                else if(r[2]) next_state = C;
            end
            D: begin
                if(~r[3]) next_state = A;
                else if(r[3]) next_state = D;
            end
        endcase
    end
    
    assign g[1] = state == B;
    assign g[2] = state == C;
    assign g[3] = state == D;

endmodule

