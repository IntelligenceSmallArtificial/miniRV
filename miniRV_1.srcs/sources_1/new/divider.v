/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/15 20:12:11
// Design Name: 
// Module Name: divider
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

module divider(
    input clk_i,
    output reg clk_o
);
    initial clk_o=clk_i;
    reg [16:0] cnt=17'd0;
    always @(posedge clk_i) begin
        if(cnt==17'd100000) begin
            cnt<=17'd0;
            clk_o<=~clk_o;
        end else
            cnt<=cnt+1;
    end
endmodule
