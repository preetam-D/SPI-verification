class spi_driver extends uvm_driver#(spi_xtn);
`uvm_component_utils(spi_driver)

virtual wb_interface.W_DRIV wb_vif;
master_agent_cfg agt_cfg;

extern function new(string name="spi_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive(spi_xtn xtn);
endclass

//////// constructor ///////////
function spi_driver::new(string name="spi_driver",uvm_component parent);
        super.new(name,parent);
endfunction

//////// build_phase ////////////
function void spi_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(master_agent_cfg)::get(this,"","master_agent_cfg",agt_cfg))
                `uvm_fatal("DRIVER","cannot get agent config data")


endfunction

/////// connect phase /////////
function void spi_driver::connect_phase(uvm_phase phase);
        wb_vif=agt_cfg.wb_vif;
endfunction

////// run phase /////////////
task spi_driver::run_phase(uvm_phase phase);
        @(wb_vif.wb_drv);
        wb_vif.wb_drv.wb_rst_i<=1'b1;
         repeat(2)
        @(wb_vif.wb_drv);
        wb_vif.wb_drv.wb_rst_i<=1'b0;
         wb_vif.wb_drv.wb_stb_i<=0;
        wb_vif.wb_drv.wb_cyc_i<=0;


        forever begin
                seq_item_port.get_next_item(req);
                drive(req);
                seq_item_port.item_done();
        end
endtask


////// drive task //////////////
task spi_driver::drive(spi_xtn xtn);
        @(wb_vif.wb_drv);
        wb_vif.wb_drv.wb_adr_i<=xtn.wb_adr_i;

        wb_vif.wb_drv.wb_dat_i<=xtn.wb_dat_i;
        wb_vif.wb_drv.wb_we_i<=xtn.wb_we_i;
        wb_vif.wb_drv.wb_sel_i<=4'b1111;
        wb_vif.wb_drv.wb_stb_i<=1;
        wb_vif.wb_drv.wb_cyc_i<=1;
$display("===============================================yyyyyyyyyyyyy=================");
        wait(wb_vif.wb_drv.wb_ack_o)
$display("-----------------------------------------------------------------------------");
        wb_vif.wb_drv.wb_stb_i<=0;
        wb_vif.wb_drv.wb_cyc_i<=0;

        if(xtn.wb_adr_i=='h10)
        begin
                wait(wb_vif.wb_drv.wb_int_o);
        end
         `uvm_info("MASTER DRIVER",$sformatf("printing from driver\n%s",xtn.sprint()),UVM_LOW)


endtask
