module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    
    
    always @(posedge clk) begin
        if(reset) begin
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 1'b0;
        end
        else if(ena) begin
            if(ss == 8'h59) begin
                
                ss <= 8'h00;
                
                if (mm == 8'h59) begin
                    
                    mm <= 8'h00;
                    
                    if (hh == 8'h11) begin
   						 hh <= 8'h12;
    					 pm <= ~pm;        // toggle at 11 -> 12
					end
					else if (hh == 8'h12) begin
    					hh <= 8'h01;      // 12 -> 1 (no toggle)
					end
					else begin
    					if (hh == 8'h09)
        					hh <= 8'h10;
    					else
        					hh <= hh + 8'h01;
					end

                end
                else begin
                    if (mm[3:0] == 4'd9) begin
                    	mm[3:0] <= 4'd0;
                    	mm[7:4] <= mm[7:4] + 4'd1;
                	end
                	else begin
                   		mm[3:0] <= mm[3:0] + 4'd1;
                	end
                end
            end
            else begin
                if (ss[3:0] == 4'd9) begin
                	ss[3:0] <= 4'd0;
                	ss[7:4] <= ss[7:4] + 4'd1;
            	end
            	else begin
                	ss[3:0] <= ss[3:0] + 4'd1;
            	end
            end
        end
    end

endmodule

