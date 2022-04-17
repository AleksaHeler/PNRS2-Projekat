
 import uvm_pkg::*;
 import my_package::*;
 
 `include "uvm_macros.svh"


class deterministic_all_wr_rd_test extends device_model_base_test;

  `uvm_component_utils(deterministic_all_wr_rd_test)
  
  // instanca sekvence 
  deterministic_all_wr_rd_sequence seq;

  // konstruktor
  function new(string name = "deterministic_all_wr_rd_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  // bild faza
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // kreiranje sekvence
    seq = deterministic_all_wr_rd_sequence::type_id::create("seq");
  endfunction : build_phase
  

  // run faza pokrece test
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    seq.start(env.dev_agnt.sequencer);
    phase.drop_objection(this);
    
    //set a drain-time for the environment if desired
    phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
  
endclass : deterministic_all_wr_rd_test