`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 14:38:15
// Design Name: 
// Module Name: miniRV_sim
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


module miniRV_sim(
    
    );
reg clk_in=1;
reg rst_n=0;
miniRV miniRV_u(clk_in,rst_n);
always begin
    #1 clk_in=~clk_in;
end

initial begin
    #200 rst_n=1;
end





endmodule
