module top_module ( input clk, input d, output q );
	wire dff_out1, dff_out2;
    
    my_dff inst_1(clk, d, dff_out1);
    my_dff inst_2(clk, dff_out1, dff_out2);
    my_dff inst_3(clk, dff_out2, q);
endmodule

