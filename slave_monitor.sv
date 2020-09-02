class slave_monitor extends uvm_monitor;
`uvm_component_utils(slave_monitor)

virtual spi_interface.S_MONI spi_vif;
slave_agent_cfg agt_cfg;
slave_xtn xtn;
bit [31:0] ctrl;

extern function new(string name="slave_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_slave();
endclass

/////// constructor /////////////////
function slave_monitor::new(string name="slave_monitor",uvm_component parent);
        super.new(name,parent);
endfunction

/////////// build phase ///////////
function void slave_monitor::build_phase(uvm_phase phase );
        super.build_phase(phase);

        if(!uvm_config_db#(slave_agent_cfg)::get(this,"","slave_agent_cfg",agt_cfg))
                `uvm_fatal("SLAVE MONITOR","cannot get agent config data")

         if(!uvm_config_db#(bit[31:0])::get(this,"","bit[31:0]",ctrl))
                `uvm_fatal("SLAVE MONITOR","cannot ctrl data from test")

endfunction

/////// connect phase /////////
function void slave_monitor::connect_phase(uvm_phase phase);
        spi_vif=agt_cfg.spi_vif;
endfunction

//////////////// run phase ///////////
task slave_monitor::run_phase(uvm_phase phase);
        xtn=slave_xtn::type_id::create("slave_xtn");
        forever collect_slave();
endtask


///////// collect_slave ///////////////////
task slave_monitor::collect_slave();
 if(ctrl[6:0]==0)        //128 bits character length
        begin
                if(ctrl[11])    //LSB
                  begin
                        for(int i=0;i<128;i++)
                        begin
                                if(ctrl[9])     //posedge clk
                                 fork
                                        begin
                                        @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                        begin
                                         @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;
                                        end
                                 join
                                else            //negedge clk
                                 fork
                                        begin
                                        @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                         begin
                                         @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;

                                        end
                                 join
                        end
                  end

                else

                  begin
                        for(int i=128;i>0;i--)
                        begin
                                if(ctrl[9])     //posedge clk
                                 fork
                                        begin
                                        @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                        begin
                                         @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;
                                        end
                                 join
                                else            //negedge clk
                                 fork
                                        begin
                                        @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                        begin
                                         @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;
                                        end
                                 join
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
                                 fork
                                        begin
                                        @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                        begin
                                         @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;
                                        end
                                 join
                                else            //negedge clk
                                 fork
                                        begin
                                        @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                        begin
                                         @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;
                                        end
                                 join
                        end
                  end

                else

                     begin
                        for(int i=ctrl[6:0];i>0;i--)
                        begin
                                if(ctrl[9])     //posedge clk
                                 fork
                                        begin
                                        @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                        begin
                                         @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;
                                        end
                                 join
                                else            //negedge clk
                                 fork
                                        begin
                                        @(negedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.miso_reg[i] = spi_vif.s_mon.miso_pad_o;
                                        end
                                        begin
                                         @(posedge spi_vif.s_mon.sclk_pad_o);
                                        xtn.mosi_reg[i] = spi_vif.s_mon.mosi_pad_o;
                                        end
                                join
                        end
                  end
 end

`uvm_info("SLAVE MONITOR",$sformatf("printing from monitor\n%s",xtn.sprint()),UVM_LOW)

endtask
