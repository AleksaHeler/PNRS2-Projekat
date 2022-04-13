//  Class: apb_scoreboard
//
class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard);

    //  Group: Components


    //  Group: Variables
    sequence_item packet_queue[$];

    uvm_analysis_imp#(sequence_item, apb_scoreboard) item_collected_export;

    logic [PDATA_SIZE-1:0]  mode_reg,
                            dir_reg,
                            out_reg,
                            in_reg,
                            tr_type_reg,
                            tr_lvl0_reg,
                            tr_lvl1_reg,
                            tr_stat_reg,
                            irq_ena_reg;

    //  Group: Functions

    //  Constructor: new
    function new(string name = "apb_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
    endfunction: build_phase

    virtual function void write(sequence_item packet);
        packet.print();
        packet_queue.push_back(packet);
    endfunction : write

    virtual task run_phase(uvm_phase phase);
        sequence_item packet;
        
        forever begin
            wait(packet_queue.size() > 0);
            packet = packet_queue.pop_front();

            if (packet.WRITE) begin
                //`uvm_info(get_type_name(),$sformatf("------ ::      WRITE DATA       :: ------"),UVM_NONE)
            end 
            else begin
                //`uvm_info(get_type_name(),$sformatf("------ ::      READ DATA       :: ------"),UVM_NONE)
                
            end
        end
      endtask : run_phase

endclass: apb_scoreboard
