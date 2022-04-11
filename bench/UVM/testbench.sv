import uvm_pkg::*;

module testbench;
    parameter PDATA_SIZE        = 8;

    /////////////////////////////////////////////////////////
    //
    // Variables
    //
    //APB signals
    logic                    PSEL;
    logic                    PENABLE;
    logic [             3:0] PADDR;
    logic [PDATA_SIZE/8-1:0] PSTRB;
    logic [PDATA_SIZE  -1:0] PWDATA;
    logic [PDATA_SIZE  -1:0] PRDATA;
    logic                    PWRITE;
    logic                    PREADY;
    logic                    PSLVERR;
  
    //GPIOs
    logic [PDATA_SIZE -1:0] gpio_o, gpio_i, gpio_oe;
  
    //IRQ
    logic irq_o;
  
  
    /////////////////////////////////////////////////////////
    //
    // Clock & Reset
    //
    bit PCLK, PRESETn;
    initial begin : gen_PCLK
        PCLK <= 1'b0;
        forever #10 PCLK = ~PCLK;
    end : gen_PCLK
  
    initial begin : gen_PRESETn;
      PRESETn = 1'b1;
      //ensure falling edge of PRESETn
      #10;
      PRESETn = 1'b0;
      #32;
      PRESETn = 1'b1;
    end : gen_PRESETn;

    device_if device_interface(PCLK, PRESETn);

    apb_gpio DUT (
      .PCLK(PCLK),
      .PRESETn(PRESETn),
      .PSEL(device_interface.PSEL),
      .PENABLE(device_interface.PENABLE),
      .PADDR(device_interface.PADDR),
      .PWRITE(device_interface.PWRITE),
      .PSTRB(device_interface.PSTRB),
      .PWDATA(device_interface.PWDATA),
      .PRDATA(device_interface.PRDATA),
      .PREADY(device_interface.PREADY),
      .PSLVERR(device_interface.PSLVERR),
      .*
    );
  
  
    /////////////////////////////////////////////////////////
    //
    // Instantiate the TB and DUT
    //
    // test #( .PDATA_SIZE ( PDATA_SIZE ))
    // tb ( .* );
  
  
    // apb_gpio #( .PDATA_SIZE ( PDATA_SIZE ))
    // dut ( .* );
   
  endmodule : testbench