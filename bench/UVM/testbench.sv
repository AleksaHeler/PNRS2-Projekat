import uvm_pkg::*;
import my_package::*;

module testbench;
    bit PCLK, PRESETn;

    //GPIOs
    logic [PDATA_SIZE -1:0] gpio_o, gpio_i, gpio_oe;
  
    //IRQ
    logic irq_o;
    
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
      // Clock & Reset
      //
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
  
        uvm_config_db#(virtual device_if)::set(uvm_root::get(),"*","vif",device_interface);
        //run_test("mytest");
  
      end : gen_PRESETn;
      //////////////////////////////////////////////////////////
      
  endmodule : testbench