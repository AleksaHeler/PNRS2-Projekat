`include "environment.sv"

program test(device_interface intf);
  
  class my_trans extends transaction;
    
    bit [1:0] count_telegram;
    bit [7:0] cnt;
    
    function void pre_randomize();
      wr_en.rand_mode(0);
      rd_en.rand_mode(0);
      addr.rand_mode(0);
      wr_en = 0;
      rd_en = 1;
      addr = cnt;
      cnt++;
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