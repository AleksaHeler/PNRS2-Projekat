import uvm_pkg::*;
`include "uvm_macros.svh"

parameter PADDR_SIZE = 4;
parameter PDATA_SIZE = 8;

`include "interface.sv"
`include "base_test.sv"

module testbench;
    bit PCLK, PRESETn;
    
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
      .gpio_i(device_interface.gpio_i),
      .gpio_o(device_interface.gpio_o),
      .gpio_oe(device_interface.gpio_oe),
      .irq_o(device_interface.irq_o)
    );
    
      /////////////////////////////////////////////////////////
      //
      // Clock & Reset
      //
      initial begin : gen_PCLK
          PCLK <= 1'b0;
          forever #10 PCLK = ~PCLK;
      end : gen_PCLK
    
      initial begin : gen_PRESETn;
        uvm_config_db#(virtual device_if)::set(uvm_root::get(),"*","vif",device_interface);
        
        PRESETn = 1'b1;
        //ensure falling edge of PRESETn
        #10;
        PRESETn = 1'b0;
        #32;
        PRESETn = 1'b1;
  
        //run_test("mytest");
  
      end : gen_PRESETn;
      //////////////////////////////////////////////////////////
      
  endmodule : testbench