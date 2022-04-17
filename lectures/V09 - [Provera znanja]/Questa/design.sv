/*


napraviti skroz novi test koji radi samo ovaj feature

izvrteti ono sa table

MOZDA mozemo prosiriti transakciju da podrzi dual transaction

MOZDA 

*/

// DUT: dodata obrada kada se postave signali ..._dual_en
module device 
  #(  
  parameter ADDRESS_W  = 2,
  parameter DATA_W  = 8
  )
  (
    input clk,
    input rst ,
    
    //control signals
    input [ADDRESS_W -1:0]  address ,
    input                   write_en ,
    input                   write_dual_en ,
    input                   read_en ,
    input                   read_dual_en ,
    
    //data signals
    input  [DATA_W -1:0] data_wr ,
    output reg [DATA_W -1:0] data_rd 
  ); 
  
  //reg [DATA_W -1:0] data_rd ;
  
  //Memory
  reg [DATA_W -1:0] memory_array  [2**ADDRESS_W ];

  // DONE: dodat registar da prati dual wr/rd
  reg dual_addr_offset;

  //Reset 
  always @(posedge rst ) begin
    for(int i=0;i<2**ADDRESS_W ;i++) memory_array [i]=8'hFF;
    dual_addr_offset = 0;
  end
   
  // Write data to Memory
  always @(posedge clk) 
    if (write_en )    memory_array [address ] <= data_wr ;

  // Read data from device 
  always @(posedge clk)
    if (read_en ) data_rd  <= memory_array [address ];
   

  ////// DONE: dodat kod za implementaciju dual write i read-a u DUT-u
  // Dual write data to Memory
  always @(posedge clk) begin
    if (write_dual_en && dual_addr_offset == 0) begin
      memory_array [address ] <= data_wr ;
      dual_addr_offset = 1;
    end else if (write_dual_en && dual_addr_offset == 1) begin
      memory_array [address+1 ] <= data_wr ;
      dual_addr_offset = 0;
    end
  end

  // Dual read data from device 
  always @(posedge clk) begin
    if (read_dual_en && dual_addr_offset == 0) begin
      data_rd  <= memory_array [address ];
      dual_addr_offset = 1;
    end else if (read_dual_en && dual_addr_offset == 1) begin
      data_rd  <= memory_array [address+1 ];
      dual_addr_offset = 0;
    end
  end

endmodule