class spi_sequencer extends uvm_sequencer#(spi_xtn);
`uvm_component_utils(spi_sequencer)

extern function new(string name="spi_sequencer",uvm_component parent);
extern function void build_phase(uvm_phase phase);
endclass


///// constructor ////////
function spi_sequencer::new(string name="spi_sequencer",uvm_component parent);
        super.new(name,parent);
endfunction

///// build phase //////
function void spi_sequencer::build_phase(uvm_phase phase);
        super.build_phase(phase);
endfunction
