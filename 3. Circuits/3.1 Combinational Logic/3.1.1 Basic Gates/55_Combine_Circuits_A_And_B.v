module top_module (input x, input y, output z);
	wire z1,z2,z3,z4;
    assign z1 = (x ^ y) & x;
    assign z2 = ~(x ^ y);
    assign z3 = z1;
    assign z4 = z2;
    
    assign z = ((z1|z2)^(z3&z4));
    
endmodule
