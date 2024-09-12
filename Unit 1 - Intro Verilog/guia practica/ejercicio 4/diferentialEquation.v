module diferentialEquation
#(
    parameter N_BITS = 8
)
(
    output [N_BITS + 3-1 : 0] o_y    ,
    
    input  [N_BITS - 1   : 0] i_x    ,
    input                     i_reset,
    input                     clock
);

// y[n] = x[n] − x[n − 1] + x[n − 2] + x[n − 3] + 0.5y[n − 1] + 0.25y[n − 2]
// Son 3 sumas de x por lo que se suman 3 bits y son dos sumas de y pero ambas tienen al menos 1 bit menos ya que estan divididas por 2 y 4.
// Resolucion de salida 8 + 3 = 11
// Igualmente habria que previamente analizar la estabilidad del sistema ya que tiene realimentacion positiva y podria ser inestable

    reg [N_BITS - 1   : 0] r_x0, r_x1, r_x2, r_x3;
    reg [N_BITS + 3-1 : 0] r_y0, r_y1, r_y2     ;

    assign o_y = r_y0;

    always @(posedge clock) begin

        if (i_reset) begin
            r_y0 <= {(N_BITS + 3){1'b0}};
            r_y1 <= {(N_BITS + 3){1'b0}};
            r_y2 <= {(N_BITS + 3){1'b0}};

            r_x0 <= {N_BITS{1'b0}};
            r_x1 <= {N_BITS{1'b0}};
            r_x2 <= {N_BITS{1'b0}};
            r_x3 <= {N_BITS{1'b0}};
        end
        
        else begin
            r_y1 <= r_y0;
            r_y2 <= r_y1;

            r_x0 <= i_x;
            r_x1 <= r_x0;
            r_x2 <= r_x1;
            r_x3 <= r_x2;

            r_y0 <= r_x0 - r_x1 + r_x2 + r_x3 + (r_y1 >>> 1) + (r_y2 >>> 2);
        end

    end

endmodule //diferentialEquation
