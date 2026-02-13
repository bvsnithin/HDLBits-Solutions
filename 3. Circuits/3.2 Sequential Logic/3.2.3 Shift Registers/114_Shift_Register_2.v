module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    
    MUXDFF ins3(KEY[0], KEY[3], SW[3], KEY[1], KEY[2], LEDR[3]);
    MUXDFF ins2(KEY[0], LEDR[3], SW[2], KEY[1], KEY[2], LEDR[2]);
    MUXDFF ins1(KEY[0], LEDR[2], SW[1], KEY[1], KEY[2], LEDR[1]);
    MUXDFF ins0(KEY[0], LEDR[1], SW[0], KEY[1], KEY[2], LEDR[0]);

endmodule

module MUXDFF (
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
