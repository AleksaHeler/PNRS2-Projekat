// Kreira: generator, driver, monitor i scoreboard, kao i mailbox-ove
// Ovde nista nije izmenjeno, sve izmene su unutar gore navedenih klasa

import my_package::*;

`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;
  
  //generator and driver instance
  generator  generator_instance;
  driver     driver_instance;
  monitor    monitor_instance;
  scoreboard scoreboard_instance;
  
  //mailbox handle's
  mailbox generator_to_driver;
  mailbox monitor_to_scoreboard;
  
  //event for synchronization between generator and test
  event generator_ended;
  
  //virtual interface
  virtual device_interface device_virtual_interf;
  
  //constructor
  function new(virtual device_interface device_virtual_interf);
    //get the interface from test
    this.device_virtual_interf = device_virtual_interf;
    
    //creating the mailbox (Same handle will be shared across generator and driver)
    generator_to_driver = new();
    monitor_to_scoreboard  = new();
    
    //creating generator and driver
    generator_instance = new(generator_to_driver,generator_ended);
    driver_instance = new(device_virtual_interf,generator_to_driver);
    monitor_instance  = new(device_virtual_interf,monitor_to_scoreboard);
    scoreboard_instance  = new(monitor_to_scoreboard);
  endfunction
  
  //
  task pre_test();
    driver_instance.reset();
  endtask
  
  task test();
    fork 
    generator_instance.main();
    driver_instance.main();
    monitor_instance.main();
    scoreboard_instance.main();      
    join_any
  endtask
  
  task post_test();
    wait(generator_ended.triggered);
    wait(generator_instance.repetition_number == driver_instance.number_of_trans);
    wait(generator_instance.repetition_number == scoreboard_instance.number_of_trans);
  endtask  
  
  //run task
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask
  
endclass

