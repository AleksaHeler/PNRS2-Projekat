//  Class: base_test
//

`include "env.sv"

class base_test extends uvm_test;
    `uvm_component_utils(base_test);

    //  Group: Components
    apb_environment env;

    //  Group: Variables


    //  Group: Functions

    //  Constructor: new
    function new(string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        // Create the env
        env = apb_environment::type_id::create("env", this);
    endfunction : build_phase

    virtual function void end_of_elaboration();
        //print's the topology
        print();
    endfunction

    function void report_phase(uvm_phase phase);
        uvm_report_server svr;
        super.report_phase(phase);
        
        svr = uvm_report_server::get_server();
        if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)>0) begin
          `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
          `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
          `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
         end
         else begin
          `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
          `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
          `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
         end
    endfunction
    
endclass: base_test
