// MONITOR: Sprema novu transakciju i popuni je podacima sa 
//          interface magistrale i salje na scoreboard
// TODO: mozda nije dobro ovo od 30. linije
import my_package::*;

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
      wait(`MON_IF.read_en || `MON_IF.write_en || `MON_IF.read_dual_en || `MON_IF.write_dual_en);
        trans.address  = `MON_IF.address;
        trans.write_en = `MON_IF.write_en;
        trans.write_dual_en = `MON_IF.write_dual_en;
        trans.read_en = `MON_IF.read_en;
        trans.read_dual_en = `MON_IF.read_dual_en;
        trans.data_wr = `MON_IF.data_wr;

        if(trans.read_dual_en) begin
          @(`MON_IF);
          @(`MON_IF);
          trans.data_rd = `MON_IF.data_rd;
          // Cekamo jos jedan podatak (jos jedan clk)
          @(`MON_IF);
          trans.data_rd_dual = `MON_IF.data_rd;
          $display("!\t[MONITOR] DUAL read address = %0h \tdata_rd = %0h | address = %0h \tdata_rd = %0h",trans.address,trans.data_rd,trans.address+1,trans.data_rd_dual);
        end else if(trans.read_en) begin
          @(`MON_IF);
          @(`MON_IF);
          trans.data_rd = `MON_IF.data_rd;
        end else if (trans.write_dual_en) begin
          $display("!\t[MONITOR] DUAL write address = %0h \tdata_rd = %0h | address = %0h \tdata_rd = %0h",trans.address,trans.data_wr,trans.address+1,trans.data_wr);
        end
        monitor_to_scoreboard.put(trans);
    end
  endtask
  
endclass