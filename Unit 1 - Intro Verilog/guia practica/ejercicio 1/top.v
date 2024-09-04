module 
(
    output [5:0] o_data    ,
    output       o_overflow,
    
    input  [2:0] i_data1   ,
    input  [2:0] i_data2   ,
    input  [1:0] i_sel     ,
    
    input        i_rst_n   ,
    input        clk
);

    wire [3:0] connect_mux_to_acum;

    bypassAdder
    u_bypassAdder
    (
        .o_data (connect_mux_to_acum) ,

        .i_data1(i_data1),
        .i_data2(i_data2),
        .i_sel  (i_sel)  ,
    );

    acumulator
    u_acumulator
    (
        .o_data    (o_data),
        .o_overflow(o_overflow),
                
        .i_data    (connect_mux_to_acum),
        .i_rst     (~i_rst_n),
        .clk       (clk)
    );

endmodule