module top 
#(
    parameter NUM_LEDS   = 4,
    parameter NUM_BITS   = 32
)
(
    output [NUM_LEDS - 1 : 0]   o_led  ,
    output [NUM_LEDS - 1 : 0]   o_led_b,
    output [NUM_LEDS - 1 : 0]   o_led_g,

    input  [4 - 1 : 0]          i_sw   ,
    input                       i_reset,
    input                       clock
);

    wire                    counterIsValid;
    wire [NUM_LEDS - 1 : 0] leds;

    counter
    #(
        .NUM_BITS(NUM_BITS)
    )
    u_counter
    (
        .o_compare(counterIsValid),

        .i_switch(i_sw[3-1 : 0]),
        .i_reset(~i_reset),
        .clock(clock)
    );
    
    shiftRegister
    #(
        .SHIFT_SIZE(NUM_LEDS)
    )
    u_shiftRegister
    (
        .o_shift(leds),
        .i_valid(counterIsValid),
        .i_reset(~i_reset),
        .clock(clock)
    );

    assign o_led = leds;
    assign o_led_b = (i_sw[4-1]==1'b0) ? leds : {NUM_LEDS{1'b0}};
    assign o_led_g = (i_sw[4-1]==1'b1) ? leds : {NUM_LEDS{1'b0}};

endmodule