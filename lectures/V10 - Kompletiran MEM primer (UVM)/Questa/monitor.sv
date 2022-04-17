
`define MON_IF vif.monitor_cb 


class device_monitor extends uvm_monitor;

  // virtualni Interfejs
  virtual device_interface vif;
  
  // analysis port za slanje transakcija scoreboardu
  uvm_analysis_port #(device_seq_item) item_collected_port;
  
  // polje koje cuva transakciju
  device_seq_item trans_collected;

  `uvm_component_utils(device_monitor)


  // konstruktor
  function new (string name, uvm_component parent);
    super.new(name, parent);
    trans_collected = new();
    item_collected_port = new("item_collected_port", this);
  endfunction : new


  // bild faza preuzima interfjes handle iz config_db
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual device_interface)::get(this, "", "vif", vif))
       `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  

  // run faza prati signale na interferjsu i kreira transakcije
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(`MON_IF);
      wait(vif.monitor_cb.write_en || vif.monitor_cb.read_en);
        trans_collected.address = vif.monitor_cb.address;
      if(vif.monitor_cb.write_en) begin
        trans_collected.write_en = vif.monitor_cb.write_en;
        trans_collected.data_wr = vif.monitor_cb.data_wr;
        trans_collected.read_en = 0;
        @(`MON_IF);
      end
      if(vif.monitor_cb.read_en) begin
        trans_collected.read_en = vif.monitor_cb.read_en;
        trans_collected.write_en = 0;
        @(`MON_IF);
        @(`MON_IF);
        trans_collected.data_rd = vif.monitor_cb.data_rd;
      end
	  item_collected_port.write(trans_collected);
      end 
  endtask : run_phase

endclass : device_monitor
