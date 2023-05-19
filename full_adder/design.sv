`include "uvm_macros.svh"
 import uvm_pkg::*;

module fa(a,b,c,sum,carry);
input [0:3] a,b;
input c;
output reg [0:3] sum;
output reg carry;

assign sum = a ^ b ^ c;
assign carry = (a & b) |(a & c) | (b & c);

endmodule 
