
//  Interfejs definicija
interface mem_intf (input bit clk);
  logic [7:0] addr;
  logic [7:0] data_i;
  logic [7:0] data_o;
  logic       rw;
  logic       ce;
  // DUT modport
  modport  dut_mdprt (input  addr, data_i, rw, ce, clk, output data_o);
  // TB Driver modport
  modport  drv_mdprt  (output addr, data_i, rw, ce, input data_o, clk);
  // TB Monitor modport
  modport  mon_mdprt (input  addr, data_i, rw, ce, clk, data_o);
endinterface

//DUT kao model ram memorije
module ram(mem_intf.dut_mdprt mif);
  reg [7:0] memr [0:255];
  // RAM operacija citanja
  assign mif.data_o = (~mif.rw && mif.ce) ? 
     memr[mif.addr] : 8'b0;
  // RAM operacija upisa
  always @ (posedge mif.clk)
    if (mif.ce && mif.rw) 
      memr[mif.addr] = mif.data_i;
endmodule

// Testbench
module mem_tb();
  logic clk = 0;
  always #1 clk = ~clk;
  // interface sa povezanim taktom
  mem_intf mem_if0(clk);
  // DUT povezan na interface
  ram dut_ram(mem_if0.dut_mdprt);
  // Instanca test programa
  test test_instanca(mem_if0);
endmodule

// Test program
program test(mem_intf tbf0);
  
/// ZADATAK 1 - izmeniti klasu driver ////////////////////////////////////////////////////
  class driver;
    virtual mem_intf.drv_mdprt ports;
    // Konstruktor
    function new(virtual mem_intf.drv_mdprt ports);
        this.ports = ports;
    endfunction
    // Generisanje transakcija: 4 upisa, zatim 4 citanja
    task run_t();
      integer i = 0;
      integer rand_address;
      integer rand_data;
      for (i= 0; i < 4; i ++) begin
        @ (posedge ports.clk);
        // Dodato: generisanje radnom adrese i podatka za upis
        rand_address = $urandom_range(0, 255);
        rand_data = $urandom_range(0, 255);
        $display("Writing address %0d with data %0d",rand_address,rand_data);
        ports.addr = rand_address;
        ports.data_i = rand_data;
        ports.ce = 1;
        ports.rw = 1;
        @ (posedge ports.clk);
        ports.addr = 0;
        ports.data_i = 0;
        ports.ce = 0;
        ports.rw = 0;
      end
      for (i= 0; i < 4; i ++) begin
        @ (posedge ports.clk);
        // Dodato: generisanje radnom adrese za citanje
        rand_address = $urandom_range(0, 255);
        $display("Read address %0d",rand_address);
        ports.addr = rand_address;
        ports.data_i = 0;
        ports.ce = 1;
        ports.rw = 0;
        @ (posedge ports.clk);
        ports.addr = 0;
        ports.data_i = 0;
        ports.ce = 0;
        ports.rw = 0;
      end
    endtask
  endclass
//////////////////////////////////////////////////////////////////////////////////////////
  
  // Klasa monitor
  class monitor;
    reg  [7:0] tbmem [255];
    virtual mem_intf.mon_mdprt ports;
    // Konstruktor
    function new(virtual mem_intf.mon_mdprt ports);
       this.ports = ports;
    endfunction
    // Monitoring transakcija
    task run_t();
      while(1) begin
         @ (negedge ports.clk);
         if (ports.ce) begin
           if (ports.rw) begin
             tbmem[ports.addr] = ports.data_i;
           end else begin
             if (ports.data_o != tbmem[ports.addr]) begin
               $display("Error : Expected %0d Got %0d",
                 tbmem[ports.addr],ports.data_o);
             end else begin
               $display("Pass  : Expected %0d Got %0d",
                 tbmem[ports.addr],ports.data_o);
             end
           end
         end
      end
    endtask
  endclass

  // Initial begin blok koji pokrece TB
  initial begin
    automatic driver   tb_driver0  = new(tbf0.drv_mdprt);
    automatic monitor  tb_monitor0 = new(tbf0.mon_mdprt);
    fork 
      begin
        tb_monitor0.run_t();
      end
   join_none
   fork
      begin
        tb_driver0.run_t();
      end
   join  
    #10 $finish;
  end
endprogram
