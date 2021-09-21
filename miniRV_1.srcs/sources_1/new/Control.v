//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 18:58:37
// Design Name: 
// Module Name: Control
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


module Control(
    input rst_n,
    
    input BrLt,
    input BrEq,
    
    input [31:0] inst,
    
    output PCSel,
    output RegWEn,
    output reg [2:0] ImmSel,
    output [1:0] WBSel,
    output ASel,
    output BSel,
    output reg [2:0] ALUSel,
    output MemRW
    );
    
wire [6:0] funct7 = inst[31:25];
wire [2:0] funct3 = inst[14:12];
wire [6:0] opcode = inst[6:0];

wire lw = (opcode==7'b0000011);
wire jalr = (opcode==7'b1100111);
wire common_I = (ImmSel==3'b000)&&(lw==0)&&(jalr==0);

assign PCSel = jalr||(ImmSel==3'b100)||(ImmSel==3'b010&&((funct3==3'b000&&BrEq)||(funct3==3'b001&&!BrEq)||(funct3==3'b100&&BrLt)||(funct3==3'b101&&!BrLt)));

assign RegWEn = (ImmSel==3'b000)||(ImmSel==3'b011)||(ImmSel==3'b100)||(ImmSel==3'b111);

always@(*) begin //ImmSel
    if(!rst_n)
        ImmSel=3'b111;
    else begin
        case(opcode)
            7'b0110011:ImmSel=3'b111;
            7'b0010011:ImmSel=3'b000;
            7'b0000011:ImmSel=3'b000;
            7'b1100111:ImmSel=3'b000;
            7'b0100011:ImmSel=3'b001;
            7'b1100011:ImmSel=3'b010;
            7'b0110111:ImmSel=3'b011;
            7'b1101111:ImmSel=3'b100;
            default:ImmSel=3'b111;
        endcase
    end
end
   
assign WBSel = lw?2'b00:((jalr||ImmSel==3'b100)?2'b10:2'b01);

assign ASel = (ImmSel==3'b010)||(ImmSel==3'b100);

assign BSel = !(ImmSel==3'b111);

always@(*) begin // ALUSel
    if(!rst_n) begin
        ALUSel = 3'b000;
    end
    else if(funct7[5]&&(ImmSel==3'b111)&&(funct3==3'b000)) begin //sub
        ALUSel = 3'b010;
    end
    else if(funct7[5]&&(ImmSel==3'b111||ImmSel==3'b000)&&(funct3==3'b101)) begin //sra
        ALUSel = 3'b011;
    end
    else if(ImmSel==3'b111||common_I) begin 
        ALUSel = funct3;
    end
    else begin 
        ALUSel = 3'b000;
    end
end

assign MemRW = (ImmSel==3'b001);

endmodule
