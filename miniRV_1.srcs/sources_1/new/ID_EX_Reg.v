//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 08:58:25
// Design Name: 
// Module Name: ID_EX_Reg
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


module ID_EX_Reg(
    input clk,
    input rst_n,
    input pipeline_stop,
    
    input [31:0] ID_NextPC_pc4,
    input [31:0] ID_PC_pc,
    input [31:0] ID_IMem_inst,
    
    input [31:0] ID_RegFile_data1,
    input [31:0] ID_RegFile_data2,
    input [31:0] ID_ImmGen_imm,
    
    input ID_PCSel,
    input ID_RegWEn,
    input [1:0] ID_WBSel,
    input ID_ASel,
    input ID_BSel,
    input [2:0] ID_ALUSel,
    input ID_MemRW,
    
    output reg [31:0] EX_NextPC_pc4,
    output reg [31:0] EX_PC_pc,
    output reg [31:0] EX_IMem_inst,
    
    output reg [31:0] EX_RegFile_data1,
    output reg [31:0] EX_RegFile_data2,
    output reg [31:0] EX_ImmGen_imm,
    
    output reg EX_PCSel,
    output reg EX_RegWEn,
    output reg [1:0] EX_WBSel,
    output reg EX_ASel,
    output reg EX_BSel,
    output reg [2:0] EX_ALUSel,
    output reg EX_MemRW
    );
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_RegFile_data1<=32'b0;
    else if(pipeline_stop)
        EX_RegFile_data1<=EX_RegFile_data1;
    else
        EX_RegFile_data1<=ID_RegFile_data1;
end   
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_RegFile_data2<=32'b0;
    else if(pipeline_stop)
        EX_RegFile_data2<=EX_RegFile_data2;
    else
        EX_RegFile_data2<=ID_RegFile_data2;
end  

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_ImmGen_imm<=32'b0;
    else if(pipeline_stop)
        EX_ImmGen_imm<=EX_ImmGen_imm;
    else
        EX_ImmGen_imm<=ID_ImmGen_imm;
end  

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_RegWEn<=1'b0;
    else if(pipeline_stop)
        EX_RegWEn<=EX_RegWEn;
    else
        EX_RegWEn<=ID_RegWEn;
end  

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_PCSel<=1'b0;
    else if(pipeline_stop)
        EX_PCSel<=EX_PCSel;
    else
        EX_PCSel<=ID_PCSel;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_WBSel<=2'b0;
    else if(pipeline_stop)
        EX_WBSel<=EX_WBSel;
    else
        EX_WBSel<=ID_WBSel;
end 
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_ASel<=1'b0;
    else if(pipeline_stop)
        EX_ASel<=EX_ASel;
    else
        EX_ASel<=ID_ASel;
end 
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_BSel<=1'b0;
    else if(pipeline_stop)
        EX_BSel<=EX_BSel;
    else
        EX_BSel<=ID_BSel;
end     

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_ALUSel<=3'b0;
    else if(pipeline_stop)
        EX_ALUSel<=EX_ALUSel;
    else
        EX_ALUSel<=ID_ALUSel;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_MemRW<=1'b0;
    else if(pipeline_stop)
        EX_MemRW<=EX_MemRW;
    else
        EX_MemRW<=ID_MemRW;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_NextPC_pc4<=32'b0;
    else if(pipeline_stop)
        EX_NextPC_pc4<=EX_NextPC_pc4;
    else
        EX_NextPC_pc4<=ID_NextPC_pc4;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_PC_pc<=32'b0;
    else if(pipeline_stop)
        EX_PC_pc<=EX_PC_pc;
    else
        EX_PC_pc<=ID_PC_pc;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        EX_IMem_inst<=32'b0;
    else if(pipeline_stop)
        EX_IMem_inst<=EX_IMem_inst;
    else
        EX_IMem_inst<=ID_IMem_inst;
end 

endmodule
