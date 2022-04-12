
//  Class: sequence_item
class sequence_item extends uvm_sequence_item;
    
    //  Group: Variables
    bit                    WRITE;
    bit [PADDR_SIZE  -1:0] ADDR;
    bit [PDATA_SIZE/8-1:0] STRB;
    rand bit [PDATA_SIZE  -1:0] DATA;
    bit [PDATA_SIZE -1:0] gpio_o, gpio_i, gpio_oe;

    `uvm_object_utils_begin(sequence_item)
        `uvm_field_int(WRITE,UVM_ALL_ON)
        `uvm_field_int(ADDR,UVM_ALL_ON)
        `uvm_field_int(STRB,UVM_ALL_ON)
        `uvm_field_int(DATA,UVM_ALL_ON)
    `uvm_object_utils_end

    //  Group: Constraints
    // TODO: add constraints

    //  Constructor: new
    function new(string name = "sequence_item");
        super.new(name);
    endfunction: new
    
endclass: sequence_item
