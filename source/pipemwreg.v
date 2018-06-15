module pipemwreg ( mwreg,mm2reg,mmo,malu,mrn,clock,resetn,
                wwreg,wm2reg,wmo,walu,wrn);
    // MEM/WB 流水线寄存器
    //MEM/WB 流水线寄存器模块，起承接 MEM 阶段和 WB 阶段的流水任务。
    //在 clock 上升沿时，将 MEM 阶段需传递给 WB 阶段的信息，锁存在 MEM/WB
    //流水线寄存器中，并呈现在 WB 阶段。
    input mwreg, mm2reg, clock, resetn;
    input [31:0] mmo, malu;
    input [4:0] mrn;
    wire mwreg, mm2reg, clock, resetn;
    wire [31:0] mmo, malu;
    wire [4:0] mrn;

    output wwreg, wm2reg;
    output [4:0] wrn;
    output [31:0] wmo, walu;
    reg  wwreg, wm2reg;
    reg [4:0] wrn;
    reg [31:0] wmo, walu;

   always @ (negedge resetn or posedge clock)
      if (resetn == 0) 
         begin
            walu       <= 32'b0;
            wmo        <= 32'b0;
            wrn        <=  5'b0;
            wwreg      <=  1'b0;
            wm2reg     <=  1'b0;
         end 
      else
         begin 
            walu       <= malu;
            wmo        <= mmo;
            wrn        <= mrn;
            wwreg      <= mwreg;
            wm2reg     <= mm2reg;
         end

endmodule