
module RegFile(
    input clk,
    input rst_n,
    input WB_have_inst,
    
    input RegWEn,
    input [1:0] WBSel,
    
    input [31:0] NextPC_pc4,
    input [31:0] ALU_result,    
    input [31:0] DMem_dataR, 
    input [31:0] IMem_inst,
    input [31:0] regW_inst,
    
    input [31:0] Hazard_data1,
    input [31:0] Hazard_data2,
    input Hazard_data1_choose,
    input Hazard_data2_choose,
    
    output reg [31:0] data1,
    output reg [31:0] data2,
    output [5:0] debug_wb_reg,
    output [31:0] debug_wb_value,
    output debug_wb_ena
    );
wire [31:0] x0;
reg [31:0] x1;
reg [31:0] x2;
reg [31:0] x3;
reg [31:0] x4;
reg [31:0] x5;
reg [31:0] x6;
reg [31:0] x7;
reg [31:0] x8;
reg [31:0] x9;
reg [31:0] x10;
reg [31:0] x11;
reg [31:0] x12;
reg [31:0] x13;
reg [31:0] x14;
reg [31:0] x15;
reg [31:0] x16;
reg [31:0] x17;
reg [31:0] x18;
reg [31:0] x19;
reg [31:0] x20;
reg [31:0] x21;
reg [31:0] x22;
reg [31:0] x23;
reg [31:0] x24;
reg [31:0] x25;
reg [31:0] x26;
reg [31:0] x27;
reg [31:0] x28;
reg [31:0] x29;
reg [31:0] x30;
reg [31:0] x31;
assign x0=32'b0;

wire [4:0] reg1=(IMem_inst[6:0]==7'b0110111)?5'b0:IMem_inst[19:15];
wire [4:0] reg2=IMem_inst[24:20];
wire [4:0] regW=regW_inst[11:7];

//data1
always@(*)begin
    if(Hazard_data1_choose)
        data1=Hazard_data1;
    else
    case(reg1) 
        5'b0:data1=x0;
        5'b1:data1=x1;
        5'b10:data1=x2;
        5'b11:data1=x3;
        5'b100:data1=x4;
        5'b101:data1=x5;
        5'b110:data1=x6;
        5'b111:data1=x7;
        5'b1000:data1=x8;
        5'b1001:data1=x9;
        5'b1010:data1=x10;
        5'b1011:data1=x11;
        5'b1100:data1=x12;
        5'b1101:data1=x13;
        5'b1110:data1=x14;
        5'b1111:data1=x15;
        5'b10000:data1=x16;
        5'b10001:data1=x17;
        5'b10010:data1=x18;
        5'b10011:data1=x19;
        5'b10100:data1=x20;
        5'b10101:data1=x21;
        5'b10110:data1=x22;
        5'b10111:data1=x23;
        5'b11000:data1=x24;
        5'b11001:data1=x25;
        5'b11010:data1=x26;
        5'b11011:data1=x27;
        5'b11100:data1=x28;
        5'b11101:data1=x29;
        5'b11110:data1=x30;
        5'b11111:data1=x31;
    endcase
end

//data2
always@(*)begin
    if(Hazard_data2_choose)
        data2=Hazard_data2;
    else
    case(reg2) 
        5'b0:data2=x0;
        5'b1:data2=x1;
        5'b10:data2=x2;
        5'b11:data2=x3;
        5'b100:data2=x4;
        5'b101:data2=x5;
        5'b110:data2=x6;
        5'b111:data2=x7;
        5'b1000:data2=x8;
        5'b1001:data2=x9;
        5'b1010:data2=x10;
        5'b1011:data2=x11;
        5'b1100:data2=x12;
        5'b1101:data2=x13;
        5'b1110:data2=x14;
        5'b1111:data2=x15;
        5'b10000:data2=x16;
        5'b10001:data2=x17;
        5'b10010:data2=x18;
        5'b10011:data2=x19;
        5'b10100:data2=x20;
        5'b10101:data2=x21;
        5'b10110:data2=x22;
        5'b10111:data2=x23;
        5'b11000:data2=x24;
        5'b11001:data2=x25;
        5'b11010:data2=x26;
        5'b11011:data2=x27;
        5'b11100:data2=x28;
        5'b11101:data2=x29;
        5'b11110:data2=x30;
        5'b11111:data2=x31;
    endcase
end

reg [31:0] dataW;
//mux
always@(*)begin
    case(WBSel) 
        2'b01:dataW=ALU_result;
        2'b00:dataW=DMem_dataR;
        2'b10:dataW=NextPC_pc4;
        default:dataW=32'b0;
    endcase
end

//WriteBack
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        x1<=32'b0;
        x2<=32'b0;
        x3<=32'b0;
        x4<=32'b0;
        x5<=32'b0;
        x6<=32'b0;
        x7<=32'b0;
        x8<=32'b0;
        x9<=32'b0;
        x10<=32'b0;
        x11<=32'b0;
        x12<=32'b0;
        x13<=32'b0;
        x14<=32'b0;
        x15<=32'b0;
        x16<=32'b0;
        x17<=32'b0;
        x18<=32'b0;
        x19<=32'b0;
        x20<=32'b0;
        x21<=32'b0;
        x22<=32'b0;
        x23<=32'b0;
        x24<=32'b0;
        x25<=32'b0;
        x26<=32'b0;
        x27<=32'b0;
        x28<=32'b0;
        x29<=32'b0;
        x30<=32'b0;
        x31<=32'b0;
    end
    else if(RegWEn&&WB_have_inst) begin
        case(regW) 
            5'b1:x1<=dataW;
            5'b10:x2<=dataW;
            5'b11:x3<=dataW;
            5'b100:x4<=dataW;
            5'b101:x5<=dataW;
            5'b110:x6<=dataW;
            5'b111:x7<=dataW;
            5'b1000:x8<=dataW;
            5'b1001:x9<=dataW;
            5'b1010:x10<=dataW;
            5'b1011:x11<=dataW;
            5'b1100:x12<=dataW;
            5'b1101:x13<=dataW;
            5'b1110:x14<=dataW;
            5'b1111:x15<=dataW;
            5'b10000:x16<=dataW;
            5'b10001:x17<=dataW;
            5'b10010:x18<=dataW;
            5'b10011:x19<=dataW;
            5'b10100:x20<=dataW;
            5'b10101:x21<=dataW;
            5'b10110:x22<=dataW;
            5'b10111:x23<=dataW;
            5'b11000:x24<=dataW;
            5'b11001:x25<=dataW;
            5'b11010:x26<=dataW;
            5'b11011:x27<=dataW;
            5'b11100:x28<=dataW;
            5'b11101:x29<=dataW;
            5'b11110:x30<=dataW;
            5'b11111:x31<=dataW;
        endcase
    end
end

assign debug_wb_reg=regW;
assign debug_wb_value=dataW;
assign debug_wb_ena=RegWEn&&WB_have_inst;
    
endmodule