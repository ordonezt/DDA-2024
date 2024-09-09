module acumulator
(
    output [6-1 : 0] o_data    ,
    output           o_overflow,
    
    input  [4-1 : 0] i_data    ,
    
    input            i_rst     ,
    input            clk
);

    reg [7-1 : 0] sum;

    always@(posedge clk or posedge i_rst) begin
        
        if (i_rst) begin
            sum <= 7'h00;
        end

        else begin
            sum <= {2'b00, i_data} + sum[5:0];
        end
        
    end
    
    assign o_data     = sum[5:0];
    assign o_overflow = sum[6];

endmodule