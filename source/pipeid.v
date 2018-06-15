module pipeid ( mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,
    wrn,wdi,ealu,malu,mmo,wwreg, flush, clock,resetn,
    bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,
    daluimm,da,db,dimm,drn,dshift,djal, djflush); 
    input mwreg, ewreg, em2reg, mm2reg, flush;
    input [4:0] mrn, wrn, ern;    //寄存器号
    input [31:0] dpc4, inst;
    input [31:0] wdi, ealu, malu, mmo;           //wdi 冒险写的内容
    input clock, resetn, wwreg;

    output [31:0] bpc, jpc, da,db, dimm;
    output [1:0] pcsource;
    output wpcir, dwreg, dm2reg, dwmem, daluimm, dshift, djal, djflush;
    output [3:0] daluc;  //id向exe的控制信号
    output [4:0] drn;

    wire [5:0] op, func;
    wire [4:0] rs, rt, rd;
    wire [31:0] qa, qb;
    //wire [15:0] ext16;
    wire [1:0] fwda, fwdb;
    wire regrt, sext, rsrtequ,e;
    assign func = inst[5:0];
    assign op = inst[31:26];
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign jpc = {dpc4[31:28],inst[25:0],1'b0,1'b0}; // j address 
    assign e = sext & inst[15];          // positive or negative sign at sext signal

    wire [15:0] imm = {16{e}};                // high 16 sign bit
    wire [31:0] sa = { 27'b0, inst[10:6] }; // extend to 32 bits from sa for shift instruction
    wire [31:0] offset = {imm[13:0],inst[15:0],1'b0,1'b0};   //offset(include sign extend)
    wire [31:0] dimm = {imm,inst[15:0]}; // sign extend to high 16

    assign bpc = dpc4 + offset;
    assign rsrtequ = ~|(da^db);             //beq, branch when 1

    pipecu id_cu (op, func, rsrtequ, rs, rt, mrn, ern, mm2reg, mwreg, em2reg, ewreg, flush,
            dwmem, dwreg, regrt, dm2reg, daluc, dshift, daluimm, pcsource, djal, sext, 
            fwda, fwdb, wpcir, djflush);    
    mux2x5 reg_wn (rd,rt,regrt,drn);
    regfile rf(rs, rt, wdi, wrn, wwreg, ~clock, resetn, qa, qb);
    mux4x32 alu_a (qa, ealu, malu, mmo, fwda, da);
    mux4x32 alu_b (qb, ealu, malu, mmo, fwdb, db);
endmodule