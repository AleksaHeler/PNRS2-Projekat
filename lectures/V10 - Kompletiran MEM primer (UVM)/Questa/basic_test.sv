
 import uvm_pkg::*;
 import my_package::*;
 
 `include "uvm_macros.svh"
 
class device_model_base_test extends uvm_test;

  `uvm_component_utils(device_model_base_test)
  
  // deklaracija environmenta
  device_model_env env;


  // konstruktor
  function new(string name = "device_model_base_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  // build faza
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // kreiranje environmenta
    env = device_model_env::type_id::create("env", this);
  endfunction : build_phase
  

  // faza zavrsetka elaboracije
  virtual function void end_of_elaboration();
    //ispis topologije
    //print();
	uvm_top.print_topology();
  endfunction 

  // faza raportiranja
 /*function void report_phase(uvm_phase phase);
   uvm_report_server svr;
   super.report_phase(phase);
   
   svr = uvm_report_server::get_server();
   if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
     `uvm_info(get_type_name(), "***            TEST FAIL          ***", UVM_NONE)
    end
    else begin
      `uvm_info(get_type_name(), "***           TEST PASS           ***", UVM_NONE)
    end
  endfunction */

endclass : device_model_base_test
