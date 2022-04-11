interface device_if (input logic PCLK, PRESETn,
    parameter PADDR_SIZE = 16,
    parameter PDATA_SIZE = 32);

    output reg                    PSEL,
    output reg                    PENABLE,
    output reg [PADDR_SIZE  -1:0] PADDR,
    output reg [PDATA_SIZE/8-1:0] PSTRB,
    output reg [PDATA_SIZE  -1:0] PWDATA,
    input      [PDATA_SIZE  -1:0] PRDATA,
    output reg                    PWRITE,
    input                         PREADY,
    input                         PSLVERR
    
endinterface