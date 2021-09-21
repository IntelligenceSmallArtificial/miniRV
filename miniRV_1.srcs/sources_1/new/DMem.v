/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 18:57:47
// Design Name: 
// Module Name: DMem
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

module DMem (
    input           clk,
    input           MEM_have_inst,
    input           MemRW,
    input   [31:0]  addr,     
    input   [31:0]  dataW,       
    output  [31:0]  dataR
);
wire MemRW_Handled;
assign MemRW_Handled=MemRW&&MEM_have_inst;

data_mem U_dram (
    .clk    (clk),            
    .a      (addr[15:2]),     
    .spo   (dataR),       
    .we     (MemRW_Handled),         
    .d      (dataW)         
);

endmodule
