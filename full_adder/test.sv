`include "uvm_macros.svh"
 import uvm_pkg::*;


class test extends uvm_test;
`uvm_component_utils(test)
  
function new(input string inst = "TEST", uvm_component parent = null );
super.new(inst, parent);
endfunction
 
generator gen;
env e;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  gen = generator::type_id::create("gen");
  e = env::type_id::create("e",this);
endfunction
 
virtual task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   gen.start(e.a.seqr);
   #10;
   phase.drop_objection(this);
endtask
endclass
