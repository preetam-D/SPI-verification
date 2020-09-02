`uvm_object_utils(slave_sequence)

extern function new(string name="slave_sequence");
//extern task body();

endclass


/////////// constructor ////////////////
function slave_sequence::new(string name="slave_sequence");
        super.new(name);
endfunction

//////////////// slave seq1 /////////////////
class slave_seq1 extends slave_sequence;
`uvm_object_utils(slave_seq1)

extern function new(string name="slave_seq1");
extern task body();

endclass

////////// slave seq1 constructor ///////////
function slave_seq1::new(string name="slave_seq1");
        super.new(name);
endfunction

////// body task ////////////////
task slave_seq1::body();
        req=slave_xtn::type_id::create("req");

        start_item(req);
        req.randomize() with {miso_reg == 20;};
        `uvm_info("MISO REG",$sformatf("s_seq1 \n%s",req.sprint()),UVM_MEDIUM)
        finish_item(req);

endtask
