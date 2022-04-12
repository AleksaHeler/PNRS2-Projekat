// Class: apb_monitor
// The monitor has a virtual interface handle with which
// it can monitor the events happening on the interface.
// It sees ne transactions and then captures information
// into a packet and sends it to the scoreboard
// using another mailbox.

`define MON_IF vif.MONITOR.monitor_cb

class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor);

    sequence_item item;

    //  Constructor
    function new(string name = "apb_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Monitor analysis port
    uvm_analysis_port #(sequence_item) mon_analysis_port;
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
            // Wait until PSEL is 1
            wait(vif.monitor_cb.PSEL);
            
            // Create empty sequence item
            item = sequence_item::type_id::create("item");

            // Populate sequence item with APB bus data
            item.WRITE = vif.monitor_cb.PWRITE;
            item.ADDR = vif.monitor_cb.PADDR;
            item.STRB = vif.monitor_cb.PSTRB;

            // Wait until peripheral is ready
            wait(vif.monitor_cb.PREADY);
            
            // Populate sequence item with GPIO data
            item.DATA = vif.monitor_cb.PWDATA;
            item.gpio_o = vif.monitor_cb.gpio_o;
            item.gpio_i = vif.monitor_cb.gpio_i;
            item.gpio_oe = vif.monitor_cb.gpio_oe;

            // wait until psel is 0
            wait(!vif.monitor_cb.PSEL);

            // TODO: add print here for debugging
        end
    endtask
    
endclass: apb_monitor
