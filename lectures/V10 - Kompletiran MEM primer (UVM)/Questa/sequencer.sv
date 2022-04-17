

class device_sequencer extends uvm_sequencer#(device_seq_item);

  `uvm_component_utils(device_sequencer) 

  // konstruktor
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass