module bypassAdder
(
    output [4-1 : 0] o_data ,

    input  [3-1 : 0] i_data1,
    input  [3-1 : 0] i_data2,
    input  [2-1 : 0] i_sel
);

    wire [4-1 : 0] sum;

    assign sum = i_data1 + i_data2;

    assign o_data = (i_sel == 2'b00) ? {1'b0, i_data2} :
                    (i_sel == 2'b01) ? sum             :
                    {1'b0, i_data1}                    ;

endmodule