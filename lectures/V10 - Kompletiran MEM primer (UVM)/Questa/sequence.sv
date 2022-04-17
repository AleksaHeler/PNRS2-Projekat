
// Pseudoslucajna pobuda

class device_sequence extends uvm_sequence#(device_seq_item);
  
  `uvm_object_utils(device_sequence)
  

  // konstruktor
  function new(string name = "device_sequence");
    super.new(name);
  endfunction
  
  `uvm_declare_p_sequencer(device_sequencer)
  

  // formira, randomizuje i salje device_seq_item ka drajveru
  virtual task body();
    req = device_seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
  endtask
endclass



// sekvenca upisa 
class write_sequence extends uvm_sequence#(device_seq_item);
  
  `uvm_object_utils(write_sequence)
   

  // konstruktor
  function new(string name = "write_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.write_en==1;})
  endtask
endclass


// sekvenca citanja
class read_sequence extends uvm_sequence#(device_seq_item);
  
  `uvm_object_utils(read_sequence)
   
  // konstruktor
  function new(string name = "read_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.read_en==1;})
  endtask
endclass


// dupla pisi-citaj sekvenca
class write_read_sequence extends uvm_sequence#(device_seq_item);
  
  `uvm_object_utils(write_read_sequence)
   
  
  // konstruktor
  function new(string name = "write_read_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do_with(req,{req.write_en==1;})
    `uvm_do_with(req,{req.read_en==1;})
  endtask
endclass


// sekvenca unutar sekvence wr_rd_sequence  
class wr_rd_sequence extends uvm_sequence#(device_seq_item);
  
  write_sequence wr_seq;
  read_sequence  rd_seq;
  
  `uvm_object_utils(wr_rd_sequence)
   
  // konstruktor
  function new(string name = "wr_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_do(wr_seq)
    `uvm_do(rd_seq)
  endtask
endclass

// sekvenca 16 pseudoslucajnih upisa i citanja
class all_wr_rd_sequence extends uvm_sequence#(device_seq_item);
  
   wr_rd_sequence wr_rd_seq;
  
  `uvm_object_utils(all_wr_rd_sequence)
   
  // konstruktor
  function new(string name = "all_wr_rd_sequence");
    super.new(name);
  endfunction
  
virtual task body();
	int num_of_trans = 16;
	
  	for(int i = 1; i <= num_of_trans; i++) 
	begin  
	`uvm_do(wr_rd_seq)
    end
endtask  
  
endclass


// sekvenca 16 upisa i citanja rastucim redom  
class deterministic_all_wr_rd_sequence extends uvm_sequence#(device_seq_item);
 
  wr_rd_sequence wr_rd_seq;
  `uvm_object_utils (deterministic_all_wr_rd_sequence)
   
  // konstruktor
  function new(string name = "deterministic_all_wr_rd_sequence");
    super.new(name);
  endfunction
  
virtual task body();
	int num_of_trans = 16;
	
  	for(int i = 1; i <= num_of_trans; i++) 
	begin  
    `uvm_do_with(req,{req.write_en==1; req.address==i-1;})
    `uvm_do_with(req,{req.read_en==1; req.address==i-1;})
	end
endtask    
  
  
endclass  