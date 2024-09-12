
`timescale 1ns/100ps

module tb_diferentialEquation();

    // Parameters
    parameter N_BITS    = 8;

    wire [N_BITS + 3 - 1 : 0] o_y    ; //! Output

    reg  [N_BITS - 1     : 0] i_x    ; //! Input

    reg                       i_reset; //! Reset
    reg                       clock  ; //! System clock


    //! Stimulus by initial
    initial begin: stimulus
        i_x          = {N_BITS{1'b0}};
        clock        = 1'b0          ;
        i_reset      = 1'b0          ;

        #100 i_reset = 1'b1          ;

        #100 i_x     = 4             ;
        #500 i_x     = 16            ;
        #500 i_x     = 0             ;
        #500 i_x     = 'hFF          ;
        #1000 $finish;
    end

    //! Clock generator
    always #5 clock = ~clock;

    //! Instance of diferentialEquation module
    diferentialEquation
        #(
            .N_BITS (N_BITS)
        )
        u_diferentialEquation
        (
            .o_y(o_y),
    
            .i_x(i_x),
            .i_reset(~i_reset),
            .clock(clock)
        );

endmodule // tb_diferentialEquation
