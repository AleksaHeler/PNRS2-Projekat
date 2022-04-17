
`include "environment.sv"

program test(device_interface intf);
  
  class my_trans extends transaction;
    
    bit [1:0] count_telegram;
    
    function void pre_randomize();
      write_dual_en.rand_mode(0);
      write_en.rand_mode(0);
      read_dual_en.rand_mode(0);
      read_en.rand_mode(0);
      address.rand_mode(0);
        write_dual_en = 0;
        write_en = 0;
        read_dual_en = 0;
        read_en = 1;
        address  = tran_count;
      tran_count++;
    endfunction
    
  endclass
    
  environment env_instance;
  my_trans my_tr;
  
  initial begin
    //formiranje env_instance
    env_instance = new(intf);
    
    my_tr = new();
    
    //postavljanje broja ponavljanja paketa na 4
    env_instance.generator_instance.repetition_number = 4;
    
    env_instance.generator_instance.trans = my_tr;
    
    //poziv run taska unutar env_instance poziva main taskove generatora i drivera.
    env_instance.run();
  end
endprogram