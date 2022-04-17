module device 
  #(  
  parameter ADDRESS_W  = 4,
  parameter DATA_W  = 8
  )
  (
    input clk,
    input rst ,
    
    input [ADDRESS_W -1:0]  address ,
    input                   write_en ,
    input                   read_en ,
    
    input  [DATA_W -1:0] data_wr ,
    output reg [DATA_W -1:0] data_rd 
  ); 
  
  
  // memorijski niz
  reg [DATA_W -1:0] memory_array  [2**ADDRESS_W ];

  // brisanje sadrzaja u resetu 
  always @(posedge rst ) 
    for(int i=0;i<2**ADDRESS_W ;i++) memory_array [i]=8'hFF;
   
  // upis
  always @(posedge clk) 
    if (write_en )    memory_array [address ] <= data_wr ;

  // citanje
  always @(posedge clk)
    if (read_en ) data_rd  <= memory_array [address ];

endmodule
