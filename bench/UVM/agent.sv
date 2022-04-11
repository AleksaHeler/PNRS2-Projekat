//  Class: agent
//
class agent extends uvm_agent;
    `uvm_component_utils(agent);

    //  Group: Configuration Object(s)

    //  Var: config_obj
    config_obj_t config_obj;


    //  Group: Components


    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: agent
