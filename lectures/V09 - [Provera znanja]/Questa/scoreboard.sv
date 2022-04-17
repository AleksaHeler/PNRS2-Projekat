// Scoreboard: ima internu memoriju sa kojom poredi DUT memoriju
// TODO: dodati slucaj za dual r/w koriscenjem data_rd_dual[7:0] signala

import my_package::*;

class scoreboard;
   
  //creating mailbox handle
  mailbox monitor_to_scoreboard;
  
  //used to count the number of transactions
  int number_of_trans;
  
  //array to use as local memory
  bit [7:0] memory_array[4];
  
  //constructor
  function new(mailbox monitor_to_scoreboard);
    //getting the mailbox handles from  environment 
    this.monitor_to_scoreboard = monitor_to_scoreboard;
    foreach(memory_array[i]) memory_array[i] = 8'hFF;
  endfunction
  
  //stores data_wr and compare data_rd with stored data
  task main;
    transaction trans;
    forever begin
      #50;
      monitor_to_scoreboard.get(trans);
      if(trans.read_en) begin
        if(memory_array[trans.address] != trans.data_rd) 
          $error("[SCB-FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.address,memory_array[trans.address],trans.data_rd);
        else 
          $display("[SCB-PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.address,memory_array[trans.address],trans.data_rd);
      end
      else if(trans.write_en)
        memory_array[trans.address] = trans.data_wr;
      else if(trans.read_dual_en) begin
        // Ako se bilo koja od dve vrednosti razlikuje od referentne - greska (ref. vr. upisujemo u ifu ispod - write_dual_en)
        if(memory_array[trans.address] != trans.data_rd) 
          $display("[SCOREBOARD-FAIL] DUAL READ 1 Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.address,memory_array[trans.address],trans.data_rd);
        else if(memory_array[trans.address+1] != trans.data_rd_dual)
          $display("[SCOREBOARD-FAIL] DUAL READ 2 Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.address+1,memory_array[trans.address+1],trans.data_rd_dual);
        else begin
          $display("[SCOREBOARD-PASS] DUAL READ 1 Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.address,memory_array[trans.address],trans.data_rd);
          $display("[SCOREBOARD-PASS] DUAL READ 2 Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.address+1,memory_array[trans.address+1],trans.data_rd_dual);
        end
      end
      else if(trans.write_dual_en) begin
        // write addr and value from trans to memory_array
        memory_array[trans.address] = trans.data_wr;
        memory_array[trans.address+1] = trans.data_wr;
      end
      number_of_trans++;
    end
  endtask
  
endclass