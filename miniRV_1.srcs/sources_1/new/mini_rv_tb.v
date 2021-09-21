//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/05 10:34:49
// Design Name: 
// Module Name: mini_rv_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module mini_rv_tb(
    input clk,
    input rst_n,
    output        debug_wb_have_inst,   // WB阶段是否有指令 (对单周期CPU，此flag恒为1)
    output [31:0] debug_wb_pc,          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
    output        debug_wb_ena,         // WB阶段的寄存器写使能 (若wb_have_inst=0，此项可为任意值)
    output [4:0]  debug_wb_reg,         // WB阶段写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output [31:0] debug_wb_value        // WB阶段写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)
);
wire clk_lock;
wire [4:0] pipeline_stop;
    
wire [31:0] IF_NextPC_pc4;
wire [31:0] ID_NextPC_pc4;
wire [31:0] EX_NextPC_pc4;
wire [31:0] MEM_NextPC_pc4;
wire [31:0] WB_NextPC_pc4;

wire [31:0] NextPC_nextPC;

wire [31:0] IF_PC_pc;
wire [31:0] ID_PC_pc;
wire [31:0] EX_PC_pc;
wire [31:0] MEM_PC_pc;
wire [31:0] WB_PC_pc;

wire [31:0] IF_IMem_inst;
wire [31:0] ID_IMem_inst;
wire [31:0] EX_IMem_inst;
wire [31:0] MEM_IMem_inst;
wire [31:0] WB_IMem_inst;

wire [31:0] ID_RegFile_data1;
wire [31:0] EX_RegFile_data1;

wire [31:0] ID_RegFile_data2;
wire [31:0] EX_RegFile_data2;
wire [31:0] MEM_RegFile_data2;

wire [31:0] ID_ImmGen_imm;
wire [31:0] EX_ImmGen_imm;

wire [31:0] EX_ALU_result;
wire [31:0] MEM_ALU_result;
wire [31:0] WB_ALU_result;

wire [31:0] MEM_DMem_dataR;
wire [31:0] WB_DMem_dataR;

wire ID_PCSel;
wire EX_PCSel;

wire ID_RegWEn;
wire EX_RegWEn;
wire MEM_RegWEn;
wire WB_RegWEn;

wire [2:0] ImmSel;

wire [1:0] ID_WBSel;
wire [1:0] EX_WBSel;
wire [1:0] MEM_WBSel;
wire [1:0] WB_WBSel;

wire BrLt;

wire BrEq;

wire ID_ASel;
wire EX_ASel;

wire ID_BSel;
wire EX_BSel;

wire [2:0] ID_ALUSel;
wire [2:0] EX_ALUSel;

wire ID_MemRW;
wire EX_MemRW;
wire MEM_MemRW;

wire [31:0] Hazard_data1;
wire [31:0] Hazard_data2;
wire Hazard_data1_choose;
wire Hazard_data2_choose;

wire EX_have_inst;
wire MEM_have_inst;
wire WB_have_inst;

NextPC NextPC_0(EX_have_inst,EX_PCSel,EX_ALU_result,IF_PC_pc,IF_NextPC_pc4,NextPC_nextPC);
PC PC_0(clk,rst_n,pipeline_stop[4],NextPC_nextPC,IF_PC_pc);
IMem IMem_0(IF_PC_pc,IF_IMem_inst);
RegFile RegFile_0(clk,rst_n,WB_have_inst,WB_RegWEn,WB_WBSel,WB_NextPC_pc4,WB_ALU_result,WB_DMem_dataR,ID_IMem_inst,WB_IMem_inst,
    Hazard_data1,Hazard_data2,Hazard_data1_choose,Hazard_data2_choose,ID_RegFile_data1,ID_RegFile_data2,debug_wb_reg,debug_wb_value,debug_wb_ena);
ImmGen ImmGen_0(rst_n,ImmSel,ID_IMem_inst,ID_ImmGen_imm);
Branch Branch_0(ID_RegFile_data1,ID_RegFile_data2,BrLt,BrEq);
ALU ALU_0(rst_n,EX_ASel,EX_BSel,EX_ALUSel,EX_RegFile_data1,EX_PC_pc,EX_RegFile_data2,EX_ImmGen_imm,EX_ALU_result);
DMem DMem_0(clk,MEM_have_inst,MEM_MemRW,MEM_ALU_result,MEM_RegFile_data2,MEM_DMem_dataR);
Control Control_0(rst_n,BrLt,BrEq,ID_IMem_inst,ID_PCSel,ID_RegWEn,ImmSel,ID_WBSel,ID_ASel,ID_BSel,ID_ALUSel,ID_MemRW);
IF_ID_Reg IF_ID_Reg_0(clk,rst_n,pipeline_stop[3],IF_IMem_inst,IF_PC_pc,IF_NextPC_pc4,ID_IMem_inst,ID_PC_pc,ID_NextPC_pc4);
ID_EX_Reg ID_EX_Reg_0(clk,rst_n,pipeline_stop[2],ID_NextPC_pc4,ID_PC_pc,ID_IMem_inst,ID_RegFile_data1,ID_RegFile_data2,
    ID_ImmGen_imm,ID_PCSel,ID_RegWEn,ID_WBSel,ID_ASel,ID_BSel,ID_ALUSel,ID_MemRW,EX_NextPC_pc4,EX_PC_pc,EX_IMem_inst,
    EX_RegFile_data1,EX_RegFile_data2,EX_ImmGen_imm,EX_PCSel,EX_RegWEn,EX_WBSel,EX_ASel,EX_BSel,EX_ALUSel,EX_MemRW);
EX_MEM_Reg EX_MEM_Reg_0(clk,rst_n,pipeline_stop[1],EX_NextPC_pc4,EX_PC_pc,EX_IMem_inst,EX_ALU_result,EX_RegFile_data2,EX_RegWEn,
    EX_WBSel,EX_MemRW,MEM_NextPC_pc4,MEM_PC_pc,MEM_IMem_inst,MEM_ALU_result,MEM_RegFile_data2,MEM_RegWEn,MEM_WBSel,MEM_MemRW);
MEM_WB_Reg MEM_WB_Reg_0(clk,rst_n,pipeline_stop[0],MEM_NextPC_pc4,MEM_PC_pc,MEM_ALU_result,MEM_IMem_inst,MEM_DMem_dataR,MEM_RegWEn,
    MEM_WBSel,WB_NextPC_pc4,WB_PC_pc,WB_ALU_result,WB_IMem_inst,WB_DMem_dataR,WB_RegWEn,WB_WBSel);
 Hazard Hazard_0(clk,rst_n,IF_IMem_inst,ID_IMem_inst,EX_IMem_inst,MEM_IMem_inst,WB_IMem_inst,EX_ALU_result,MEM_ALU_result,WB_ALU_result,
    MEM_DMem_dataR,WB_DMem_dataR,IF_NextPC_pc4,ID_NextPC_pc4,EX_NextPC_pc4,MEM_NextPC_pc4,WB_NextPC_pc4,pipeline_stop,
    Hazard_data1,Hazard_data2,Hazard_data1_choose,Hazard_data2_choose,EX_have_inst,MEM_have_inst,WB_have_inst);

assign  debug_wb_have_inst=WB_have_inst;           // WB阶段是否有指令 (对单周期CPU，此flag恒为1)
assign  debug_wb_pc=WB_PC_pc;      // WB阶段的PC (若wb_have_inst=0，此项可为任意值)

endmodule

