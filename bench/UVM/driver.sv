// Class: driver
// The driver is responsible for driving the transactions to the DUT
// All it does is to get a transaction from the mailbox if it is available
// and drive it out into the DUT interface.
class driver extends uvm_driver #(Item);
    `uvm_component_utils(driver)

    // Constructor
    function new(string name="driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction // new

    // Virtual interface to DUT
    virtual device_if vif;

    // In build phase: get interface
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual device_if)::get(this, "", "apb_vif", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction // build_phase

    // Wait for item from sequencer
    // Once we have it, forward it to task 'drive_item'
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            Item m_item;
            `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_HIGH)
            seq_item_port.get_next_item(m_item);
            drive_item(m_item);
            seq_item_port.idem_done();
        end
    endtask //run_phase

    // Wait for clocking block
    virtual task drive_item(Item m_item);
        @(vif.driver_cb);
            `uvm_info("DRV", $sformatf("Inside drive_item function"), UVM_HIGH)
            // TODO: drive interface based on item
            // This is just passing one bit from item to intf
            //vif.cb.in <= m_item.in;
    endtask // drive_item
endclass