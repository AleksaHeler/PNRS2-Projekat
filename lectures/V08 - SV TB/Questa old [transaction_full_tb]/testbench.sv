// Instantiates DUT, and drives clock and reset signals

`include "interface.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
//`include "random_test.sv"
`include "wr_rd_test.sv"
//`include "default_rd_test.sv"
//----------------------------------------------------------------


module tbench_top;
  
  //clock and reset signal declaration
  bit clk;
  bit rst;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    rst = 1;
    #5 rst =0;
  end
  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  device_interface intf(clk,rst);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(intf);
  
  //DUT instance, interface signals are connected to the DUT ports
  device DUT (
    .clk(intf.clk),
    .rst(intf.rst),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );
  
  //enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule