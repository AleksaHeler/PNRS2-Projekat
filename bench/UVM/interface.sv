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
    logic [PDATA_SIZE -1:0] gpio_o, gpio_i, gpio_oe;
    logic irq_o;
        
    clocking driver_cb @(posedge PCLK);
        default input #1 output #1;
        output  PSEL;
        output  PENABLE;
        output  PADDR;
        output  PSTRB;
        output  PWDATA;
        input   PRDATA;
        output  PWRITE;
        input   PREADY;
        input   PSLVERR;
        output  gpio_i;
        input   gpio_o;
        input  gpio_oe;
        input   irq_o;
    endclocking
    
    clocking monitor_cb @(posedge PCLK);
        default input #1 output #1;
        input   PSEL;
        input   PENABLE;
        input   PADDR;
        input   PSTRB;
        input   PWDATA;
        input   PRDATA;
        input   PWRITE;
        input   PREADY;
        input   PSLVERR;
        input   gpio_o, gpio_i, gpio_oe;
        input   irq_o;
    endclocking

    modport DRIVER  (clocking driver_cb, input PCLK, PRESETn);
  
    modport MONITOR (clocking monitor_cb, input PCLK, PRESETn);

endinterface