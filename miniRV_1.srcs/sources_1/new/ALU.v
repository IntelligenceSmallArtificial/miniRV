
module ALU(
    input rst_n,
    input ASel,
    input BSel,
    input [2:0] ALUSel,

    input [31:0] RegFile_data1,
    input [31:0] PC_pc,
    input [31:0] RegFile_data2,
    input [31:0] ImmGen_imm,
    
    output reg [31:0] result 
    );
wire [31:0] A;
assign A=ASel?PC_pc:RegFile_data1;

wire [31:0] B;
assign B=BSel?ImmGen_imm:RegFile_data2;

wire [31:0] B_addChoose;
assign B_addChoose=ALUSel[1]?(~B+1):B;

reg [1:0] decoder;
always@(*)begin
    if(!rst_n)
        decoder=2'b11;
    else begin
        case(ALUSel)   
            3'b000:decoder=2'b00;
            3'b010:decoder=2'b00;
            3'b111:decoder=2'b01;
            3'b110:decoder=2'b01;
            3'b100:decoder=2'b01;
            3'b001:decoder=2'b10;
            3'b101:decoder=2'b10;
            3'b011:decoder=2'b10;
            default:decoder=2'b11;
        endcase
    end
end

wire [31:0] add;
assign add=A+B_addChoose;

reg [31:0] logic_result;
always@(*)begin
    if(!rst_n)
        logic_result=32'b0;
    else begin
        case(ALUSel)   
            3'b111:logic_result=A&B;
            3'b110:logic_result=A|B;
            3'b100:logic_result=A^B;
            default:logic_result=32'b0;
        endcase
    end
end

wire [4:0] shift_bit;
assign shift_bit=B[4:0];

reg [31:0] shift_temp0;
reg [31:0] shift_temp1;
reg [31:0] shift_temp2;
reg [31:0] shift_temp3;
reg [31:0] shift_temp4;
wire [31:0] shift;
assign shift=shift_temp4;

always@(*)begin     //shift_temp0
    if(!rst_n)
        shift_temp0=32'b0;
    else begin
        case(ALUSel)   
            3'b001:begin    //¬ﬂº≠◊Û“∆
                shift_temp0=shift_bit[0]?{A[30:0],1'b0}:A;
            end
         
            3'b101:begin    //¬ﬂº≠”““∆
                shift_temp0=shift_bit[0]?{1'b0,A[31:1]}:A;
            end
         
            3'b011:begin    //À„ ˝”““∆
                shift_temp0=shift_bit[0]?{A[31],A[31:1]}:A;
            end
            default:shift_temp0=32'b0;
         endcase
     end
end

always@(*)begin     //shift_temp1
    if(!rst_n)
        shift_temp1=32'b0;
    else begin
        case(ALUSel)   
            3'b001:begin    //¬ﬂº≠◊Û“∆
                shift_temp1=shift_bit[1]?{shift_temp0[29:0],2'b0}:shift_temp0;
            end
         
            3'b101:begin    //¬ﬂº≠”““∆
                shift_temp1=shift_bit[1]?{2'b0,shift_temp0[31:2]}:shift_temp0;
            end
         
            3'b011:begin    //À„ ˝”““∆
                shift_temp1=shift_bit[1]?{shift_temp0[31],shift_temp0[31],shift_temp0[31:2]}:shift_temp0;
            end
            default:shift_temp1=32'b0;
         endcase
    end
end

always@(*)begin     //shift_temp2
    if(!rst_n)
        shift_temp2=32'b0;
    else begin
        case(ALUSel)   
            3'b001:begin    //¬ﬂº≠◊Û“∆
                shift_temp2=shift_bit[2]?{shift_temp1[27:0],4'b0}:shift_temp1;
            end
         
            3'b101:begin    //¬ﬂº≠”““∆
                shift_temp2=shift_bit[2]?{4'b0,shift_temp1[31:4]}:shift_temp1;
            end
         
            3'b011:begin    //À„ ˝”““∆
                shift_temp2=shift_bit[2]?{shift_temp1[31],shift_temp1[31],shift_temp1[31],shift_temp1[31],
                                               shift_temp1[31:4]}:shift_temp1;
            end
            default:shift_temp2=32'b0;
         endcase
      end
end

always@(*)begin     //shift_temp3
    if(!rst_n)
        shift_temp3=32'b0;
    else begin
        case(ALUSel)   
            3'b001:begin    //¬ﬂº≠◊Û“∆
                shift_temp3=shift_bit[3]?{shift_temp2[23:0],8'b0}:shift_temp2;
            end
         
            3'b101:begin    //¬ﬂº≠”““∆
                shift_temp3=shift_bit[3]?{8'b0,shift_temp2[31:8]}:shift_temp2;
            end
         
            3'b011:begin    //À„ ˝”““∆
                shift_temp3=shift_bit[3]?{shift_temp2[31],shift_temp2[31],shift_temp2[31],shift_temp2[31],
                                         shift_temp2[31],shift_temp2[31],shift_temp2[31],shift_temp2[31],
                                         shift_temp2[31:8]}:shift_temp2;
            end
            default:shift_temp3=32'b0;
         endcase
     end
end


always@(*)begin     //shift_temp4
    if(!rst_n)
        shift_temp4=32'b0;
    else begin
        case(ALUSel)   
            3'b001:begin    //¬ﬂº≠◊Û“∆
                shift_temp4=shift_bit[4]?{shift_temp3[15:0],16'b0}:shift_temp3;
            end
         
            3'b101:begin    //¬ﬂº≠”““∆
                shift_temp4=shift_bit[4]?{16'b0,shift_temp3[31:16]}:shift_temp3;
            end
         
            3'b011:begin    //À„ ˝”““∆
                shift_temp4=shift_bit[4]?{shift_temp3[31],shift_temp3[31],shift_temp3[31],shift_temp3[31],
                                        shift_temp3[31],shift_temp3[31],shift_temp3[31],shift_temp3[31],
                                        shift_temp3[31],shift_temp3[31],shift_temp3[31],shift_temp3[31],
                                        shift_temp3[31],shift_temp3[31],shift_temp3[31],shift_temp3[31],
                                         shift_temp3[31:16]}:shift_temp3;
            end
            default:shift_temp4=32'b0;
         endcase
     end
end

always@(*)begin
    if(!rst_n)
        result=32'b0;
    else begin
        case(decoder)   
            3'b00:result=add;
            3'b01:result=logic_result;
            3'b10:result=shift;
            default:result=32'b0;
        endcase
    end
end


endmodule




