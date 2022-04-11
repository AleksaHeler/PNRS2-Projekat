// Class: monitor
// The monitor has a virtual interface handle with which
// it can monitor the events happening on the interface.
// It sees ne transactions and then captures information
// into a packet and sends it to the scoreboard
// using another mailbox.
class monitor extends uvm_monitor;
    `uvm_component_utils(monitor);

    //  Constructor
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Monitor analysis port
    uvm_analysis_port #(Item) mon_analysis_port;
    // Virtual interface to DUT
    virtual device_if vif;

    // In build phase: get interface, create monitor analysis port
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual device_if)::get(this, "", "apb_vif", vif))
            `uvm_fatal("MON", "Could not get vif")
        mon_analysis_port = new ("mon_analysis_port", this);
    endfunction

    // This task monitors the interface for a complete
    // transaction and writes into analysis port when complete
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            @(vif.monitor_cb);
                `uvm_info("DRV", $sformatf("Inside run_phase function"), UVM_HIGH)
                // TODO: read right data
                //if(vif.rstn) begin
                    //Item item = Item::type_id::create("item");
                    //item.in = vif.in;
                    //item.out = vif.monitor_cb.out;
                    //mon_analysis_port.write(item);
                    //`uvm_info("MON", $sformatf("Saw items %s", item.convert2str()), UVM_HIGH)
                //end
        end
    endtask


    
endclass: monitor
