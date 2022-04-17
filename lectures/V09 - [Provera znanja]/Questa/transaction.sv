// Opis transakcione poruke
// Dodati prosireni signali
// TODO: prosiriti data_rd_dual[7:0] signal, dodati ga u sve fajlove!!!

class transaction;
  //declaring the transaction items
  rand bit [1:0] address;
  rand bit       write_en;
  rand bit       write_dual_en;
  rand bit       read_en;
  rand bit       read_dual_en;
  rand bit [7:0] data_wr;
       bit [7:0] data_rd;
       bit [7:0] data_rd_dual;
       bit [1:0] tran_count;
  
  //constaint, to generate any one among write and read
  //constraint write_read_constraint { write_en != read_en; };
  // DONE: dodat constraint - ne moze vise od jednog signala biti ukljucen
  // TODO: proveriti da li ovo zapravo radi kako treba
  constraint write_read_constraint { write_en + write_dual_en + read_en + read_dual_en < 2; };
  
  //postrandomize function, displaying randomized values of items 
  // TODO: prosiriti ispis za ...dual_en
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    //$display("\t address  = %0h",address);
    if(write_en || write_dual_en) $display("\t address  = %0h\t write_en = %0h\t data_wr = %0h",address,write_en,data_wr);
    if(read_en || read_dual_en) $display("\t address  = %0h\t read_en = %0h",address,read_en);
    $display("-----------------------------------------");
  endfunction
  
  //deep copy method
  function transaction do_copy();
    transaction trans;
    trans = new();
    trans.address  = this.address;
    trans.write_en = this.write_en;
    trans.write_dual_en = this.write_dual_en;
    trans.read_en = this.read_en;
    trans.read_dual_en = this.read_dual_en;
    trans.data_wr = this.data_wr;
    return trans;
  endfunction
endclass