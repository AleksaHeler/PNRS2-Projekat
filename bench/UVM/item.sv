
//  Class: seq_item
//
class seq_item extends uvm_sequence_item;
    

    //  Group: Variables
    bit                    PSEL;
    bit                    PENABLE;
    bit [PADDR_SIZE  -1:0] PADDR;
    bit [PDATA_SIZE/8-1:0] PSTRB;
    bit [PDATA_SIZE  -1:0] PWDATA;
    bit [PDATA_SIZE  -1:0] PRDATA;
    bit                    PWRITE;
    bit                    PREADY;
    bit                    PSLVERR;

    `uvm_object_utils(seq_item);

    //  Group: Constraints


    //  Group: Functions
    virtual function string convert2string();
        return $sformatf("Select=%0d, Enable=%0d, Address=%0d, Str=%0d, WData=%0d, RData=%0d, Write=%0d, Ready=%0d, SLVERR=%0d", 
        PSEL, PENABLE, PADDR, PSTRB, PWDATA, PRDATA, PWRITE, PREADY, PSLVERR);
    endfunction

    //  Constructor: new
    function new(string name = "seq_item");
        super.new(name);
    endfunction: new

    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    // extern function string convert2string();
    //  Function: do_print
    // extern function void do_print(uvm_printer printer);
    //  Function: do_record
    // extern function void do_record(uvm_recorder recorder);
    //  Function: do_pack
    // extern function void do_pack();
    //  Function: do_unpack
    // extern function void do_unpack();
    
endclass: seq_item