module top_VIO_ILA 
(
    output [4 - 1 : 0]   o_led  ,
    output [4 - 1 : 0]   o_led_b,
    output [4 - 1 : 0]   o_led_g,

    input  [4 - 1 : 0]   i_sw   ,
    input                i_reset,
    input                clock
);

    wire [4 - 1 : 0] switches;
    wire             reset;

    wire [4 - 1 : 0] vio_switches;
    wire             vio_reset;

    assign switches = vio_mux_sel ? vio_switches : i_sw;
    assign reset    = vio_mux_sel ? vio_reset    : i_reset;

    top
        #(
            .NUM_LEDS(4),
            .NUM_BITS(32)
        )
        u_top
        (
            .o_led  (o_led  ),
            .o_led_b(o_led_b),
            .o_led_g(o_led_g),

            .i_sw   (switches),
            .i_reset(~reset),
            .clock(clock)
        );

    vio
        u_vio
        (
            .clk_0       (clock),

            .probe_in0_0 (o_led),
            .probe_in1_0 (o_led_b),
            .probe_in2_0 (o_led_g),
            
            .probe_out0_0(vio_mux_sel),
            .probe_out1_0(vio_reset),
            .probe_out2_0(vio_switches)
        );
    
    ila
        u_ila
        (
            .clk_0  (clock),
            .probe0_0(o_led)
        );

endmodule
