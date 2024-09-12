
`timescale 1ns/100ps

module tb_diferentialEquation();

    // Parameters
    parameter N_BITS    = 16;

    wire signed [N_BITS - 1 : 0] o_dataC         ; //! Output

    reg  signed [N_BITS - 1 : 0] i_dataA, i_dataB; //! Data inputs

    reg         [2      - 1 : 0] i_sel           ; //! Selector

    //! Stimulus by initial
    initial begin: stimulus
    i_dataA      = {N_BITS{1'b0}};
    i_dataB      = {N_BITS{1'b0}};
    i_sel        = 2'b00;

    #10 i_dataA =  16'h1  ;
        i_dataB = -16'h4  ;

    #10 i_sel   =  2'h1   ;

    #10 i_sel   =  2'h2   ;

    #10 i_sel   =  2'h3   ;

    #10 $finish;
    end

    //! Instance of selector module
    selector
        #(
            .N_BITS (N_BITS)
        )
        u_selector
        (
            .o_dataC(o_dataC),

            .i_dataA(i_dataA), 
            .i_dataB(i_dataB),
            .i_sel  (i_sel)
        );

endmodule // tb_selector
