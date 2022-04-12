//  Class: apb_scoreboard
//
class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard);

    //  Group: Components


    //  Group: Variables
    sequence_item packet_queue[$];

    uvm_analysis_imp#(sequence_item, apb_scoreboard) item_collected_export;

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
            wait(pkt_qu.size() > 0);
            packet = pkt_qu.pop_front();

            
            
            if(packet.wr_en) begin
                sc_mem[packet.addr] = packet.wdata;
                `uvm_info(get_type_name(),$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
                `uvm_info(get_type_name(),$sformatf("Addr: %0h",packet.addr),UVM_LOW)
                `uvm_info(get_type_name(),$sformatf("Data: %0h",packet.wdata),UVM_LOW)
                `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)        
            end
            else if(packet.rd_en) begin
                if(sc_mem[packet.addr] == packet.rdata) begin
                `uvm_info(get_type_name(),$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
                `uvm_info(get_type_name(),$sformatf("Addr: %0h",packet.addr),UVM_LOW)
                `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[packet.addr],packet.rdata),UVM_LOW)
                `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
                end
                else begin
                `uvm_error(get_type_name(),"------ :: READ DATA MisMatch :: ------")
                `uvm_info(get_type_name(),$sformatf("Addr: %0h",packet.addr),UVM_LOW)
                `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[packet.addr],packet.rdata),UVM_LOW)
                `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
                end
            end
        end
      endtask : run_phase

endclass: apb_scoreboard
