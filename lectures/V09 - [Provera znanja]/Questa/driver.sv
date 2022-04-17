// Driver: kopira podatke iz mailbox-a (koji su od generatora) na interface
// Dodati slucajevi kod if-ova kako da handle-uje nove operacije
import my_package::*;

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
    `DRIVER_INTERFACE.write_en <= 0;
    `DRIVER_INTERFACE.write_dual_en <= 0;
    `DRIVER_INTERFACE.read_en <= 0;
    `DRIVER_INTERFACE.read_dual_en <= 0;
    `DRIVER_INTERFACE.address  <= 0;
    `DRIVER_INTERFACE.data_wr <= 0;
    wait(!device_virtual_interf.reset);
    $display("--------- [DRIVER] Reset Ended ---------");
  endtask
  
  //drivers the transaction items to interface signals
  task drive;
      transaction trans;
      `DRIVER_INTERFACE.write_en <= 0;
      `DRIVER_INTERFACE.write_dual_en <= 0;
      `DRIVER_INTERFACE.read_en <= 0;
      `DRIVER_INTERFACE.read_dual_en <= 0;
      genarator_to_driver.get(trans);
      $display("--------- [DRIVER-TRANSFER: %0d] ---------",number_of_trans);
      @(`DRIVER_INTERFACE);
        `DRIVER_INTERFACE.address <= trans.address;
      // TODO: proveriti da li su ovi if-ovi dobri zapravo
      if(trans.write_en) begin
        `DRIVER_INTERFACE.write_en <= trans.write_en;
        `DRIVER_INTERFACE.data_wr <= trans.data_wr;
        $display("\taddress = %0h \tdata_wr = %0h",trans.address,trans.data_wr);
        @(`DRIVER_INTERFACE);
      end
      if(trans.write_dual_en) begin
        `DRIVER_INTERFACE.write_dual_en <= trans.write_dual_en;
        `DRIVER_INTERFACE.data_wr <= trans.data_wr;
        $display("\tDUAL: address = %0h \tdata_wr = %0h",trans.address,trans.data_wr);
        // Cekaj dva ciklusa, da DUT dva puta upise u memoriju
        @(`DRIVER_INTERFACE);
        @(`DRIVER_INTERFACE);
      end
      if(trans.read_en) begin
        `DRIVER_INTERFACE.read_en <= trans.read_en;
        @(`DRIVER_INTERFACE);
        `DRIVER_INTERFACE.read_en <= 0;
        @(`DRIVER_INTERFACE);
        trans.data_rd = `DRIVER_INTERFACE.data_rd;
        $display("\taddress = %0h \tdata_rd = %0h",trans.address,`DRIVER_INTERFACE.data_rd);
      end
      if(trans.read_dual_en) begin
        `DRIVER_INTERFACE.read_dual_en <= trans.read_dual_en;
        @(`DRIVER_INTERFACE);
        `DRIVER_INTERFACE.read_dual_en <= 0;
        @(`DRIVER_INTERFACE);
        trans.data_rd = `DRIVER_INTERFACE.data_rd;
        $display("!\t[DRIVER] DUAL 1 address = %0h \tdata_rd = %0h",trans.address,`DRIVER_INTERFACE.data_rd);
        // Sacekamo jedan clk i u drugu prom. na trans. upisemo drugi sledeci read 
        @(`DRIVER_INTERFACE);
        trans.data_rd_dual = `DRIVER_INTERFACE.data_rd;
        $display("!\t[DRIVER] DUAL 2 address = %0h \tdata_rd = %0h",trans.address+1,`DRIVER_INTERFACE.data_rd_dual);
      end
      $display("-----------------------------------------");
      number_of_trans++;
  endtask
  
    
  //
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