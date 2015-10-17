`timescale 1ns / 10ps

module divider #( parameter xWIDTH = 8,  // width of x
                  parameter yWIDTH = 4 ) // width of y
                ( input [xWIDTH-1:0] x,
                  input [yWIDTH-1:0] y,
                  output [xWIDTH-1:0] q,
                  output [yWIDTH:0] r );
						
   wire [yWIDTH:0] d [xWIDTH-1:0];
   wire [yWIDTH:0] b [xWIDTH-1:0];
	 
   generate
      genvar ii, jj;
	   for ( ii = 0; ii < xWIDTH; ii = ii + 1) begin: gen_ii
         for ( jj = 0; jj < yWIDTH + 1; jj = jj + 1) begin: gen_jj

            csm csm( .a  ( jj < 1 ? x[xWIDTH-1-ii] : ii > 0 ? d[ii-1][jj-1] : 1'b0 ),
                     .b  ( jj < yWIDTH ? y[jj] : 1'b0 ),
                     .bi ( jj > 0 ? b[ii][jj-1] : 1'b0 ),
                     .os ( b[ii][yWIDTH] ),
                     .d  ( d[ii][jj] ),
                     .bo ( b[ii][jj] ) );
         end
       end
    
      for ( ii = 0; ii < xWIDTH; ii = ii + 1) begin: gen_p
		     assign q[xWIDTH-1-ii] = ~b[ii][yWIDTH];
	   end
		 
      for ( jj = 0; jj <= yWIDTH; jj = jj + 1) begin: gen_r
		     assign r[jj] = d[xWIDTH-1][jj];
	   end
   endgenerate
endmodule
