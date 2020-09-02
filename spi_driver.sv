class slave_driver extends uvm_driver#(slave_xtn);
`uvm_component_utils(slave_driver)

virtual spi_interface.S_DRIV spi_vif;
slave_agent_cfg agt_cfg;
bit [31:0] ctrl;

extern function new(string name="slave_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive_s(slave_xtn xtn);
endclass

//////// constructor ///////////
function slave_driver::new(string name="slave_driver",uvm_component parent);
        super.new(name,parent);
endfunction

//////// build_phase ////////////
function void slave_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(slave_agent_cfg)::get(this,"","slave_agent_cfg",agt_cfg))
                `uvm_fatal("SLAVE DRIVER","cannot get agent config data")

        if(!uvm_config_db#(bit[31:0])::get(this,"","bit[31:0]",ctrl))
                `uvm_fatal("SLAVE DRIVER","cannot ctrl data from test")

endfunction

/////// connect phase /////////
function void slave_driver::connect_phase(uvm_phase phase);
        spi_vif=agt_cfg.spi_vif;
endfunction

////// run phase /////////////
task slave_driver::run_phase(uvm_phase phase);
        forever begin
        seq_item_port.get_next_item(req);
        drive_s(req);
        seq_item_port.item_done();
        end
endtask


/////// drive_s task /////////////////
task slave_driver::drive_s(slave_xtn xtn);

        if(ctrl[6:0]==0)        //128 bits character length
        begin
                if(ctrl[11])    //LSB
                  begin
                        for(int i=0;i<128;i++)
                        begin
                                if(ctrl[9])     //posedge clk
                                        begin
                                        @(posedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                                else            //negedge clk
                                        begin
                                        @(negedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                        end
                  end

                else

                  begin
                        for(int i=128;i>0;i--)
                        begin
                                  if(ctrl[9])     //posedge clk
                                        begin
                                        @(posedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                                else            //negedge clk
                                        begin
                                        @(negedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                        end
                  end
        end

        else            //character length from 1 to 127

        begin
                if(ctrl[11])    //LSB
                  begin
                        for(int i=0;i<ctrl[6:0];i++)
                        begin
                                if(ctrl[9])     //posedge clk
                                        begin
                                        @(posedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                                else            //negedge clk
                                        begin
                                        @(negedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                        end
                  end

                else

                  begin
                               for(int i=ctrl[6:0];i>0;i--)
                        begin
                                if(ctrl[9])     //posedge clk
                                        begin
                                        @(posedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                                else            //negedge clk
                                        begin
                                        @(negedge spi_vif.s_drv.sclk_pad_o);
                                        spi_vif.s_drv.miso_pad_o <= xtn.miso_reg[i];
                                        end
                        end
                  end
        end

`uvm_info("SLAVE DRIVER",$sformatf("printing from driver\n%s",xtn.sprint()),UVM_LOW)

endtask
