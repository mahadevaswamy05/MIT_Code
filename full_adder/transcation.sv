//transcation code
`include "uvm_macros.svh"
 import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  rand bit  a;
  rand bit  b;
  rand bit c;
  bit  sum;
  bit carry;
 
  function new(input string path = "transaction");
    super.new(path);
  endfunction
 
`uvm_object_utils_begin(transaction)
`uvm_field_int(a, UVM_DEFAULT)
`uvm_field_int(b, UVM_DEFAULT)
`uvm_field_int(c, UVM_DEFAULT)
`uvm_field_int(carry, UVM_DEFAULT)
`uvm_field_int(sum, UVM_DEFAULT)
`uvm_object_utils_end
 
endclass
 
  
