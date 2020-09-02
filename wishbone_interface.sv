interface wb_interface(input bit clock);

 // Wishbone signals
  logic                            wb_clk_i;         // master clock logic
  logic                            wb_rst_i;         // synchronous active high reset
  logic                      [4:0] wb_adr_i;         // lower address bits
  logic                   [32-1:0] wb_dat_i;         // databus logic
  logic                  [32-1:0] wb_dat_o;         // databus logic
  logic                      [3:0] wb_sel_i;         // byte select logics
  logic                            wb_we_i;          // write enable logic
  logic                            wb_stb_i;         // stobe/core select signal
  logic                            wb_cyc_i;         // valid bus cycle logic
  logic                           wb_ack_o;         // bus cycle acknowledge logic
  logic                           wb_err_o;         // termination w/ error
  logic                           wb_int_o;         // interrupt request signal logic


 clocking wb_drv@(posedge clock);
        default input #1 output #1;
        output  wb_rst_i;
        output  wb_adr_i;
        output  wb_dat_i;
        output  wb_sel_i;
        output  wb_we_i;
        output  wb_stb_i;
        output  wb_cyc_i;

        input   wb_dat_o;
        input   wb_ack_o;
        input   wb_int_o;
        input   wb_err_o;
endclocking

clocking wb_mon@(posedge clock);
        default input #1 output #1;
        input   wb_rst_i;
        input   wb_adr_i;
        input   wb_dat_i;
        input   wb_dat_o;
        input   wb_ack_o;
        input   wb_int_o;
        input   wb_sel_i;
        input   wb_we_i;
endclocking

modport W_DRIV(clocking wb_drv);
modport W_MONI(clocking wb_mon);

endinterface
