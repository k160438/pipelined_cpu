module pipeif ( pcsource,pc,bpc,da,jpc,npc,pc4,ins,rom_clock ); 

    input [31:0] pc, bpc, da, jpc;
    input rom_clock;
    input [1:0] pcsource;
    output [31:0] ins, pc4, npc;  

    assign pc4 = pc + 32'h4;
    lpm_rom_irom irom (pc[7:2],rom_clock,ins); 
    mux4x32 next_pc (pc4, bpc, da, jpc, pcsource, npc);
endmodule