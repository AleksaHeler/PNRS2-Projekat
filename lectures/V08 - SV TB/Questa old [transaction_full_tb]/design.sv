// This is the DUT - basically a RAM memory
/* Signals:
*    - in address
*    - in write enable
*    - in read enable
*    - in data write
*    - out data read
*/
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
    input                   read_en ,
    
    //data signals
    input  [DATA_W -1:0] data_wr ,
    output reg [DATA_W -1:0] data_rd 
  ); 
  
  //reg [DATA_W -1:0] data_rd ;
  
  //Memory
  reg [DATA_W -1:0] memory_array  [2**ADDRESS_W ];

  //Reset 
  always @(posedge rst ) 
    for(int i=0;i<2**ADDRESS_W ;i++) memory_array [i]=8'hFF;
   
  // Write data to Memory
  always @(posedge clk) 
    if (write_en )    memory_array [address ] <= data_wr ;

  // Read data from device 
  always @(posedge clk)
    if (read_en ) data_rd  <= memory_array [address ];

endmodule