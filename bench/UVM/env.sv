//  Class: apb_environment
//

`include "agent.sv"
`include "scoreboard.sv"

class apb_environment extends uvm_env;
    `uvm_component_utils(apb_environment);

    //  Group: Components
    apb_agent agent_instance;
    apb_scoreboard scoreboard_instance;

    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "apb_environment", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agent_instance = apb_agent::type_id::create("agent_instance", this);
        scoreboard_instance = apb_scoreboard::type_id::create("scoreboard_instance", this);
    endfunction: build_phase
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // TODO: Implement this
        // agent_instance.monitor.item_collected_port.connect(mem_scb.item_collected_export);
    endfunction: connect_phase
    
endclass: apb_environment
