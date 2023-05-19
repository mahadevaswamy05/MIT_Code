//driver_code 
`include "uvm_macros.svh"
 import uvm_pkg::*;


class driver extends uvm_driver #(transaction);
`uvm_component_utils(driver)
 
    function new(input string path = "driver", uvm_component parent = null);
      super.new(path, parent);
     endfunction
 
transaction tc;
virtual fa_if aif;
  
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tc = transaction::type_id::create("tc");
      if(!uvm_config_db #(virtual fa_if)::get(this,"","aif",aif)) 
      `uvm_fatal("DRV","Unable to access uvm_config_db");
    endfunction
 
    virtual task run_phase(uvm_phase phase);
    forever begin
      
    seq_item_port.get_next_item(tc);
    aif.a <= tc.a;
    aif.b <= tc.b;
    aif.c <= tc.c;
    `uvm_info("DRV", $sformatf("Trigger DUT a: %0b ,b =  %0b, c : %0b",tc.a, tc.b,tc.c), UVM_NONE); 
    seq_item_port.item_done();
    #10;  
      
    end
    endtask
endclass
 
