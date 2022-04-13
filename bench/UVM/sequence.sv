class apb_sequence_reset_register_values extends uvm_sequence#(sequence_item);
    `uvm_object_utils(apb_sequence_reset_register_values);

    //  Constructor: new
    function new(string name = "apb_sequence_reset_register_values");
        super.new(name);
    endfunction: new

    `uvm_declare_p_sequencer(apb_sequencer)

    virtual task body();
        // Read registers with addr: 0, 1, 2 (mode, direction, output)
        `uvm_do_with(req, {req.WRITE==0; req.ADDR==MODE;})
        `uvm_do_with(req, {req.WRITE==0; req.ADDR==DIRECTION;})
        `uvm_do_with(req, {req.WRITE==0; req.ADDR==OUTPUT;})
    endtask

endclass: apb_sequence_reset_register_values

class apb_sequence_io_basic extends uvm_sequence#(sequence_item);
    `uvm_object_utils(apb_sequence_io_basic);

    //  Constructor: new
    function new(string name = "apb_sequence_io_basic");
        super.new(name);
    endfunction: new

    `uvm_declare_p_sequencer(apb_sequencer)

    virtual task body();
        // Write to registers mode, direction, output
        // Read data from input register
        for (int d   =0; d    < 1<<PDATA_SIZE; d++   ) begin
            `uvm_do_with(req, {req.GPIO==1;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==1; req.ADDR==MODE; req.DATA=='b0;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==1; req.ADDR==DIRECTION; req.DATA=='b0;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==1; req.ADDR==OUTPUT; req.DATA==d;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==0; req.ADDR==INPUT;})
        end
    endtask

endclass: apb_sequence_io_basic


class apb_sequence_io_random extends uvm_sequence#(sequence_item);
    `uvm_object_utils(apb_sequence_io_random);

    //  Constructor: new
    function new(string name = "apb_sequence_io_random");
        super.new(name);
    endfunction: new

    `uvm_declare_p_sequencer(apb_sequencer)

    virtual task body();
        // Write to registers mode, direction, output
        // Read data from input register
        for (int d   =0; d    <= 1000; d++   ) begin
            `uvm_do_with(req, {req.GPIO==1;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==1; req.ADDR==MODE;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==1; req.ADDR==DIRECTION;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==1; req.ADDR==OUTPUT;})
            `uvm_do_with(req, {req.GPIO==0; req.WRITE==0; req.ADDR==INPUT;})
        end
    endtask

endclass: apb_sequence_io_random