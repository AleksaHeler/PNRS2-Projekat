parameter PADDR_SIZE = 4;
parameter PDATA_SIZE = 8;

interface device_if (input logic PCLK, PRESETn);

    logic                    PSEL;
    logic                    PENABLE;
    logic [PADDR_SIZE  -1:0] PADDR;
    logic [PDATA_SIZE/8-1:0] PSTRB;
    logic [PDATA_SIZE  -1:0] PWDATA;
    logic [PDATA_SIZE  -1:0] PRDATA;
    logic                    PWRITE;
    logic                    PREADY;
    logic                    PSLVERR;
    
endinterface