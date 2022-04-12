// Class: apb_driver
// The driver is responsible for driving the transactions to the DUT
// All it does is to get a transaction from the mailbox if it is available
// and drive it out into the DUT interface.

`define DRIV_IF vif.DRIVER.driver_cb

class apb_driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(apb_driver)

    // Constructor
    function new(string name="apb_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction // new

    // Virtual interface to DUT
    virtual device_if vif;

    // In build phase: get interface from config
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual device_if)::get(this, "", "apb_vif", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction // build_phase

    // In run phase:
    // Wait for item from sequencer
    // Once we have it, forward it to task 'drive_item'
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            sequence_item m_item;
            `uvm_info("DRV", $sformatf("Wait for item from sequencer"), UVM_HIGH)
            seq_item_port.get_next_item(m_item);
            drive_item(m_item);
            seq_item_port.idem_done();
        end
    endtask //run_phase

    // Convert sequence item to signals on interface 
    // Wait for clocking block
    virtual task drive_item(sequence_item m_item);
        @(DRIV_IF);
        `uvm_info("DRV", $sformatf("Inside drive_item function"), UVM_HIGH)
        // TODO: check if seq item is read or write and call that funciton
        if(m_item.WRITE)
            write(m_item);
        else
            read(m_item);
    endtask // drive_item

    // TODO: description
    virtual task write(sequence_item m_item);
        `uvm_info("DRV", $sformatf("Inside write function"), UVM_HIGH)
        // Put settings on bus
        DRIV_IF.PSEL = 1'b1;
        DRIV_IF.PADDR = m_item.ADDR;
        DRIV_IF.PSTRB = m_item.STRB;
        DRIV_IF.PWDATA = m_item.DATA;
        DRIV_IF.PWRITE = 1'b1;
        @(DRIV_IF);

        // Enable peripheral one clk cycle later 
        DRIV_IF.PENABLE = 1'b1;
        @(DRIV_IF);

        // Wait until attached peripheral is done with transfer
        while(!DRIV_IF.PREADY) @(DRIV_IF);

        // Release bus lines
        DRIV_IF.PSEL = 1'b0;
        DRIV_IF.PADDR = {PADDR_SIZE{1'bx}};
        DRIV_IF.PSTRB = {PDATA_SIZE/8{1'bx}};
        DRIV_IF.PWDATA = {PDATA_SIZE{1'bx}};
        DRIV_IF.PWRITE = 1'bx;
        DRIV_IF.PENABLE = 1'b0;
    endtask // write

    virtual task read(sequence_item m_item);
        `uvm_info("DRV", $sformatf("Inside read function"), UVM_HIGH)
        // Put settings on bus
        DRIV_IF.PSEL = 1'b1;
        DRIV_IF.PADDR = m_item.ADDR;
        DRIV_IF.PSTRB = {PDATA_SIZE/8{1'bx}};
        DRIV_IF.PWDATA = {PDATA_SIZE{1'bx}};
        DRIV_IF.PWRITE = 1'b0;
        @(DRIV_IF);

        // Enable peripheral one clk cycle later 
        DRIV_IF.PENABLE = 1'b1;
        @(DRIV_IF);

        // Wait until attached peripheral is done with transfer
        while(!DRIV_IF.PREADY) @(DRIV_IF);
        
        // Here the monitor will read data from PRDATA on interface

        // Release bus lines
        DRIV_IF.PSEL = 1'b0;
        DRIV_IF.PADDR = {PADDR_SIZE{1'bx}};
        DRIV_IF.PWRITE = 1'bx;
        DRIV_IF.PENABLE = 1'b0;
    endtask // read
endclass