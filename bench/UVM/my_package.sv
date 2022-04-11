package my_package;
    import uvm_pkg::*;
 `include "uvm_macros.svh"

parameter PADDR_SIZE = 4;
parameter PDATA_SIZE        = 8;
 
//  `include "agent.sv"
 `include "item.sv"
//  `include "sequence.sv"
 `include "driver.sv"
//  `include "monitor.sv"
//  `include "scoreboard.sv"
//  `include "env.sv"
//  `include "base_test.sv"
 
 endpackage : my_package
   