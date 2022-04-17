import uvm_pkg::*;
`include "uvm_macros.svh"


`define DRIV_IF vif.driver_cb

class device_driver extends uvm_driver #(device_seq_item);

  
  // virtualni interfejs
    virtual device_interface vif;
  `uvm_component_utils(device_driver)
    
  
  // konstruktor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  
  // bild faza
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(virtual device_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase


  // run faza
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask : run_phase
  
  // drajva signale na interfejsu shodno vrednostima sa seq_item
  virtual task drive();
    `DRIV_IF.write_en <= 0;
    `DRIV_IF.read_en <= 0;
    @(`DRIV_IF);
    
    `DRIV_IF.address <= req.address;
    
    if(req.write_en) begin // pisanje
      `DRIV_IF.write_en <= req.write_en;
      `DRIV_IF.data_wr <= req.data_wr;
      @(`DRIV_IF);
    end
    else if(req.read_en) begin // citanje
      `DRIV_IF.read_en <= req.read_en;
      @(`DRIV_IF);
      `DRIV_IF.read_en <= 0;
      @(`DRIV_IF);
      req.data_rd = `DRIV_IF.data_rd;
    end
    
  endtask : drive
endclass : device_driver