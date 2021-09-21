//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 15:12:36
// Design Name: 
// Module Name: NextPC
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


module NextPC(
    input EX_have_inst,
    input PCSel,
    input [31:0] imm,
    input [31:0] pc,
    
    output  [31:0] pc4,
    output  [31:0] nextPC
    );
assign pc4=pc+4;
assign nextPC=PCSel&&EX_have_inst?imm:pc4;

endmodule
