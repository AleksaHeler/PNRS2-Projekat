

interface device_interface(input logic clk,rst);
  
  //deklaracija signala
  logic [3:0] address;
  logic write_en;
  logic read_en;
  logic [7:0] data_wr;
  logic [7:0] data_rd;
  
  //kloking blok
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output address;
    output write_en;
    output read_en;
    output data_wr;
    input  data_rd;  
  endclocking
  
  //monitor kloking blok
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input address;
    input write_en;
    input read_en;
    input data_wr;
    input data_rd;  
  endclocking
  
    modport DRIVER  (clocking driver_cb,input clk,rst);
  
    modport MONITOR (clocking monitor_cb,input clk,rst);
  
endinterface
