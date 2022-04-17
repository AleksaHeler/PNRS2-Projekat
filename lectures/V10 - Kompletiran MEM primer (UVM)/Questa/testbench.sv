 import uvm_pkg::*;
 import my_package::*;

module tbench_top;

  bit clk;
  bit rst;
  

  // generisanje takta
  always #5 clk = ~clk;
  

  // generisanje reseta
  initial begin
    rst = 1;
    #5 rst =0;
  end
  
  //instanciranje interfejsa i povezivanje sa taktom i resetom
  device_interface intf(clk,rst);
  
  
  //instanciranje DUT-a i povezivanje preko interfejsa
  device DUT (
    .clk(intf.clk),
    .rst(intf.rst),
    .address(intf.address),
    .write_en(intf.write_en),
    .read_en(intf.read_en),
    .data_wr(intf.data_wr),
    .data_rd(intf.data_rd)
   );
  
  //postavljanje objekta tipa virtual device_interface u uvm_config_db
  //prvi argument set metode context je postavljen na uvm_root::get()
  //sto predstavlja vrh hijerarhije testbencha.
  //drugi argument set metode je string koji opredeljuje hijerarhijsku putanju
  //sa koje se moze pristupiti datom objektu
  //treci argument set metode je string koji imenuje podatak koji se smesta u DB
  //cetvrti argument set metode je tip koji je smesten u DB, u ovom slucaju to je intf.
  //and enabling the wave dump
  initial begin 
    uvm_config_db#(virtual device_interface)::set(uvm_root::get(),"*","vif",intf);
    //uvm_config_db#(virtual device_interface)::set(null,"*","vif",intf);
    // cuvanje signala za prikaz u EPWave alatu
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  // pozivanje testa
  initial begin 
    run_test("device_model_base_test");
  end
  
endmodule