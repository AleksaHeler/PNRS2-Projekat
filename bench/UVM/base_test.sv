//  Class: base_test
//

`include "env.sv"

class base_test extends uvm_test;
    `uvm_component_utils(base_test);

    //  Group: Components
    apb_environment env;

    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: base_test
