//  Class: apb_sequence
//
class apb_sequence extends uvm_sequence#(sequence_item);
    `uvm_object_utils(apb_sequence);

    //  Group: Variables


    //  Group: Constraints


    //  Group: Functions

    //  Constructor: new
    function new(string name = "apb_sequence");
        super.new(name);
    endfunction: new

    `uvm_declare_p_sequencer(apb_sequencer)

    virtual task body();
        `uvm_do_with(req, {req.WRITE==0; req.ADDR==MODE;})
        `uvm_do_with(req, {req.WRITE==0; req.ADDR==DIRECTION;})
        `uvm_do_with(req, {req.WRITE==0; req.ADDR==OUTPUT;})

        for (int d   =0; d    <= 10; d++   ) begin
        `uvm_do_with(req, {req.WRITE==1; req.ADDR==MODE; req.DATA=='b0;})
        `uvm_do_with(req, {req.WRITE==1; req.ADDR==DIRECTION; req.DATA=='b0;})
        `uvm_do_with(req, {req.WRITE==1; req.ADDR==OUTPUT; req.DATA==d;})
        `uvm_do_with(req, {req.WRITE==0; req.ADDR==INPUT;})
        end

    endtask

    //  Task: pre_start
    //  This task is a user-definable callback that is called before the optional 
    //  execution of <pre_body>.
    // extern virtual task pre_start();

    //  Task: pre_body
    //  This task is a user-definable callback that is called before the execution 
    //  of <body> ~only~ when the sequence is started with <start>.
    //  If <start> is called with ~call_pre_post~ set to 0, ~pre_body~ is not called.
    // extern virtual task pre_body();

    //  Task: pre_do
    //  This task is a user-definable callback task that is called ~on the parent 
    //  sequence~, if any. The sequence has issued a wait_for_grant() call and after
    //  the sequencer has selected this sequence, and before the item is randomized.
    //
    //  Although pre_do is a task, consuming simulation cycles may result in unexpected
    //  behavior on the driver.
    // extern virtual task pre_do(bit is_item);

    //  Function: mid_do
    //  This function is a user-definable callback function that is called after the 
    //  sequence item has been randomized, and just before the item is sent to the 
    //  driver.
    // extern virtual function void mid_do(uvm_sequence_item this_item);

    //  Task: body
    //  This is the user-defined task where the main sequence code resides.
    // extern virtual task body();

    //  Function: post_do
    //  This function is a user-definable callback function that is called after the 
    //  driver has indicated that it has completed the item, using either this 
    //  item_done or put methods. 
    // extern virtual function void post_do(uvm_sequence_item this_item);

    //  Task: post_body
    //  This task is a user-definable callback task that is called after the execution 
    //  of <body> ~only~ when the sequence is started with <start>.
    //  If <start> is called with ~call_pre_post~ set to 0, ~post_body~ is not called.
    // extern virtual task post_body();

    //  Task: post_start
    //  This task is a user-definable callback that is called after the optional 
    //  execution of <post_body>.
    // extern virtual task post_start();
    
endclass: apb_sequence