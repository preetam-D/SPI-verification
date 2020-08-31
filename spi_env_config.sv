class spi_env_cfg extends uvm_object;
`uvm_object_utils(spi_env_cfg)


int has_agent=1;
int scoreboard=1;

master_agent_cfg m_cfg;
slave_agent_cfg s_cfg;

extern function new(string name="spi_env_cfg");

endclass

//////////////// constructor //////////////////////
function spi_env_cfg::new(string name="spi_env_cfg");
        super.new(name);
endfunction
