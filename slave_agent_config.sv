class slave_agent_cfg extends uvm_object;
`uvm_object_utils(slave_agent_cfg)

virtual spi_interface spi_vif;


uvm_active_passive_enum is_active=UVM_ACTIVE;

extern function new(string name="slave_agent_cfg");

endclass

////////////// constructor /////////////////
function slave_agent_cfg::new(string name="slave_agent_cfg");
        super.new(name);
endfunction
