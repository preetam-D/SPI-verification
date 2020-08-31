class spi_env extends uvm_env;
`uvm_component_utils(spi_env)

spi_env_cfg e_cfg;

spi_agent_top s_top;
slave_agent_top sl_top;

spi_virtual_sequencer vseqrh;
extern function new(string name="spi_env",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

//////////constructor//////////////////
function spi_env::new(string name="spi_env",uvm_component parent);
        super.new(name,parent);
endfunction

///////////build_phase/////////////
function void spi_env::build_phase(uvm_phase phase);

        super.build_phase(phase);
        if(!uvm_config_db#(spi_env_cfg)::get(this,"","spi_env_cfg",e_cfg))
                `uvm_error("ENV CONFIG","cannot get config data")
        if(e_cfg.has_agent) begin
                s_top=spi_agent_top::type_id::create("s_top",this);
                sl_top=slave_agent_top::type_id::create("sl_top",this);
        end

        vseqrh=spi_virtual_sequencer::type_id::create("vseqrh",this);
endfunction

////////// connect phase //////////////
function void spi_env::connect_phase(uvm_phase phase);
        if(e_cfg.has_agent) begin
                vseqrh.m_seqrh=s_top.s_agent.sequencer;
                vseqrh.s_seqrh=sl_top.sl_agent.sequencer;
        end
endfunction
