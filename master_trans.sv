class spi_xtn extends uvm_sequence_item;
`uvm_object_utils(spi_xtn)

rand bit [31:0] wb_dat_i;
rand bit [4:0] wb_adr_i;
rand bit wb_we_i;

bit [31:0] wb_dat_o;

bit [31:0] Tx0,Tx1,Tx2,Tx3;
bit [31:0] Rx0,Rx1,Rx2,Rx3;

bit [31:0] CTRL;
bit [31:0] DIVIDER;
bit [31:0] SS;

extern function new(string name="spi_xtn");
extern function void do_print(uvm_printer printer);
endclass

////////// constructor /////////////
function spi_xtn::new(string name="spi_xtn");
        super.new(name);
endfunction

///////// do print ////////////
function void spi_xtn::do_print(uvm_printer printer);
        super.do_print(printer);

        printer.print_field("wb_adr_i",         this.wb_adr_i,          5,      UVM_DEC         );

        printer.print_field("wb_dat_i",         this.wb_dat_i,          32,     UVM_DEC         );

        printer.print_field("wb_we_i",          this.wb_we_i,           1,      UVM_DEC         );

        printer.print_field("wb_dat_o",         this.wb_dat_o,          32,     UVM_DEC         );
        
         printer.print_field("Tx0",              this.Tx0,               32,     UVM_DEC         );

        printer.print_field("Tx1",              this.Tx1,               32,     UVM_DEC         );

        printer.print_field("Tx2",              this.Tx2,               32,     UVM_DEC         );

        printer.print_field("Tx3",              this.Tx3,               32,     UVM_DEC         );

        printer.print_field("Rx0",              this.Rx0,               32,     UVM_DEC         );

        printer.print_field("Rx1",              this.Rx1,               32,     UVM_DEC         );

        printer.print_field("Rx2",              this.Rx2,               32,     UVM_DEC         );

        printer.print_field("Rx3",              this.Rx3,               32,     UVM_DEC         );

        printer.print_field("CTRL",             this.CTRL,              32,     UVM_DEC         );

        printer.print_field("DIVIDER",          this.DIVIDER,           32,     UVM_DEC         );

        printer.print_field("SS",               this.SS,                32,     UVM_DEC         );

endfunction
