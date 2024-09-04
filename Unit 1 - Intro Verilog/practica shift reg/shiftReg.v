module shift 
#(
    parameter NB_LEDS = 4
)
(
    output [NB_lLEDS -1 :0] o_led  ,
    input        i_valid,
    input        i_reset,
    input        clock  ,
);

    reg [NB_lLEDS -1 :0] r_shift_reg;

    always @(posedge clock ) begin
        
        if (i_reset) begin
            r_shift_reg <= {NB_LEDS-1{1'b0}, 1'b1};
        end

        else if (i_valid) begin
            // Opcion 1
            r_shift_reg <= r_shift_reg << 1; //Desplazar 1
            r_shift_reg[0] <= r_shift_reg[NB_LEDS-1];

            // // Opcion 2
            // for (int ptr = 0; ptr < NB_LEDS; ptr = ptr + 1) begin
            //     r_shift_reg[ptr+1] <= r_shift_reg[ptr];    
            // end
            // r_shift_reg[0] <= r_shift_reg[NB_LEDS-1];

        end

        else begin
            r_shift_reg <= r_shift_reg;
        end

    end

    assign 

endmodule