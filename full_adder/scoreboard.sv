// scoreborad code
`include "uvm_macros.svh"
 import uvm_pkg::*;

class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
 
uvm_analysis_imp #(transaction,scoreboard) recv;
 
transaction tr;
 
  function new(input string path = "scoreboard", uvm_component parent = null);
    super.new(path, parent);
    recv = new("recv", this);
  endfunction
 
  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    tr = transaction::type_id::create("tr");
  endfunction
 
  virtual function void write(input transaction t);

  tr = t;
    `uvm_info("SCO",$sformatf("Data rcvd from Monitor a: %0b , b : %0b c: %0b and sum : %0b, carry
    : %0b",tr.a,tr.b,tr.c,tr.sum,tr.carry), UVM_NONE);
if((tr.sum == ((tr.a) ^ (tr.b) ^ (tr.c))) && 
   (tr.carry == ((tr.a & tr.b) | (tr.b & tr.c) | (tr.c & tr.a))))
       `uvm_info("SCO","Test Passed", UVM_NONE)
   else
       `uvm_info("SCO","Test Failed", UVM_NONE);
   endfunction  
endclass
