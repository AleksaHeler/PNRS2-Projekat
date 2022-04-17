
import uvm_pkg::*;
`include "uvm_macros.svh"

class device_seq_item extends uvm_sequence_item;

  //podaci i kontrola
  rand bit [3:0] address;
  rand bit       write_en;
  rand bit       read_en;
  rand bit [7:0] data_wr;
  bit [7:0] data_rd;
  
  //makroi
  `uvm_object_utils_begin(device_seq_item)
    `uvm_field_int(address,UVM_ALL_ON)
    `uvm_field_int(write_en,UVM_ALL_ON)
    `uvm_field_int(read_en,UVM_ALL_ON)
    `uvm_field_int(data_wr,UVM_ALL_ON)
  `uvm_object_utils_end
  
  // konstruktor
  function new(string name = "device_seq_item");
    super.new(name);
  endfunction
  
  // oranicenje da se formira transakcija ili za upis ili za citanje
  constraint wr_rd_c { write_en != read_en; }; 
  
endclass