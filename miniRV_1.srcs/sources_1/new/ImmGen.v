//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 15:12:36
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(
    input rst_n,
    
    input [2:0] ImmSel,
    
    input [31:0] IMem_inst,
    
    output reg [31:0] imm
    );
    
always@(*)begin
    if(!rst_n)
        imm = 32'b0;
    else if(IMem_inst[31]) begin
        case(ImmSel)
            3'b000:imm={20'b1111_1111_1111_1111_1111,IMem_inst[31:20]};
            3'b001:imm={20'b1111_1111_1111_1111_1111,IMem_inst[31:25],IMem_inst[11:7]};
            3'b010:imm={19'b1111_1111_1111_1111_111,IMem_inst[31],IMem_inst[7],IMem_inst[30:25],IMem_inst[11:8],1'b0};
            3'b011:imm={IMem_inst[31:12],12'b0};
            3'b100:imm={11'b111_1111_1111,IMem_inst[31],IMem_inst[19:12],IMem_inst[20],IMem_inst[30:21],1'b0};
            default:imm=32'b0;
        endcase
    end
    else begin
        case(ImmSel)
            3'b000:imm={20'b0,IMem_inst[31:20]};
            3'b001:imm={20'b0,IMem_inst[31:25],IMem_inst[11:7]};
            3'b010:imm={19'b0,IMem_inst[31],IMem_inst[7],IMem_inst[30:25],IMem_inst[11:8],1'b0};
            3'b011:imm={IMem_inst[31:12],12'b0};
            3'b100:imm={11'b0,IMem_inst[31],IMem_inst[19:12],IMem_inst[20],IMem_inst[30:21],1'b0};
            default:imm=32'b0;
        endcase
    end
end

endmodule
