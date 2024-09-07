
module top
#(
    parameter NB_LEDS    = 4 ,
    parameter NB_COUNTER = 32,
    parameter NB_SW      = 4  
)
(
    output [NB_LEDS - 1 : 0] o_led  ,
    output [NB_LEDS - 1 : 0] o_led_b,
    output [NB_LEDS - 1 : 0] o_led_g,

    input  [NB_SW   - 1 : 0] i_sw   ,
    input                    i_reset,
    input                    clock 
);

    wire                   connect_c2Sr;
    wire [NB_LEDS - 1 : 0] connect_sr2leds;

    count
    #(
        .NB_COUNTER(NB_COUNTER),
        .NB_SW     (NB_SW-1   )
    )
    u_count
    (
        .o_valid(connect_c2Sr),
        .i_sw   (i_sw[NB_SW-2:0]),
        .i_reset(~i_reset ),
        .clock  (clock    ) 
    );

    shiftReg
    #(
        .NB_LEDS(NB_LEDS)
    )
    u_shiftReg 
    (
        .o_led  (connect_sr2leds),
        .i_valid(connect_c2Sr),
        .i_reset(~i_reset),
        .clock  (clock   )
    );

    assign o_led   = connect_sr2leds;
    assign o_led_b = (i_sw[3]) ? connect_sr2leds : 4'b0000        ;
    assign o_led_g = (i_sw[3]) ? 4'b0000         : connect_sr2leds;



endmodule