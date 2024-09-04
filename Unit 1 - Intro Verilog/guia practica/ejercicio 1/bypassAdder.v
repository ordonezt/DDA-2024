module
(
    output [3:0] o_data ,

    input  [2:0] i_data1,
    input  [2:0] i_data2,
    input  [1:0] i_sel  ,
);

    always @(*) // Puedo eliminar el always?
    begin
        case (i_sel)
            2'b00:   o_data = {1'b0, i_data2};
            2'b01:   o_data = i_data1 + i_data2;
            2'b10:   o_data = {1'b0, i_data1};
            default: o_data = 4'b0000
        endcase
    end

endmodule