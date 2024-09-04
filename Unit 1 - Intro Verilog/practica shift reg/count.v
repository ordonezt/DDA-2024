module count 
#(
    parameter NB_COUNTER = 32,
    parameter NB_SW      = 3
)
(
    output             o_valid,
    input  [NB_SW-1:0] i_sw   ,
    input              i_reset,
    input              clock
);
    
    //Local parameter
    localparam R0 = 2**(NB_COUNTER-10)-1;
    localparam R1 = 2**(NB_COUNTER-11)-1;
    localparam R2 = 2**(NB_COUNTER-12)-1;
    localparam R3 = 2**(NB_COUNTER-13)-1;

    // Vars
    wire [NB_COUNTER - 1 : 0] limit_ref;

    //Como es wire tengo que usar assign
    assign limit_ref = (i_sw[NB_SW-1:NB_SW-2] == 2'b00) ? R0 :
                       (i_sw[NB_SW-1:NB_SW-2] == 2'b01) ? R1 :
                       (i_sw[NB_SW-1:NB_SW-2] == 2'b10) ? R2 : R3;

    // //O si no
    // localparam NB_SEL = 2;
    // assign limit_ref =  (i_sw[NB_SW - 1 -: NB_SEL] == 0) ? R0 : 
    //                     (i_sw[NB_SW - 1 -: NB_SEL] == 1) ? R1 :
    //                     (i_sw[NB_SW - 1 -: NB_SEL] == 2) ? R2 : R3;


    // //Tambien se podria haber hecho asi
    // reg [NB_COUNTER - 1 : 0] limit_ref;
    // always @(*) begin
    //     case (i_sw[2:1])
    //         2'b00: limit_ref = R0; // Usa asignacion bloqueante porque es combinacional, usariamos no bloqueante si fuera con el posedge del clock
    //         2'b01: limit_ref = R1;
    //         2'b10: limit_ref = R2;
    //         2'b11: limit_ref = R3;
    //     endcase
    // end

    reg [NB_COUNTER - 1 : 0] counter;
    reg valid;

    always @(posedge clock) begin

        if (i_reset) begin
            counter <= {NB_COUNTER{1'b0}}; //Inicializamos el contador a 0
        end
        
        else if (i_sw[0]) begin

            if (counter >= limit_ref) begin
                counter <= {NB_COUNTER{1'b0}};
                valid   <= 1'b1;
            end

            else begin
                counter <= counter + 1;
                valid   <= 1'b0;
            end

        end
        else begin
            counter <= counter; //Esta parte no haria falta porque estamos en un circuito secuencial, pero por costumbre vamos a ponerlo
            valid <= valid;
        end
    end

    assign o_valid = valid;
    
endmodule