class spi_agent_top extends uvm_env;
`uvm_component_utils(spi_agent_top)

spi_agent s_agent;

spi_env_cfg e_cfg;

extern function new(string name="spi_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass


//////////// constructor //////////////
function spi_agent_top::new(string name="spi_agent_top",uvm_component parent);
        super.new(name,parent);
endfunction


////////////// build_phase ////////////
function void spi_agent_top::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(spi_env_cfg)::get(this,"","spi_env_cfg",e_cfg))
                `uvm_fatal("SPI AGENT TOP","cannot get env config data")

        if(e_cfg.has_agent) begin

                s_agent=spi_agent::type_id::create("s_agent",this);

                uvm_config_db#(master_agent_cfg)::set(this,"s_agent*","master_agent_cfg",e_cfg.m_cfg);
        end

endfunction

////////// run phase ////////////////////////
task spi_agent_top::run_phase(uvm_phase phase);
        uvm_top.print_topology();
endtask
