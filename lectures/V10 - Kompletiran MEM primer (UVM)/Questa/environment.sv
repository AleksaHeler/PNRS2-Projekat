
 import uvm_pkg::*;
 import my_package::*;

class device_model_env extends uvm_env;
  
  // deklaracija komponenti agenta, scoreboarda i coverage
  device_agent      dev_agnt;
  device_scoreboard dev_scb;
  coverage          dev_cov;
  
  `uvm_component_utils(device_model_env)
  
  // konstruktor 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new


  // kreiranje komponenti, build faza
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    dev_agnt = device_agent::type_id::create("dev_agnt", this);
    dev_scb  = device_scoreboard::type_id::create("dev_scb", this);
	dev_cov  = coverage::type_id::create ("dev_cov",this);
  endfunction : build_phase
  

  // povezivanje komponenti konekt faza
  function void connect_phase(uvm_phase phase);
    //dev_agnt.monitor.item_collected_port.connect(dev_scb.item_collected_import);
	dev_agnt.item_collected_port.connect(dev_scb.item_collected_import);
  endfunction : connect_phase

endclass : device_model_env