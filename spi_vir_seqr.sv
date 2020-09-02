class spi_virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);
`uvm_component_utils(spi_virtual_sequencer)

spi_sequencer m_seqrh;
slave_sequencer s_seqrh;

spi_env_cfg e_cfg;

extern function new(string name="spi_virtual_sequencer",uvm_component parent);
extern function void build_phase(uvm_phase phase);
endclass

///////////// constructor //////////////
function spi_virtual_sequencer::new(string name="spi_virtual_sequencer",uvm_component parent);
        super.new(name,parent);
endfunction

/////// build phase ///////////////
function void spi_virtual_sequencer::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(spi_env_cfg)::get(this,"","spi_env_cfg",e_cfg))
                `uvm_fatal("VIRTUAL SEQUENCER","cannot get env config data")

        //seqrh=new[e_cfg.no_of_agent];

endfunction
