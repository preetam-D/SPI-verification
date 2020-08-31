class spi_agent extends uvm_agent;
`uvm_component_utils(spi_agent)

master_agent_cfg agt_cfg;

spi_driver driver;
spi_monitor monitor;
spi_sequencer sequencer;

extern function new(string name="spi_agent",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

//////// constructor ///////////
function spi_agent::new(string name="spi_agent",uvm_component parent);
        super.new(name,parent);
endfunction

////// build phase //////////////
function void spi_agent::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(master_agent_cfg)::get(this,"","master_agent_cfg",agt_cfg))
                `uvm_fatal("SPI_AGENT","cannot get agent config data")

        monitor=spi_monitor::type_id::create("monitor",this);

        if(agt_cfg.is_active == UVM_ACTIVE)
        begin
                driver=spi_driver::type_id::create("driver",this);
                sequencer=spi_sequencer::type_id::create("sequencer",this);
        end
endfunction

////////// connect phase /////////////////////
function void spi_agent::connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction
