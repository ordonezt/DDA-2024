module top 
#(
    parameter NB_LEDS = 4,
    parameter NB_COUNTER = 32,
    parameter NB_SW = 4,
)
(
    output [NB_LEDS - 1 : 0] o_led  ,
    output [NB_LEDS - 1 : 0] o_led_b,
    output [NB_LEDS - 1 : 0] o_led_g,

    input  [NB_LEDS - 1 : 0] i_sw   ,
    input        i_reset,
    input        clock
);

    wire                    connect_counter_to_shift;
    wire [NB_LEDS - 1 : 0]  connect_shift_to_leds;

    count
    u_count
    #(
        .NB_COUNTER(NB_COUNTER),
        .NB_SW     (NB_SW-1   )
    )
    (
        .o_valid(connect_counter_to_shift),
        .i_sw   (i_sw[2:0]),
        .i_reset(~i_reset),
        .clock  (clock   ),
    );

    shiftReg
    u_shiftReg
    (
        .o_led  (connect_shift_to_leds),
        .i_valid(connect_counter_to_shift),
        .i_reset(~i_reset),
        .clock  (clock   )
    );

endmodule