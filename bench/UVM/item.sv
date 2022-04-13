
//  Class: sequence_item
class sequence_item extends uvm_sequence_item;
    
    //  Group: Variables
    rand bit                    WRITE;
    rand bit GPIO;
    rand bit [PADDR_SIZE  -1:0] ADDR;
    bit [PDATA_SIZE/8-1:0] STRB;
    rand bit [PDATA_SIZE  -1:0] DATA;
    rand bit [PDATA_SIZE -1:0] gpio_i;
    bit [PDATA_SIZE -1:0] gpio_o, gpio_oe;

    `uvm_object_utils(sequence_item)

    //  Group: Constraints
    // TODO: add constraints

    //  Constructor: new
    function new(string name = "sequence_item");
        super.new(name);
        STRB = {PSTRB_SIZE{1'b1}};
    endfunction: new
    
endclass: sequence_item
