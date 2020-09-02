class base_test extends uvm_test;
`uvm_component_utils(base_test)

spi_env s_envh;
spi_env_cfg e_cfg;

bit [31:0] data_in;     //ctrl reg data

master_agent_cfg m_cfg;
slave_agent_cfg s_cfg;

int has_agent=1;


extern function new(string name="base_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void config_spi();

endclass

//////////////constructor///////////////////////
function base_test::new(string name="base_test",uvm_component parent);
        super.new(name,parent);
endfunction


/////////// build_phase /////////////////////////
function void base_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
        s_envh=spi_env::type_id::create("s_envh",this);
        e_cfg=spi_env_cfg::type_id::create("e_cfg");


        config_spi();

        uvm_config_db#(spi_env_cfg)::set(this,"*","spi_env_cfg",e_cfg);
         uvm_config_db#(bit[31:0])::set(this,"*","bit[31:0]",data_in);
endfunction


///////////// config spi //////////////////////////////
function void base_test::config_spi();

                m_cfg=master_agent_cfg::type_id::create("m_cfg");

                m_cfg.is_active=UVM_ACTIVE;

                e_cfg.m_cfg=m_cfg;

                s_cfg=slave_agent_cfg::type_id::create("s_cfg");

                s_cfg.is_active=UVM_ACTIVE;

                e_cfg.s_cfg=s_cfg;

                data_in[6:0]=7'd8;data_in[7]=0;data_in[8]=1;data_in[10:9]=2'b01;data_in[11]=1;data_in[12]=1;data_in[13]=1;
                data_in[31:14]=0;

        if(!uvm_config_db#(virtual wb_interface)::get(this,"","vif0",m_cfg.wb_vif))
                `uvm_fatal("SPI TEST","cannot get virtual wishbone interface")

        if(!uvm_config_db#(virtual spi_interface)::get(this,"","vif1",s_cfg.spi_vif))
                `uvm_fatal("SPI TEST","cannot get virtual wishbone interface")

        e_cfg.has_agent=has_agent;

endfunction
