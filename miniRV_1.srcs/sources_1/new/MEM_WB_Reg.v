/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 08:59:38
// Design Name: 
// Module Name: MEM_WB_Reg
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


module MEM_WB_Reg(
    input clk,
    input rst_n,
    input pipeline_stop,
    
    input [31:0] MEM_NextPC_pc4,
    input [31:0] MEM_PC_pc,
    input [31:0] MEM_ALU_result,
    input [31:0] MEM_IMem_inst,
    
    input [31:0] MEM_DMem_dataR,

    input MEM_RegWEn,
    input [1:0] MEM_WBSel,
     
    output reg [31:0] WB_NextPC_pc4,
    output reg [31:0] WB_PC_pc,
    output reg [31:0] WB_ALU_result,
    output reg [31:0] WB_IMem_inst,
    
    output reg [31:0] WB_DMem_dataR,
    
    output reg WB_RegWEn,
    output reg [1:0] WB_WBSel
    );
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        WB_NextPC_pc4<=32'b0;
    else if(pipeline_stop)
        WB_NextPC_pc4<=WB_NextPC_pc4;
    else
        WB_NextPC_pc4<=MEM_NextPC_pc4;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        WB_ALU_result<=32'b0;
    else if(pipeline_stop)
        WB_ALU_result<=WB_ALU_result;
    else
        WB_ALU_result<=MEM_ALU_result;
end 
  
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        WB_DMem_dataR<=32'b0;
    else if(pipeline_stop)
        WB_DMem_dataR<=WB_DMem_dataR;
    else
        WB_DMem_dataR<=MEM_DMem_dataR;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        WB_RegWEn<=1'b0;
    else if(pipeline_stop)
        WB_RegWEn<=WB_RegWEn;
    else
        WB_RegWEn<=MEM_RegWEn;
end 
 
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        WB_WBSel<=2'b0;
    else if(pipeline_stop)
        WB_WBSel<=WB_WBSel;
    else
        WB_WBSel<=MEM_WBSel;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        WB_IMem_inst<=32'b0;
    else if(pipeline_stop)
        WB_IMem_inst<=WB_IMem_inst;
    else
        WB_IMem_inst<=MEM_IMem_inst;
end 

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        WB_PC_pc<=32'b0;
    else if(pipeline_stop)
        WB_PC_pc<=WB_PC_pc;
    else
        WB_PC_pc<=MEM_PC_pc;
end 

endmodule
