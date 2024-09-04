module 
(
    output reg [5:0] o_data    ,
    output reg       o_overflow,
    
    input      [3:0] i_data    ,
    
    input            i_rst     ,
    input            clk
);

    wire sum[6:0];

    assign sum = i_data + o_data;

    always@(posedge clk or posedge i_rst) 
    begin
        if (i_rst)
            o_data     <= 0;
            o_overflow <= 0;
        else
            o_data     <= sum;
            o_overflow <= sum[6];
    end

endmodule