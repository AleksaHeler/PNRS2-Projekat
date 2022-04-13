//  Class: apb_scoreboard
//
class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard);

    //  Group: Components


    //  Group: Variables
    sequence_item packet_queue[$];

    uvm_analysis_imp#(sequence_item, apb_scoreboard) item_collected_export;

    logic [PDATA_SIZE-1:0] registers [9];
    logic [PDATA_SIZE-1:0] gpio_o, gpio_oe;

    //  Group: Functions

    //  Constructor: new
    function new(string name = "apb_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
        foreach(registers[i]) registers[i] = 'b0;
    endfunction: build_phase

    virtual function void write(sequence_item packet);
        // packet.print();
        packet_queue.push_back(packet);
    endfunction : write

    virtual task run_phase(uvm_phase phase);
        sequence_item packet;
        
        forever begin
            wait(packet_queue.size() > 0);
            packet = packet_queue.pop_front();

            if (packet.gpio_o != gpio_o || packet.gpio_oe != gpio_oe) begin
                `uvm_error(get_type_name(), $sformatf("GPIO OUTPUT MISMATCH, expected %0h got %0h", gpio_o, packet.gpio_o))
            end

            if (packet.WRITE) begin
                registers[packet.ADDR] = packet.DATA;
                //`uvm_info(get_type_name(),$sformatf("register %0h write %0h", packet.ADDR, packet.DATA),UVM_NONE)
                
                for (int b=0; b < PDATA_SIZE; b++) gpio_o[b] = registers[MODE][b] ? 1'b0 : registers[OUTPUT][b];
                for (int b=0; b < PDATA_SIZE; b++) gpio_oe[b] = registers[MODE][b] ? registers[DIRECTION][b] & ~registers[OUTPUT][b] : registers[DIRECTION][b];
                
            end 
            else begin
                if (packet.ADDR == INPUT) begin
                    if (packet.DATA != packet.gpio_i) begin
                        `uvm_error(get_type_name(), $sformatf("GPIO INPUT MISMATCH, expected %0h got %0h", packet.gpio_i, packet.DATA))
                    end
                end else begin
                    if (registers[packet.ADDR] != packet.DATA) begin
                        `uvm_error(get_type_name(), $sformatf("REGISTER CONTENT MISMATCH %0h, expected %0h got %0h", packet.ADDR, registers[packet.ADDR], packet.DATA))
                    end
                    else begin 
                        //`uvm_info(get_type_name(),$sformatf("register %0h read %0h", packet.ADDR, packet.DATA),UVM_NONE)
                    end
                end
                //`uvm_info(get_type_name(),$sformatf("------ ::      READ DATA       :: ------"),UVM_NONE)
            end
        end
      endtask : run_phase

endclass: apb_scoreboard
