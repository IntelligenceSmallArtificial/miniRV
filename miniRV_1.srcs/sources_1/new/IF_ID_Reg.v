//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 08:56:58
// Design Name: 
// Module Name: IF_ID_Reg
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


module IF_ID_Reg(  
    input clk,
    input rst_n, 
    input pipeline_stop,
    
    input [31:0] IF_IMem_inst,
    input [31:0] IF_PC_pc,
    input [31:0] IF_NextPC_pc4,
    
    output reg [31:0] ID_IMem_inst,
    output reg [31:0] ID_PC_pc,
    output reg [31:0] ID_NextPC_pc4
    
    );
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        ID_IMem_inst<=32'b0;
    else if(pipeline_stop)
        ID_IMem_inst<=ID_IMem_inst;
    else
        ID_IMem_inst<=IF_IMem_inst;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        ID_PC_pc<=32'b0;
    else if(pipeline_stop)
        ID_PC_pc<=ID_PC_pc;
    else
        ID_PC_pc<=IF_PC_pc;
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        ID_NextPC_pc4<=32'b0;
    else if(pipeline_stop)
        ID_NextPC_pc4<=ID_NextPC_pc4;
    else
        ID_NextPC_pc4<=IF_NextPC_pc4;
end

endmodule
