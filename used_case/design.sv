module adder(
  input [3:0] a,
  input [3:0] b,
  output [4:0] y);

  assign y=a+b;

endmodule

interface adder_intf;

  logic [3:0] a;
  logic [3:0] b;
  logic [4:0] y;

endinterface
