/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 08:59:10
// Design Name: 
// Module Name: EX_MEM_Reg
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


module EX_MEM_Reg(
    input clk,
    input rst_n,
    input pipeline_stop,
    
    input [31:0] EX_NextPC_pc4,
    input [31:0] EX_PC_pc,
    input [31:0] EX_IMem_inst,
    
    input [31:0] EX_ALU_result,
    input [31:0] EX_RegFile_data2,

    input EX_RegWEn,
    input [1:0] EX_WBSel,
    input EX_MemRW,
    
    output reg [31:0] MEM_NextPC_pc4,
    output reg [31:0] MEM_PC_pc,
    output reg [31:0] MEM_IMem_inst,
    
    output reg [31:0] MEM_ALU_result,
    output reg [31:0] MEM_RegFile_data2,
    
    output reg MEM_RegWEn,
    output reg [1:0] MEM_WBSel,
    output reg MEM_MemRW
    
    );
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_NextPC_pc4<=32'b0;
    else if(pipeline_stop)
        MEM_NextPC_pc4<=MEM_NextPC_pc4;
    else
        MEM_NextPC_pc4<=EX_NextPC_pc4;
end  
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_ALU_result<=32'b0;
    else if(pipeline_stop)
        MEM_ALU_result<=MEM_ALU_result;
    else
        MEM_ALU_result<=EX_ALU_result;
end  

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_RegFile_data2<=32'b0;
    else if(pipeline_stop)
        MEM_RegFile_data2<=MEM_RegFile_data2;
    else
        MEM_RegFile_data2<=EX_RegFile_data2;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_RegWEn<=1'b0;
    else if(pipeline_stop)
        MEM_RegWEn<=MEM_RegWEn;
    else
        MEM_RegWEn<=EX_RegWEn;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_WBSel<=2'b0;
    else if(pipeline_stop)
        MEM_WBSel<=MEM_WBSel;
    else
        MEM_WBSel<=EX_WBSel;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_MemRW<=1'b0;
    else if(pipeline_stop)
        MEM_MemRW<=MEM_MemRW;
    else
        MEM_MemRW<=EX_MemRW;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_IMem_inst<=32'b0;
    else if(pipeline_stop)
        MEM_IMem_inst<=MEM_IMem_inst;
    else
        MEM_IMem_inst<=EX_IMem_inst;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        MEM_PC_pc<=32'b0;
    else if(pipeline_stop)
        MEM_PC_pc<=MEM_PC_pc;
    else
        MEM_PC_pc<=EX_PC_pc;
end 

endmodule
