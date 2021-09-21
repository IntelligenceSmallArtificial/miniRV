
module IMem(
    input [31:0] addr,
    output [31:0] inst
    );

    // 64KB IROM
    inst_mem U0_irom (
        .a      (addr[15:2]),   // input wire [13:0] a
        .spo    (inst)   // output wire [31:0] spo
    );

endmodule