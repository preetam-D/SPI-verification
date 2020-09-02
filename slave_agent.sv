class slave_agent extends uvm_agent;
`uvm_component_utils(slave_agent)

slave_agent_cfg agt_cfg;

slave_driver driver;
slave_monitor monitor;
slave_sequencer sequencer;

extern function new(string name="slave_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

//////// constructor ///////////
function slave_agent::new(string name="slave_agent",uvm_component parent);
        super.new(name,parent);
endfunction

////// build phase //////////////
function void slave_agent::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(slave_agent_cfg)::get(this,"","slave_agent_cfg",agt_cfg))
                `uvm_fatal("SLAVE_AGENT","cannot get agent config data")

        monitor=slave_monitor::type_id::create("monitor",this);

        if(agt_cfg.is_active == UVM_ACTIVE)
        begin
                driver=slave_driver::type_id::create("driver",this);
                sequencer=slave_sequencer::type_id::create("sequencer",this);
        end
endfunction

////////// connect phase /////////////////////
function void slave_agent::connect_phase(uvm_phase phase);
 driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction
