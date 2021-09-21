
module PC(
    input clk,
    input rst_n,
    input pipeline_stop,
    
    input [31:0] nextPC,
    
    output reg [31:0] pc
    );
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        pc<=32'hFFFF_FFFC;
    else if(pipeline_stop)
        pc<=pc;
    else
        pc<=nextPC;
end
endmodule
