// Carry Skip Adder - 8 bits
module CSkipA8(output [7:0] sum, output cout, input [7:0] a, b);

  wire cout0, cout1, e;

  // Instantiate two 4-bit ripple carry adders
  RCA4 rca0(sum[3:0], cout0, a[3:0], b[3:0], 0);
  RCA4 rca1(sum[7:4], cout1, a[7:4], b[7:4], e);

  // Skip Logic for carry propagation
  SkipLogic skip0(e, a[3:0], b[3:0], 0, cout0);
  SkipLogic skip1(cout, a[7:4], b[7:4], e, cout1);

endmodule

// 4-bit Ripple Carry Adder (RCA4)
module RCA4(output [3:0] sum, output cout, input [3:0] a, b, input cin);
  wire c1, c2, c3;

  FullAdder fa0(sum[0], c1, a[0], b[0], cin);
  FullAdder fa1(sum[1], c2, a[1], b[1], c1);
  FullAdder fa2(sum[2], c3, a[2], b[2], c2);
  FullAdder fa3(sum[3], cout, a[3], b[3], c3);

endmodule

// Skip Logic module for 4-bit block
module SkipLogic(output skip_out, input [3:0] a, b, input cin, input cout);
  wire propagate;

  // Propagate if all bits in a and b match (a XOR b = 0 for each bit)
  assign propagate = (a[0] ~^ b[0]) & (a[1] ~^ b[1]) & (a[2] ~^ b[2]) & (a[3] ~^ b[3]);
  assign skip_out = propagate ? cin : cout;

endmodule

// Full Adder module
module FullAdder(output sum, output cout, input a, b, cin);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (cin & (a ^ b));
endmodule
