//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 10:45:45
// Design Name: 
// Module Name: Hazard
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


module Hazard(
    input clk,
    input rst_n,
    
    input [31:0] IF_IMem_inst,
    input [31:0] ID_IMem_inst,
    input [31:0] EX_IMem_inst,
    input [31:0] MEM_IMem_inst,
    input [31:0] WB_IMem_inst,
    
    input [31:0] EX_ALU_result,
    input [31:0] MEM_ALU_result,
    input [31:0] WB_ALU_result,
    
    input [31:0] MEM_DMem_dataR,
    input [31:0] WB_DMem_dataR,
    
    input [31:0] IF_NextPC_pc4,
    input [31:0] ID_NextPC_pc4,
    input [31:0] EX_NextPC_pc4,
    input [31:0] MEM_NextPC_pc4,
    input [31:0] WB_NextPC_pc4,
    
    output reg [4:0] pipeline_stop,   
    output reg [31:0] Hazard_data1,
    output reg [31:0] Hazard_data2,
    output Hazard_data1_choose,
    output Hazard_data2_choose,
    output reg EX_have_inst,
    output reg MEM_have_inst,
    output reg WB_have_inst
    );
    
//正在进行IF阶段的指令
wire [4:0] IF_rs1;
wire [4:0] IF_rs2;
wire [4:0] IF_rd;
wire [1:0] IF_rd_state;   //产生写回寄存器的数据的阶段 00不写回 01EX 10MEM 11 IF
//正在进行ID阶段的指令
wire [4:0] ID_rs1;
wire [4:0] ID_rs2;
wire [4:0] ID_rd;  
wire [1:0] ID_rd_state;   //产生写回寄存器的数据的阶段 00不写回 01EX 10MEM 11 IF
//正在进行EX阶段的指令
wire [4:0] EX_rd; 
wire [1:0] EX_rd_state;   //产生写回寄存器的数据的阶段 00不写回 01EX 10MEM 11 IF
//正在进行MEM阶段的指令
wire [4:0] MEM_rd; 
wire [1:0] MEM_rd_state;   //产生写回寄存器的数据的阶段 00不写回 01EX 10MEM 11 IF
//正在进行WB阶段的指令
wire [4:0] WB_rd;    
wire [1:0] WB_rd_state;   //产生写回寄存器的数据的阶段 00不写回 01EX 10MEM 11 IF

assign IF_rs1=(IF_IMem_inst[6:0]==7'b0110111||IF_IMem_inst[6:0]==7'b1101111)?5'b0:IF_IMem_inst[19:15];
assign IF_rs2=(IF_IMem_inst[6:0]==7'b0010011||IF_IMem_inst[6:0]==7'b0000011||IF_IMem_inst[6:0]==7'b1100111||IF_IMem_inst[6:0]==7'b0110111||IF_IMem_inst[6:0]==7'b1101111)?5'b0:IF_IMem_inst[24:20];  
assign IF_rd=(IF_IMem_inst[6:0]==7'b0100011||IF_IMem_inst[6:0]==7'b1100011)?5'b0:IF_IMem_inst[11:7];
assign IF_rd_state=(IF_rd==5'b00000)?2'b0:((IF_IMem_inst[6:0]==7'b1100111||IF_IMem_inst[6:0]==7'b1101111)?2'b11:((IF_IMem_inst[6:0]==7'b0000011)?2'b10:2'b01));

assign ID_rs1=(ID_IMem_inst[6:0]==7'b0110111||ID_IMem_inst[6:0]==7'b1101111)?5'b0:ID_IMem_inst[19:15];
assign ID_rs2=(ID_IMem_inst[6:0]==7'b0010011||ID_IMem_inst[6:0]==7'b0000011||ID_IMem_inst[6:0]==7'b1100111||ID_IMem_inst[6:0]==7'b0110111||ID_IMem_inst[6:0]==7'b1101111)?5'b0:ID_IMem_inst[24:20];
assign ID_rd=(ID_IMem_inst[6:0]==7'b0100011||ID_IMem_inst[6:0]==7'b1100011)?5'b0:ID_IMem_inst[11:7];
assign ID_rd_state=(ID_rd==5'b00000)?2'b0:((ID_IMem_inst[6:0]==7'b1100111||ID_IMem_inst[6:0]==7'b1101111)?2'b11:((ID_IMem_inst[6:0]==7'b0000011)?2'b10:2'b01));

assign MEM_rd=(MEM_IMem_inst[6:0]==7'b0100011||MEM_IMem_inst[6:0]==7'b1100011)?5'b0:MEM_IMem_inst[11:7];
assign MEM_rd_state=(MEM_rd==5'b00000)?2'b0:((MEM_IMem_inst[6:0]==7'b1100111||MEM_IMem_inst[6:0]==7'b1101111)?2'b11:((MEM_IMem_inst[6:0]==7'b0000011)?2'b10:2'b01));

