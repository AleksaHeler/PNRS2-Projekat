// Randomizes tests and sends them to mailbox for driver
class generator;
  
  //declaring transaction class 
  rand transaction trans,tr;
  
  //repeat count, to specify number of items to generate
  int  repetition_number;
  
  //mailbox, to generate and send the packet to driver
  mailbox generator_to_driver;
  
  //event
  event ended;
  
  //constructor
  function new(mailbox generator_to_driver,event ended);
    //getting the mailbox handle from env, in order to share the transaction packet between the generator and driver, the same mailbox is shared between both.
    this.generator_to_driver = generator_to_driver;
    this.ended    = ended;
    trans = new();
  endfunction
  
  //main task, generates(create and randomizes) the repetition_number number of transaction packets and puts into mailbox
  task main();
    repeat(repetition_number) begin
    if( !trans.randomize() ) $fatal("Gen:: trans randomization failed");      
    tr = trans.do_copy();
    generator_to_driver.put(tr);
    end
    -> ended; 
  endtask
  
endclass