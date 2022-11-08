`include "design.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

/*
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
 */
class driver extends uvm_driver;

  `uvm_component_utils(driver)

  virtual adder_intf aintf;

  function new(input string name="driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual adder_intf)::get(this,"","aintf",aintf))
      `uvm_error("Driver","Unable to Access Interface"); 
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    for(int i=0;i<4;i++)
    begin
      aintf.a<=$urandom;
      aintf.b<=$urandom;
      `uvm_info("driver",$sformatf("a:%0d",aintf.a),UVM_MEDIUM); 
      `uvm_info("driver",$sformatf("b:%0d",aintf.b),UVM_MEDIUM); 
      #5;
    end
    phase.drop_objection(this);
  endtask
 
endclass :driver 

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  driver d;
  function new(string name="agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
   
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d=driver::type_id::create("d",this); 
  endfunction
 
endclass

class environment extends uvm_env;

  `uvm_component_utils(environment)
  agent a;
  function new(input string name="environment",uvm_component parent = null);
       super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a=agent::type_id::create("a",this); 
  endfunction
 
endclass
    

class test extends uvm_test;

  `uvm_component_utils(test)

  environment env;
  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=environment::type_id::create("env",this); 
  endfunction
 
endclass
 
module tb;

  adder_intf aintf();

  adder dut(.a(aintf.a),.b(aintf.b),.y(aintf.y));
initial begin
  uvm_config_db#(virtual adder_intf)::set(null,"uvm_test_top.env.a.d","aintf",aintf);
  run_test("test");
end

endmodule 
