`timescale 1ns / 1ps

module csm( input a,      // x
            input b,      // y
            input bi,     // borrow in
				input os,     // output select
            output d,     // difference out
            output bo );  // borrow out

    wire d1 = a ^ b ^ bi;
	 assign d = (os & a) + (~os & d1);
	 assign bo = (~a & b) + (bi & (~(a ^ b)));
endmodule
