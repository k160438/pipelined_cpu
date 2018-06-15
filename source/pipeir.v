module pipeir ( pc4,ins,wpcir, jflush, clock,resetn,dpc4,inst, flush);
    input [31:0] pc4, ins;
    input wpcir, clock, resetn, jflush;
    output [31:0] dpc4, inst;
    output flush;
    wire jflush;
    reg flush;

    dffe32 pc (pc4, clock, resetn, wpcir, dpc4);
    dffe32 instruction (ins, clock, resetn, wpcir, inst);
    // dffe32 flush_a_cycle (jflush, clock, resetn, wpcir, flush);
   always @ (negedge resetn or posedge clock)
      if (resetn == 0) begin
         flush <= 0;
      end else begin
         if (wpcir == 1) flush <= jflush;
      end
endmodule