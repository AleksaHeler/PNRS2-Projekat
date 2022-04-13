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
        if(!uvm_config_db#(virtual device_if)::get(this, "", "vif", vif))
            `uvm_fatal("DRV", "Could not get vif")
    endfunction // build_phase

    // In run phase:
    // Wait for item from sequencer
    // Once we have it, forward it to task 'drive_item'
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        #100;
        @(vif.driver_cb);
        forever begin
            sequence_item m_item;
            seq_item_port.get_next_item(m_item);
            drive_item(m_item);
            seq_item_port.item_done();
        end
    endtask //run_phase

    // Convert sequence item to signals on interface 
    // Wait for clocking block
    virtual task drive_item(sequence_item m_item);
        // @(vif.driver_cb);
        // TODO: check if seq item is read or write and call that funciton
        if (m_item.GPIO) vif.driver_cb.gpio_i <= m_item.gpio_i;
        else begin
            if(m_item.WRITE)
                write(m_item);
            else
                read(m_item);
        end
    endtask // drive_item

    // TODO: description
    virtual task write(sequence_item m_item);
        // Put settings on bus
        vif.driver_cb.PSEL <= 1'b1;
        vif.driver_cb.PADDR <= m_item.ADDR;
        vif.driver_cb.PSTRB <= m_item.STRB;
        vif.driver_cb.PWDATA <= m_item.DATA;
        vif.driver_cb.PWRITE <= 1'b1;
        @(vif.driver_cb);

        // Enable peripheral one clk cycle later 
        vif.driver_cb.PENABLE <= 1'b1;
        @(vif.driver_cb);

        // Wait until attached peripheral is done with transfer
        // @(vif.driver_cb);

        // Release bus lines
        vif.driver_cb.PSEL <= 1'b0;
        vif.driver_cb.PADDR <= {PADDR_SIZE{1'bx}};
        vif.driver_cb.PSTRB <= {PDATA_SIZE/8{1'bx}};
        vif.driver_cb.PWDATA <= {PDATA_SIZE{1'bx}};
        vif.driver_cb.PWRITE <= 1'bx;
        vif.driver_cb.PENABLE <= 1'b0;
    endtask // write

    virtual task read(sequence_item m_item);
        // Put settings on bus
        vif.driver_cb.PSEL <= 1'b1;
        vif.driver_cb.PADDR <= m_item.ADDR;
        vif.driver_cb.PSTRB <= {PDATA_SIZE/8{1'bx}};
        vif.driver_cb.PWDATA <= {PDATA_SIZE{1'bx}};
        vif.driver_cb.PWRITE <= 1'b0;
        @(vif.driver_cb);

        // Enable peripheral one clk cycle later 
        vif.driver_cb.PENABLE <= 1'b1;
        @(vif.driver_cb);

        // Wait until attached peripheral is done with transfer
        // @(vif.driver_cb);
        
        // Here the monitor will read data from PRDATA on interface

        // Release bus lines
        vif.driver_cb.PSEL <= 1'b0;
        vif.driver_cb.PADDR <= {PADDR_SIZE{1'bx}};
        vif.driver_cb.PWRITE <= 1'bx;
        vif.driver_cb.PENABLE <= 1'b0;
    endtask // read
endclass