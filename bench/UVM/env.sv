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

    
endclass: apb_environment
