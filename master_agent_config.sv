class master_agent_cfg extends uvm_object;
`uvm_object_utils(master_agent_cfg)

virtual wb_interface wb_vif;

uvm_active_passive_enum is_active=UVM_ACTIVE;

extern function new(string name="master_agent_cfg");

endclass

////////////// constructor /////////////////
function master_agent_cfg::new(string name="master_agent_cfg");
        super.new(name);
endfunction
