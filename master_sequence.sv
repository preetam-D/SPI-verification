class spi_sequence extends uvm_sequence#(spi_xtn);
`uvm_object_utils(spi_sequence)

extern function new(string name="spi_sequence");
endclass

/////////// constructor ///////////
function spi_sequence::new(string name="spi_sequence");
        super.new(name);
endfunction



//////// m_seq1 //////////////
class m_seq1 extends spi_sequence;
`uvm_object_utils(m_seq1)

bit [31:0] ctr;
//if(!uvm_config_db#(bit[31:0])#get(null,get_full_name(),"bit[31:0]",ctr))
//      `uvm_fatal("MASTER SEQ","cannot get ctrl value from test")

extern function new(string name="m_seq1");
extern task body();
endclass


////////// m_seq1 constructor /////////////
function m_seq1::new(string name="m_seq1");
        super.new(name);
endfunction


/////// m_seq1 body task //////////////
task m_seq1::body();
        req=spi_xtn::type_id::create("req");

if(!uvm_config_db#(bit[31:0])::get(null,get_full_name(),"bit[31:0]",ctr))
         `uvm_fatal("MASTER SEQ","cannot get ctrl value from test")

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h00;wb_we_i==1;wb_dat_i==32'd40;});
        `uvm_info("Tx0 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h04;wb_we_i==1;wb_dat_i==32'd0;});
        `uvm_info("Tx1 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h08;wb_we_i==1;wb_dat_i==32'd0;});
        `uvm_info("Tx2 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h0c;wb_we_i==1;wb_dat_i==32'd0;});
        `uvm_info("Tx3 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h14;wb_we_i==1;wb_dat_i==32'd1;});
        `uvm_info("DIVIDER",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h18;wb_we_i==1;wb_dat_i[7:0]==8'b0000_0010;wb_dat_i[31:8]=='0;});
        `uvm_info("SLAVE SELECT",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h10;wb_we_i==1;wb_dat_i==ctr;});
         `uvm_info("CTRL",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

         start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h00;wb_we_i==0;});
        `uvm_info("Rx0 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h04;wb_we_i==0;});
        `uvm_info("Rx1 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h08;wb_we_i==0;});
        `uvm_info("Rx2 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

        start_item(req);
        assert(req.randomize() with {wb_adr_i==5'h0c;wb_we_i==1;});
        `uvm_info("Rx3 REG",$sformatf("m_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);


endtask

