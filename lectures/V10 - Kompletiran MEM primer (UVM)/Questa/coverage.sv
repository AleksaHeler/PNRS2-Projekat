


class coverage extends uvm_component;
   `uvm_component_utils(coverage)

   virtual device_interface vif;

   logic [3:0] address;

   covergroup mem_zones_cg;
        coverpoint address {
			bins adresa_niske_vr 	= {[0:7]};
			bins adresa_visoke_vr 	= {[8:15]};
        }
   endgroup


   function new (string name, uvm_component parent);
      super.new(name, parent);
      mem_zones_cg = new();
   endfunction : new

   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(virtual device_interface)::get(null, "*","vif", vif))
	$fatal("Failed to get interface!");
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      forever begin  : sampling_block
         @(negedge vif.clk);
		  if ( vif.write_en || vif.read_en) begin
		    address = vif.address;
            mem_zones_cg.sample();
`uvm_info(get_type_name(),$sformatf("COVERAGE/RUNPHASE/SAMPLING/NEGEDGE vif.clk %0h",vif.address),UVM_LOW)		 
          end
      end : sampling_block
   endtask : run_phase

endclass : coverage






