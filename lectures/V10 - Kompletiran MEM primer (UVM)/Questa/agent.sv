
class device_agent extends uvm_agent;

  // instanciranje komponenti
  device_driver    driver;
  device_sequencer sequencer;
  device_monitor   monitor;

  // analysis port za prosledjivanje transakcija 
  // od monitora ka scoreboardu
  uvm_analysis_port #(device_seq_item) item_collected_port;

  `uvm_component_utils(device_agent)
  

  // konstruktor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // bild_faza
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    monitor = device_monitor::type_id::create("monitor", this);

    // kreiranje drajvera i sekvencera samo ako je agent aktivan!
    if(get_is_active() == UVM_ACTIVE) begin
      driver    = device_driver::type_id::create("driver", this);
      sequencer = device_sequencer::type_id::create("sequencer", this);
    end
	
	// kreiranje analysis porta za prosledjivanje transakcija 
	item_collected_port = new("item_collected_port" , this );
	
  endfunction : build_phase
  
  
  // povezivanje drajvera i sekvencera u konekt fazi
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
	// povezivanje analysis porta sa monitora na agent
	monitor.item_collected_port.connect(item_collected_port);
  endfunction : connect_phase

endclass : device_agent