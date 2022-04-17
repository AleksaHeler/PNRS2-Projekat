// Gets the packet from monitor via mailbox, generate the expected result and compares with the actual result recived from monitor
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

      number_of_trans++;
    end
  endtask
  
endclass