class spi_virtual_seqs extends uvm_sequence#(uvm_sequence_item);
`uvm_object_utils(spi_virtual_seqs)

spi_sequencer m_seqrh;
slave_sequencer s_seqrh;
spi_env_cfg e_cfg;
spi_virtual_sequencer vseqrh;

extern function new(string name="spi_virtual_seqs");
extern task body();
endclass

//////////////// constructor //////////////
function spi_virtual_seqs::new(string name="spi_virtual_seqs");
        super.new(name);
endfunction


///////// body task ////////
task spi_virtual_seqs::body();
        if(!uvm_config_db#(spi_env_cfg)::get(null,get_full_name,"spi_env_cfg",e_cfg))
                `uvm_fatal("VITUAL SEQS","cannot get env config data")

        //seqrh=new[e_cfg.no_of_agent];

        assert($cast(vseqrh,m_sequencer));

        //foreach(seqrh[i])
        m_seqrh = vseqrh.m_seqrh;
        s_seqrh = vseqrh.s_seqrh;
endtask


/////////////// vseq1 //////////////////
class vseq1 extends spi_virtual_seqs;
`uvm_object_utils(vseq1);
m_seq1 m1;
slave_seq1 s1;

extern function new(string name="vseq1");
extern task body();
endclass

/////// vseq1 constructor ///////////
function vseq1::new(string name="vseq1");
        super.new(name);
endfunction

////////// vseq1 body task ////////////
task vseq1::body();
        super.body();
        s1=slave_seq1::type_id::create("s1");
        m1=m_seq1::type_id::create("m1");

        fork
        m1.start(m_seqrh);
        s1.start(s_seqrh);
        join

endtask
