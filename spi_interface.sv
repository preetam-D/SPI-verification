`include "spi_defines.v"
interface spi_interface(input bit clock);


  // SPI signals
  logic          [`SPI_SS_NB-1:0] ss_pad_o;         // slave select
  logic                           sclk_pad_o;       // serial clock
  logic                           mosi_pad_o;       // master out slave in
  logic                            miso_pad_o;       // master in slave out

 clocking s_drv@(posedge clock);
        default input #1 output #1;
        output  miso_pad_o;
        input   sclk_pad_o;
        input   mosi_pad_o;
        input   ss_pad_o;
endclocking

clocking s_mon@(posedge clock);
        default input #1 output #1;
        input sclk_pad_o;
        input ss_pad_o;
        input mosi_pad_o;
        input miso_pad_o;

endclocking

modport S_DRIV(clocking s_drv);
modport S_MONI(clocking s_mon);

endinterface
