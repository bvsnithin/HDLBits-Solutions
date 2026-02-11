module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    wire [3:0] q0, q1, q2;
    // Instantiate 3 BCD counters for ones, tens, and hundreds
	bcdcount counter0 (clk, reset, c_enable[0], q0); // Ones digit
	bcdcount counter1 (clk, reset, c_enable[1], q1); // Tens digit
	bcdcount counter2 (clk, reset, c_enable[2], q2); // Hundreds digit

	// Generate enable signals for each counter
	assign c_enable = {
    	(q1 == 4'd9) & (q0 == 4'd9), // Enable hundreds counter when tens=9 AND ones=9
    	q0 == 4'd9,                   // Enable tens counter when ones=9
    	1'b1                          // Ones counter always enabled
	};

	// Generate a pulse when the counter reaches 999
	assign OneHertz = (q2 == 4'd9) & (q1 == 4'd9) & (q0 == 4'd9);

    

endmodule
