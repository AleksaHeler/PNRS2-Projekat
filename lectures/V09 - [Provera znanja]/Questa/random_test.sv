
`include "environment.sv"

program test(device_interface intf);
  
  //declaring environment instance
  environment env_instance;
  
  initial begin
    //creating environment
    env_instance = new(intf);
    
    //setting the repeat count of generator as 4, means to generate 4 packets
    env_instance.generator_instance.repetition_number = 20;
    
    //calling run of env, it interns calls generator and driver main tasks.
    env_instance.run();
  end
endprogram