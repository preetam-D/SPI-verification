class spi_monitor extends uvm_monitor;
`uvm_component_utils(spi_monitor)

virtual wb_interface.W_MONI wb_vif;
master_agent_cfg agt_cfg;
spi_xtn pkt;

extern function new(string name="spi_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
endclass

/////// constructor /////////////////
function spi_monitor::new(string name="spi_monitor",uvm_component parent);
        super.new(name,parent);
endfunction

/////////// build phase ///////////
function void spi_monitor::build_phase(uvm_phase phase );
        super.build_phase(phase);

        if(!uvm_config_db#(master_agent_cfg)::get(this,"","master_agent_cfg",agt_cfg))
                `uvm_fatal("MONITOR","cannot get agent config data")

endfunction

/////// connect phase /////////
function void spi_monitor::connect_phase(uvm_phase phase);
        wb_vif=agt_cfg.wb_vif;
endfunction


//////////////// run phase ///////////
task spi_monitor::run_phase(uvm_phase phase);
        pkt=spi_xtn::type_id::create("pkt");
         forever
                collect_data();
endtask

////////// collect data task ////////
task spi_monitor::collect_data();
        @(wb_vif.wb_mon);
        pkt.wb_adr_i=wb_vif.wb_mon.wb_adr_i;
        pkt.wb_dat_i=wb_vif.wb_mon.wb_dat_i;
        pkt.wb_we_i=wb_vif.wb_mon.wb_we_i;
        pkt.wb_dat_o=wb_vif.wb_mon.wb_dat_o;

        wait(wb_vif.wb_mon.wb_ack_o)
        if(wb_vif.wb_mon.wb_adr_i==5'h00 && wb_vif.wb_mon.wb_we_i==1)
                pkt.Tx0=wb_vif.wb_mon.wb_dat_i;

        if(wb_vif.wb_mon.wb_adr_i==5'h04 && wb_vif.wb_mon.wb_we_i==1)
                pkt.Tx1=wb_vif.wb_mon.wb_dat_i;

        if(wb_vif.wb_mon.wb_adr_i==5'h08 && wb_vif.wb_mon.wb_we_i==1)
                pkt.Tx2=wb_vif.wb_mon.wb_dat_i;

        if(wb_vif.wb_mon.wb_adr_i==5'h0c && wb_vif.wb_mon.wb_we_i==1)
                pkt.Tx3=wb_vif.wb_mon.wb_dat_i;

        if(wb_vif.wb_mon.wb_adr_i==5'h14 && wb_vif.wb_mon.wb_we_i==1)
                pkt.DIVIDER=wb_vif.wb_mon.wb_dat_i;

        if(wb_vif.wb_mon.wb_adr_i==5'h18 && wb_vif.wb_mon.wb_we_i==1)
                pkt.SS=wb_vif.wb_mon.wb_dat_i;

        if(wb_vif.wb_mon.wb_adr_i==5'h10 && wb_vif.wb_mon.wb_we_i==1)
                pkt.CTRL=wb_vif.wb_mon.wb_dat_i;

        if(wb_vif.wb_mon.wb_adr_i==5'h00 && wb_vif.wb_mon.wb_we_i==0)
                pkt.Rx0=wb_vif.wb_mon.wb_dat_o;
         if(wb_vif.wb_mon.wb_adr_i==5'h04 && wb_vif.wb_mon.wb_we_i==0)
                pkt.Rx1=wb_vif.wb_mon.wb_dat_o;

        if(wb_vif.wb_mon.wb_adr_i==5'h08 && wb_vif.wb_mon.wb_we_i==0)
                pkt.Rx2=wb_vif.wb_mon.wb_dat_o;

        if(wb_vif.wb_mon.wb_adr_i==5'h0c && wb_vif.wb_mon.wb_we_i==0)
                pkt.Rx3=wb_vif.wb_mon.wb_dat_o;

        `uvm_info("MASTER MON",$sformatf("printing from monitor\n%s",pkt.sprint()),UVM_LOW)

endtask
