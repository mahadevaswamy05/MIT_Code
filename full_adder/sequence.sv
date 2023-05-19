`include "uvm_macros.svh"
 import uvm_pkg::*;

class generator extends uvm_sequence #(transaction);
`uvm_object_utils(generator)
 
transaction tr;
 
  function new(input string path = "generator");
    super.new(path);
  endfunction
 
 
virtual task body();
  tr = transaction::type_id::create("tr");
  repeat(5) 
    begin
    start_item(tr);
    tr.randomize();
      `uvm_info("GEN",$sformatf("Data send to Driver a :%0b , b :%0b , cin=%0b ",tr.a,tr.b,tr.c), UVM_NONE);
    finish_item(tr);
    end
endtask
 
endclass
