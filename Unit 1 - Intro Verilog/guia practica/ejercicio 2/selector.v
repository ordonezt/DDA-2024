module selector
#(
    parameter N_BITS = 16
)
(
    output signed [N_BITS - 1 : 0] o_dataC,
    
    input  signed [N_BITS - 1 : 0] i_dataA, 
    input  signed [N_BITS - 1 : 0] i_dataB,
    input         [2      - 1 : 0] i_sel
);

    assign o_dataC = (i_sel == 2'h0) ? i_dataA + i_dataB :
                     (i_sel == 2'h1) ? i_dataA - i_dataB :
                     (i_sel == 2'h2) ? i_dataA & i_dataB :
                                       i_dataA | i_dataB;

endmodule //selector
