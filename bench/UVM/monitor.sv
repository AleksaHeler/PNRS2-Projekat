//  Class: monitor
//
class monitor extends uvm_monitor;
    `uvm_component_utils(monitor);

    //  Group: Configuration Object(s)

    //  Var: config_obj
    config_obj_t config_obj;


    //  Group: Components


    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: monitor
