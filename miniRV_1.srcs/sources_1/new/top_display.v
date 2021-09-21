module top_display (
    input  wire       clk  ,
    input  wire       rst_n,
    
    output wire       led0_en,
    output wire       led1_en,
    output wire       led2_en,
    output wire       led3_en,
    output wire       led4_en,
    output wire       led5_en,
    output wire       led6_en,
    output wire       led7_en,
    output wire       led_ca ,
    output wire       led_cb ,
    output wire       led_cc ,
    output wire       led_cd ,
    output wire       led_ce ,
    output wire       led_cf ,
    output wire       led_cg ,
    output wire       led_dp 
);

 wire [31:0] pc;
 wire clk_led;

miniRV miniRV_u(clk,rst_n,pc);

divider divider1(clk,clk_led);

display u_display(clk_led,rst_n,pc,led0_en,led1_en,led2_en,led3_en,led4_en,led5_en,led6_en,led7_en,led_ca ,led_cb ,led_cc ,led_cd ,led_ce ,led_cf ,led_cg ,led_dp);

endmodule
