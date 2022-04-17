// Describes packet of data for mailboxes (with deep copy method)
class transaction;
  //declaring the transaction items
  rand bit [1:0] addr;
  rand bit       wr_en;
  rand bit       rd_en;
  rand bit [7:0] wdata;
       bit [7:0] rdata;
       bit [1:0] tran_count;
  
  //constaint, to generate any one among write and read
  constraint write_read_constraint { write_en != read_en; }; 
  
  //postrandomize function, displaying randomized values of items 
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    //$display("\t address  = %0h",address);
    if(write_en) $display("\t address  = %0h\t write_en = %0h\t data_wr = %0h",address,write_en,data_wr);
    if(read_en) $display("\t address  = %0h\t read_en = %0h",address,read_en);
    $display("-----------------------------------------");
  endfunction
  
  //deep copy method
  function transaction do_copy();
    transaction trans;
    trans = new();
    trans.address  = this.address;
    trans.write_en = this.write_en;
    trans.read_en = this.read_en;
    trans.data_wr = this.data_wr;
    return trans;
  endfunction
endclass