// TEST: Redom vrti prvo write pa read za istu addr 

`include "environment.sv"

program test(device_interface intf);
  
  class my_trans extends transaction;
    
    bit [1:0] count_telegram;
    
    function void pre_randomize();
      write_en.rand_mode(0);
      write_dual_en.rand_mode(0);
      read_en.rand_mode(0);
      read_dual_en.rand_mode(0);
      address.rand_mode(0);
      
      // TODO: prosiriti da radi i sa dual r/w, mozda %4==0/1/2/else
      if(tran_count %2 == 0) begin
        write_en = 1;
        read_en = 0;
        address  = count_telegram;      
      end 
      else begin
        write_en = 0;
        read_en = 1;
        address  = count_telegram;
        count_telegram++;
      end
      tran_count++;
    endfunction
    
  endclass
    
  //declaring environment instance
  environment env_instance;
  my_trans my_tr;
  
  initial begin
    //creating environment
    env_instance = new(intf);
    
    my_tr = new();
    
    //setting the repeat count of generator as 4, means to generate 4 packets
    env_instance.generator_instance.repetition_number = 10;
    
    env_instance.generator_instance.trans = my_tr;
    
    //calling run of env, it interns calls generator and driver main tasks.
    env_instance.run();
  end
endprogram