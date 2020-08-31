`timescale 1ns/10ps
module top;

import uvm_pkg::*;
import spi_test_pkg::*;

`include "uvm_macros.svh"

bit clock;
always #5 clock=~clock;

wb_interface wb_if(clock);
spi_interface spi_if(clock);


//instantiation
// Wishbone signals
spi_top st1(    .wb_clk_i(clock),
                .wb_rst_i(wb_if.wb_rst_i),
                .wb_adr_i(wb_if.wb_adr_i),
                .wb_dat_i(wb_if.wb_dat_i),
                .wb_dat_o(wb_if.wb_dat_o),
                .wb_sel_i(wb_if.wb_sel_i),
                .wb_we_i(wb_if.wb_we_i),
                .wb_stb_i(wb_if.wb_stb_i),
                .wb_cyc_i(wb_if.wb_cyc_i),
                .wb_ack_o(wb_if.wb_ack_o),
                .wb_err_o(wb_if.wb_err_o),
                .wb_int_o(wb_if.wb_int_o),

  // SPI signals
                .ss_pad_o(spi_if.ss_pad_o),
                .sclk_pad_o(spi_if.sclk_pad_o),
                .mosi_pad_o(spi_if.mosi_pad_o),
                .miso_pad_i(spi_if.miso_pad_o)
        );
initial begin

        uvm_config_db#(virtual wb_interface)::set(null,"*","vif0",wb_if);
        uvm_config_db#(virtual spi_interface)::set(null,"*","vif1",spi_if);

        run_test();
end

endmodule
