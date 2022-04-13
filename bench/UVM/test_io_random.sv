class test_io_random extends base_test;

    `uvm_component_utils(test_io_random)
    
    // Our sequence 
    apb_sequence_io_random seq;
  
    // Constructor
    function new(string name = "test_io_random",uvm_component parent=null);
      super.new(name,parent);
    endfunction : new
  
    // Build phase
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
  
      // Instantiate our sequence
      seq = apb_sequence_io_random::type_id::create("seq_io_random");
    endfunction : build_phase
    
    // Run phase: starts sequence
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq.start(env.agent_instance.sequencer);
        phase.drop_objection(this);
        
        // Set a drain-time for the environment if desired
        phase.phase_done.set_drain_time(this, 50);
    endtask : run_phase
    
  endclass : test_io_random