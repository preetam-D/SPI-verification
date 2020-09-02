class slave_agent_top extends uvm_env;
`uvm_component_utils(slave_agent_top)

slave_agent sl_agent;

spi_env_cfg e_cfg;

extern function new(string name="slave_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


//////////// constructor //////////////
function slave_agent_top::new(string name="slave_agent_top",uvm_component parent);
        super.new(name,parent);
endfunction


////////////// build_phase ////////////
function void slave_agent_top::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(spi_env_cfg)::get(this,"","spi_env_cfg",e_cfg))
                `uvm_fatal("SLAVE AGENT TOP","cannot get env config data")

        if(e_cfg.has_agent) begin

                sl_agent=slave_agent::type_id::create("sl_agent",this);

                uvm_config_db#(slave_agent_cfg)::set(this,"sl_agent*","slave_agent_cfg",e_cfg.s_cfg);
        end

endfunction

////////// run phase ////////////////////////
task slave_agent_top::run_phase(uvm_phase phase);
        uvm_top.print_topology();
endtask
