
// INTERFACE: dodato: ..._dual_en signali. Ovde se samo prosledjuju
interface device_interface(input logic clk,reset);
  
  //declaring the signals
  logic [1:0] address;
  logic write_en;
  logic write_dual_en;
  logic read_en;
  logic read_dual_en;
  logic [7:0] data_wr;
  logic [7:0] data_rd;
  
  //driver clocking block
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output address;
    output write_dual_en;
    output write_en;
    output read_dual_en;
    output read_en;
    output data_wr;
    input  data_rd;  
  endclocking
  
  //monitor clocking block
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input address;
    input write_dual_en;
    input write_en;
    input read_dual_en;
    input read_en;
    input data_wr;
    input data_rd;  
  endclocking
  
  //driver modport
  modport DRIVER  (clocking driver_cb,input clk,reset);
  
  //monitor modport  
  modport MONITOR (clocking monitor_cb,input clk,reset);
  
endinterface