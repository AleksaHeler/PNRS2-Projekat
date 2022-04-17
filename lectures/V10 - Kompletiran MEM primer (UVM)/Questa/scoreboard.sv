
class device_scoreboard extends uvm_scoreboard;
  

  // deklaracija sequence itema koji stize sa monitora 
  device_seq_item pkt_qu[$];
  
  //memorijski niz
  bit [7:0] sc_mem [16];

  //port za prijem paketa sa monitora
  uvm_analysis_imp#(device_seq_item, device_scoreboard) item_collected_import;
  `uvm_component_utils(device_scoreboard)

  // konstruktor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  
  // kreira port i inicijalizuje lokalnu memoriju bild faza 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      item_collected_import = new("item_collected_import", this);
      foreach(sc_mem[i]) sc_mem[i] = 8'hFF;
  endfunction: build_phase
  

  // funkcija upisa, prima paket od monitora i postavlja ga u queue
  virtual function void write(device_seq_item pkt);
    //pkt.print();
    pkt_qu.push_back(pkt);
  endfunction : write

  // poredi procitan podatak sa sadrzajem lokalne memroije run_phase 
  virtual task run_phase(uvm_phase phase);
    device_seq_item device_pkt;
    
    forever begin
      wait(pkt_qu.size() > 0);
      device_pkt = pkt_qu.pop_front();
      
      if(device_pkt.write_en) begin
        sc_mem[device_pkt.address] = device_pkt.data_wr;
        `uvm_info(get_type_name(),$sformatf("         WRITE TELEGRAM     "),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Addr: %0h",device_pkt.address),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("Data: %0h",device_pkt.data_wr),UVM_LOW)
        `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)        
      end
      else if(device_pkt.read_en) begin
        if(sc_mem[device_pkt.address] == device_pkt.data_rd) begin
          `uvm_info(get_type_name(),$sformatf("        READ TELEGRAM OK"),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Addr: %0h",device_pkt.address),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[device_pkt.address],device_pkt.data_rd),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
        else begin
          `uvm_error(get_type_name(),"        READ TELEGRAM WRONG          ")
          `uvm_info(get_type_name(),$sformatf("Addr: %0h", device_pkt.address),UVM_LOW)
          `uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[device_pkt.address],device_pkt.data_rd),UVM_LOW)
          `uvm_info(get_type_name(),"------------------------------------",UVM_LOW)
        end
      end
    end
  endtask : run_phase
endclass : device_scoreboard