assign EX_rd=(EX_IMem_inst[6:0]==7'b0100011||EX_IMem_inst[6:0]==7'b1100011)?5'b0:EX_IMem_inst[11:7];
assign EX_rd_state=(EX_rd==5'b00000)?2'b0:((EX_IMem_inst[6:0]==7'b1100111||EX_IMem_inst[6:0]==7'b1101111)?2'b11:((EX_IMem_inst[6:0]==7'b0000011)?2'b10:2'b01));
    
assign WB_rd=(WB_IMem_inst[6:0]==7'b0100011||WB_IMem_inst[6:0]==7'b1100011)?5'b0:WB_IMem_inst[11:7];
assign WB_rd_state=(WB_rd==5'b00000)?2'b0:((WB_IMem_inst[6:0]==7'b1100111||WB_IMem_inst[6:0]==7'b1101111)?2'b11:((WB_IMem_inst[6:0]==7'b0000011)?2'b10:2'b01));
    
always@(*) begin
    if(!rst_n||ID_rs1==5'b0)
        Hazard_data1=32'b0;
    else if(ID_rs1==EX_rd)
        Hazard_data1=(EX_rd_state==2'b01)?EX_ALU_result:EX_NextPC_pc4;
    else if(ID_rs1==MEM_rd)
        Hazard_data1=(MEM_rd_state==2'b01)?MEM_ALU_result:((MEM_rd_state==2'b10)?MEM_DMem_dataR:MEM_NextPC_pc4);
    else if(ID_rs1==WB_rd)
        Hazard_data1=(WB_rd_state==2'b01)?WB_ALU_result:((WB_rd_state==2'b10)?WB_DMem_dataR:WB_NextPC_pc4);
    else
        Hazard_data1=32'b0;
end
    
always@(*) begin
    if(!rst_n||ID_rs2==5'b0)
        Hazard_data2=32'b0;
    else if(ID_rs2==EX_rd)
        Hazard_data2=(EX_rd_state==2'b01)?EX_ALU_result:EX_NextPC_pc4;
    else if(ID_rs2==MEM_rd)
        Hazard_data2=(MEM_rd_state==2'b01)?MEM_ALU_result:((MEM_rd_state==2'b10)?MEM_DMem_dataR:MEM_NextPC_pc4);
    else if(ID_rs2==WB_rd)
        Hazard_data2=(WB_rd_state==2'b01)?WB_ALU_result:((WB_rd_state==2'b10)?WB_DMem_dataR:WB_NextPC_pc4);
    else
        Hazard_data2=32'b0;
end  
    
assign Hazard_data1_choose=((ID_rs1==EX_rd)||(ID_rs1==MEM_rd)||(ID_rs1==WB_rd))&&(ID_rs1!=5'b0);
assign Hazard_data2_choose=((ID_rs2==EX_rd)||(ID_rs2==MEM_rd)||(ID_rs2==WB_rd))&&(ID_rs2!=5'b0);

wire lw_stop_judge;
assign lw_stop_judge=(ID_IMem_inst[6:0]==7'b0000011)&&((IF_rs1==ID_rd)||(IF_rs2==ID_rd))&&(ID_rd!=5'b0);

reg last_lw_stop_judge;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        last_lw_stop_judge<=0;
    else 
        last_lw_stop_judge<=lw_stop_judge;
end

wire [4:0] end_pipeline_stop;
assign end_pipeline_stop=(IF_IMem_inst[6:0]==7'b1100111||IF_IMem_inst[6:0]==7'b1101111||IF_IMem_inst[6:0]==7'b1100011)?5'b11000:((lw_stop_judge)?5'b10000:5'b00000);

reg [4:0] last_pipeline_stop;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        last_pipeline_stop<=5'b00000;
    else 
        last_pipeline_stop<=pipeline_stop;
end

always@(*)begin
    if(!rst_n)
        pipeline_stop=5'b00000;
    else if(end_pipeline_stop==last_pipeline_stop)
        pipeline_stop=5'b00000;
    else if(end_pipeline_stop==5'b10000&&last_pipeline_stop==5'b00000)
        pipeline_stop=5'b10000;
    else if(end_pipeline_stop==5'b11000&&last_pipeline_stop==5'b00000)
        pipeline_stop=5'b10000;
    else if(end_pipeline_stop==5'b11000&&last_pipeline_stop==5'b10000)
        pipeline_stop=5'b11000;
    else
        pipeline_stop=5'b00000;
end

wire IF_have_inst;
reg ID_have_inst;

assign IF_have_inst=(last_pipeline_stop==5'b0&&IF_IMem_inst!=32'b0&&lw_stop_judge==0)||(last_pipeline_stop!=5'b0&&IF_IMem_inst!=32'b0&&last_lw_stop_judge);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ID_have_inst<=0;
    else
        ID_have_inst<=IF_have_inst;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        EX_have_inst<=0;
    else
        EX_have_inst<=ID_have_inst;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        MEM_have_inst<=0;
    else
        MEM_have_inst<=EX_have_inst;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        WB_have_inst<=0;
    else
        WB_have_inst<=MEM_have_inst;
end

endmodule
