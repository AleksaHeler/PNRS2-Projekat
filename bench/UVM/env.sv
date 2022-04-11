//  Class: env
//
class env extends uvm_env;
    `uvm_component_utils(env);

    //  Group: Configuration Object(s)

    //  Var: config_obj
    config_obj_t config_obj;


    //  Group: Components


    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: env
