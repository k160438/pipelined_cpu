module pipemem ( mwmem,malu,mb,clock,mem_clock, resetn,dataout,
        out_port0,out_port1, out_port2, in_port0,in_port1, in_port2); // MEM stage
    //MEM 数据存取模块。其中包含对数据同步 RAM 的读写访问。 // 注意 mem_clock。
    //输入给该同步 RAM 的 mem_clock 信号，模块内定义为 ram_clk。
    //实验中可采用系统 clock 的反相信号作为 mem_clock 信号（亦即 ram_clk） ,
    //即留给信号半个节拍的传输时间，然后在 mem_clock 上沿时，读输出、或写输入。
    input mwmem, clock, mem_clock, resetn; 
    input [31:0] malu, mb;
    input [3:0] in_port0,in_port1, in_port2;
    output [31:0] dataout;
    wire [31:0] mmo, ioo;
    output [31:0] out_port0,out_port1, out_port2;
    assign write_datamem_enable = mwmem & ( ~ malu[7]); //注意
    assign write_io_output_reg_enable = mwmem & ( malu[7]); //注意

    mux2x32 mem_io_dataout_mux(mmo, ioo, malu[7], dataout);
    lpm_ram_dq_dram mem (malu[6:2], mem_clock, mb, write_datamem_enable, mmo);
    io_output_reg io_output_regx2 (malu,mb,write_io_output_reg_enable,
        mem_clock,resetn,out_port0,out_port1, out_port2);
    io_input_reg io_input_regx2(malu,mem_clock,ioo,in_port0,in_port1, in_port2);
endmodule