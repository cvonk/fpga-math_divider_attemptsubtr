`timescale 1ns / 1ps

module divider_test;

   parameter xWIDTH = 8;
	parameter yWIDTH = 4;
	
	reg [xWIDTH:0] x;  // extra bit for the loop counter
	reg [yWIDTH:0] y;  // extra bit for the loop counter
	wire [xWIDTH-1:0] q;
	wire [yWIDTH:0] r;

	divider uut ( .x( x[xWIDTH-1:0] ), 
                 .y( y[yWIDTH-1:0] ), 
    		        .q( q ), 
		           .r( r ) );

	initial begin
   #100; // wait 100 ns for global reset to finish

   for (x = 0; x < 2**xWIDTH; x = x + 1)
      for (y = 1; y < 2**yWIDTH; y = y + 1)
			   #100 if ( x / y != q || x % y != r )
                $display("%d / %d != %d r%d", x, y, q, r );	 
		$display("EOT");
	end
endmodule


