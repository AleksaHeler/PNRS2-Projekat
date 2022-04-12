//  Class: apb_agent
//

`include "item.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"

class apb_agent extends uvm_agent;
    `uvm_component_utils(apb_agent);

    //  Group: Components
    apb_driver driver;
    apb_sequencer sequencer;
    apb_monitor monitor;

    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "apb_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: apb_agent
