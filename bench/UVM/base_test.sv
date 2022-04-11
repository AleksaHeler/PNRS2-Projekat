//  Class: base_test
//
class base_test extends uvm_test;
    `uvm_component_utils(base_test);

    //  Group: Configuration Object(s)

    //  Var: config_obj
    config_obj_t config_obj;


    //  Group: Components


    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: base_test
