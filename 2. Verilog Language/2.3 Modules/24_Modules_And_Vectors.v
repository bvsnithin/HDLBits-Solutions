module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] d_1;
    wire [7:0] d_2;
    wire [7:0] d_3;
    my_dff8 inst_1( clk, d, d_1 );
    my_dff8 inst_2( clk, d_1 , d_2 );
    my_dff8 inst_3( clk, d_2 , d_3 );
    
    always @(*) begin
        case(sel)
            2'b00: q = d;
            2'b01: q = d_1;
            2'b10: q = d_2;
            2'b11: q = d_3;
        endcase
            
    end
    

endmodule

