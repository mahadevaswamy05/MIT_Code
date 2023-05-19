//monitor
//
`include "uvm_macros.svh"
 import uvm_pkg::*;


class monitor extends uvm_monitor;
`uvm_component_utils(monitor) 
uvm_analysis_port #(transaction) send;
 
  function new(input string path = "monitor", uvm_component parent = null);
    super.new(path, parent);
    send = new("send", this);
  endfunction
 
  transaction tr;
  virtual fa_if aif;
 
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    tr = transaction::type_id::create("tr");
    
   if(!uvm_config_db #(virtual fa_if)::get(this,"","aif",aif)) 
   `uvm_fatal("MON","Unable to access uvm_config_db");
  endfunction
 
    virtual task run_phase(uvm_phase phase);
    forever begin
    #10;
    tr.a = aif.a;
    tr.b = aif.b;
    tr.c = aif.c;
    tr.sum = aif.sum;
      tr.carry = aif.carry;
      `uvm_info("MON", $sformatf("Data send to Scoreboard a : %0b , b : %0b, c : %0b and sum : %0b, carry :%0b", tr.a,tr.b,tr.c,tr.sum,tr.carry), UVM_NONE);
    send.write(tr);
    end
    endtask
endclass
 
