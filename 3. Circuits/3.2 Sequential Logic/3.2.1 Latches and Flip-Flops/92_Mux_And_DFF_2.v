module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire mux_1_out, mux_2_out;
    
    assign mux_1_out = E?w:Q;
    assign mux_2_out = L?R:mux_1_out;
    
    always @(posedge clk) begin
        Q <= mux_2_out;
    end

endmodule
