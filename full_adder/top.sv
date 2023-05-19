`include "uvm_macros.svh"
 import uvm_pkg::*;


`include "design.sv"
 `include "interface.sv"
 `include "transcation.sv"
 `include "sequence.sv"
 `include "driver.sv"
 `include "monitor.sv"
 `include "agent.sv"
 `include "scoreboard.sv"
 `include "env.sv"
 `include "test.sv"

module adder_tb;



fa_if aif();

  fa dut(.a(aif.a), .b(aif.b), .c(aif.c), .sum(aif.sum), .carry(aif.carry));
  
initial begin  
  uvm_config_db #(virtual fa_if)::set(null, "uvm_test_top.e.a*", "aif", aif);
  run_test("test");
end
 
endmodule
