class slave_xtn extends uvm_sequence_item;
`uvm_object_utils(slave_xtn)

bit [127:0] mosi_reg;
rand bit [127:0] miso_reg;
bit [31:0] ss_pad_o;
bit sclk_pad_o;

extern function new(string name="slave_xtn");
extern function void do_print(uvm_printer printer);
endclass

/////////////// constructor /////////////
function slave_xtn::new(string name="slave_xtn");
        super.new(name);
endfunction

/////////// print /////////////////////
function void slave_xtn::do_print(uvm_printer printer);

        super.do_print(printer);

        printer.print_field("mosi_reg",         this.mosi_reg,          128,            UVM_DEC         );

        printer.print_field("miso_reg",         this.miso_reg,          128,            UVM_DEC         );

        printer.print_field("ss_pad_o",         this.ss_pad_o,          32,             UVM_DEC         );

        printer.print_field("sclk_pad_o",       this.sclk_pad_o,        1,              UVM_DEC         );
endfunction
