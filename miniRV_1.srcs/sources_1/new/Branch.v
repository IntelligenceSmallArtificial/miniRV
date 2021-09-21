//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 18:57:26
// Design Name: 
// Module Name: Branch
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


module Branch(
    input [31:0] A,
    input [31:0] B,
    output BrLt,
    output BrEq
    );
wire [31:0] gap;
assign gap = A-B;
assign BrLt=gap[31];
assign BrEq=(gap==32'b0);

endmodule
