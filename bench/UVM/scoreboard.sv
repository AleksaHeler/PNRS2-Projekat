//  Class: scoreboard
//
class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard);

    //  Group: Configuration Object(s)

    //  Var: config_obj
    config_obj_t config_obj;


    //  Group: Components


    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: scoreboard
