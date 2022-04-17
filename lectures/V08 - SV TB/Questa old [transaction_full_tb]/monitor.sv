// Reads data from DUT via interface and sends transactions to mailbox for scoreboard
`define MON_IF device_virtual_interf.monitor_cb
class monitor;
  
  //creating virtual interface handle
  virtual device_interface device_virtual_interf;
  
  //creating mailbox handle
  mailbox monitor_to_scoreboard;
  
  //constructor
  function new(virtual device_interface device_virtual_interf, mailbox monitor_to_scoreboard);
    //getting the interface
    this.device_virtual_interf = device_virtual_interf;
    //getting the mailbox handles from  environment 
    this.monitor_to_scoreboard = monitor_to_scoreboard;
  endfunction
  
  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      transaction trans;
      trans = new();

      @(`MON_IF);
      wait(`MON_IF.rd_en || `MON_IF.wr_en);
        trans.addr  = `MON_IF.addr;
        trans.wr_en = `MON_IF.wr_en;
        trans.wdata = `MON_IF.wdata;
        if(`MON_IF.rd_en) begin
          trans.rd_en = `MON_IF.rd_en;
          @(`MON_IF);
          @(`MON_IF);
          trans.rdata = `MON_IF.rdata;
        end      
        monitor_to_scoreboard.put(trans);
    end
  endtask
  
endclass