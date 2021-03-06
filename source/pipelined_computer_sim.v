// `timescale 10ns/10ns            // 仿真时间单位/时间精度
`timescale 1ps/1ps            // 仿真时间单位/时间精度

//
// （1）仿真时间单位/时间精度：数字必须为1、10、100
// （2）仿真时间单位：模块仿真时间和延时的基准单位
// （3）仿真时间精度：模块仿真时间和延时的精确程度，必须小于或等于仿真单位时间
//
//      时间单位：s/秒、ms/毫秒、us/微秒、ns/纳秒、ps/皮秒、fs/飞秒（10负15次方）。


module pipelined_computer_sim;

    reg           resetn_sim;
    reg           clock_50M_sim;
	reg           mem_clk_sim;
	reg    [3:0] in_port0_sim;
	reg    [3:0] in_port1_sim;

	 

    wire   [6:0]  hex0_sim,hex1_sim,hex2_sim,hex3_sim,hex4_sim,hex5_sim;
	wire          led0_sim,led1_sim,led2_sim,led3_sim;
	 
	       
//	 wire   [31:0]  in_port0_sim,in_port1_sim;
	 
	wire   [31:0]  pc_sim,inst_sim,aluout_sim,memout_sim, ealu_sim, malu_sim, walu_sim;
    wire           imem_clk_sim,dmem_clk_sim;
    wire   [31:0]  out_port0_sim,out_port1_sim, out_port2_sim;
    wire   [31:0]  mem_dataout_sim;            // to check data_mem output
    wire   [31:0]  data_sim;
    wire   [31:0]  io_read_data_sim;
	wire   [6:0]   hex0, hex1, hex2, hex3, hex4, hex5;    
   
    wire           wmem_sim;   // connect the cpu and dmem. 

//    pipelined_computer pipelined_computer_instance (resetn_sim, ~mem_clk_sim, mem_clk_sim, pc_sim, inst_sim, ealu_sim,malu_sim,walu_sim);
    pipelined_computer pipelined_computer_instance (resetn_sim,~mem_clk_sim, mem_clk_sim, pc_sim,inst_sim,ealu_sim,malu_sim,walu_sim, 
        out_port0_sim, out_port1_sim, out_port2_sim, in_port0_sim, in_port1_sim, hex0_sim, hex1_sim, hex2_sim, hex3_sim, hex4_sim, hex5_sim);	 
    // sc_computer    sc_computer_instance (resetn_sim,mem_clk_sim,//pc_sim,inst_sim,aluout_sim,memout_sim,
	//                                      // imem_clk_sim,dmem_clk_sim
    //                                        ,out_port0_sim,out_port1_sim,out_port2_sim, in_port0_sim,in_port1_sim,
	// 												  // mem_dataout_sim,data_sim,io_read_data_sim
    //                                            hex0, hex1, hex2, hex3, hex4, hex5                 );

									
	 initial
        begin
            clock_50M_sim = 1;
            while (1)
                #2  clock_50M_sim = ~clock_50M_sim;
        end

	   
	 initial
        begin
            mem_clk_sim = 1;
            while (1)
                #1  mem_clk_sim = ~ mem_clk_sim;
        end

	   	  
		  
		  
	 initial
        begin
            resetn_sim = 0;            // 低电平持续10个时间单位，后一直为1。
            while (1)
                #5 resetn_sim = 1;
        end
	 
	 initial
	     begin
		      in_port0_sim = 3;
			  in_port1_sim = 7;
		  end



	 
	 	  
		  
    initial
        begin
		  
          $display($time,"resetn=%b clock_50M=%b  mem_clk =%b", resetn_sim, clock_50M_sim, mem_clk_sim);
			 
			 # 125000 $display($time,"out_port0 = %b  out_port1 = %b ", out_port0_sim,out_port1_sim );

        end

endmodule 

