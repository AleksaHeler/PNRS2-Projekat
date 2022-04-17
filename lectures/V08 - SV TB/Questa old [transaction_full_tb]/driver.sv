// Reads transactions from mailbox and sends data over interface to DUT
`define DRIVER_INTERFACE device_virtual_interf.driver_cb
class driver;
  
  //used to count the number of transactions
  int number_of_trans;
  
  //creating virtual interface handle
  virtual device_interface device_virtual_interf;
  
  //creating mailbox handle
  mailbox genarator_to_driver;
  
  //constructor
  function new(virtual device_interface device_virtual_interf,mailbox genarator_to_driver);
    //getting the interface
    this.device_virtual_interf = device_virtual_interf;
    //getting the mailbox handles from  environment 
    this.genarator_to_driver = genarator_to_driver;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(device_virtual_interf.reset);
    $display("--------- [DRIVER] Reset Started ---------");
    `DRIVER_INTERFACE.wr_en <= 0;
    `DRIVER_INTERFACE.rd_en <= 0;
    `DRIVER_INTERFACE.addr  <= 0;
    `DRIVER_INTERFACE.wdata <= 0;        
    wait(!device_virtual_interf.reset);
    $display("--------- [DRIVER] Reset Ended ---------");
  endtask
  
  // Core logic of this component: drives the transaction items to interface signals
  task drive;
      transaction trans;
      `DRIVER_INTERFACE.wr_en <= 0;
      `DRIVER_INTERFACE.rd_en <= 0;
      genarator_to_driver.get(trans);
      $display("--------- [DRIVER-TRANSFER: %0d] ---------",number_of_trans);
      @(`DRIVER_INTERFACE);
        `DRIVER_INTERFACE.addr <= trans.addr;
      if(trans.wr_en) begin
        `DRIVER_INTERFACE.wr_en <= trans.wr_en;
        `DRIVER_INTERFACE.wdata <= trans.wdata;
        $display("\tADDR = %0h \tWDATA = %0h",trans.addr,trans.wdata);
        @(`DRIVER_INTERFACE);
      end
      if(trans.rd_en) begin
        `DRIVER_INTERFACE.rd_en <= trans.rd_en;
        @(`DRIVER_INTERFACE);
        `DRIVER_INTERFACE.rd_en <= 0;
        @(`DRIVER_INTERFACE);
        trans.rdata = `DRIVER_INTERFACE.rdata;
        $display("\tADDR = %0h \tRDATA = %0h",trans.addr,`DRIVER_INTERFACE.rdata);
      end
      $display("-----------------------------------------");
      number_of_trans++;
  endtask
  
    
  // Main functionality
  task main;
    forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(device_virtual_interf.reset);
        end
        //Thread-2: Calling drive task
        begin
          forever
            drive();
        end
      join_any
      disable fork;
    end
  endtask
        
endclass