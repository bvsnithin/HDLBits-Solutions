module top_module (input a, input b, input c, output out);//
	
    wire temp_out;
    andgate inst1 ( temp_out, a, b, c, 1'b1, 1'b1);
    assign out = ~temp_out;

endmodule
