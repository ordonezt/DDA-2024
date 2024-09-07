
`define NB_SEL 3

module count
#(
    parameter NB_COUNTER = 32,
    parameter NB_SW      = 3 
)
(
    output                 o_valid,
    input  [NB_SW - 1 : 0] i_sw   ,
    input                  i_reset,
    input                  clock   
);
  

    // Localparam
    localparam R0 = 2**(NB_COUNTER-10)-1;
    localparam R1 = 2**(NB_COUNTER-11)-1;
    localparam R2 = 2**(NB_COUNTER-12)-1;
    localparam R3 = 2**(NB_COUNTER-13)-1;

    // Vars
    // ASSIGN
    wire [NB_COUNTER - 1 : 0] limit_ref;
    assign limit_ref =  (i_sw[NB_SW-1:NB_SW-2]==2'b00) ? R0 :
                        (i_sw[NB_SW-1:NB_SW-2]==2'b01) ? R1 :
                        (i_sw[NB_SW-1:NB_SW-2]==2'b10) ? R2 : R3;

    // //localparam NB_SEL = 3;
    // assign limit_ref =  (i_sw[NB_SW-1 -: `NB_SEL]==`NB_SEL'b00) ? R0 :
    //                     (i_sw[NB_SW-1 -: `NB_SEL]==`NB_SEL'b01) ? R1 :
    //                     (i_sw[NB_SW-1 -: `NB_SEL]==`NB_SEL'b10) ? R2 : R3;

    // assign limit_ref =  (i_sw[NB_SW-1 -: NB_SEL] == 0) ? R0 :
    //                     (i_sw[NB_SW-1 -: NB_SEL] == 1) ? R1 :
    //                     (i_sw[NB_SW-1 -: NB_SEL] == 2) ? R2 : R3;

    // assign limit_ref =  (i_sw[NB_SW-1 -: NB_SEL] == {NB_SEL{1'b0}}) ? R0 :
    //                     (i_sw[NB_SW-1 -: NB_SEL] == {NB_SEL-1{1'b0},1'b1}) ? R1 :
    //                     (i_sw[NB_SW-1 -: NB_SEL] == 2) ? R2 : R3;

    // REG
    // reg [NB_COUNTER - 1 : 0] limit_ref;
    // always @(*) begin
    //     case (i_sw[2:1])
    //         2'b00: limit_ref = R0;
    //         2'b01: limit_ref = R1;
    //         2'b10: limit_ref = R2;
    //         2'b11: limit_ref = R3;
    //     endcase
        
    // end

    // always @(posedge clock) begin
    //     case (i_sw[2:1])
    //         2'b00: limit_ref <= R0;
    //         2'b01: limit_ref <= R1;
    //         2'b10: limit_ref <= R2;
    //         2'b11: limit_ref <= R3;
    //     endcase
        
    // end

    reg [NB_COUNTER - 1 : 0] counter;
    reg                      valid;

    always @(posedge clock) begin
        if(i_reset) begin
            counter <= {NB_COUNTER{1'b0}};
            valid   <= 1'b0;
        end
        else if (i_sw[0]) begin
            
            if(counter >= limit_ref) begin
                counter <= {NB_COUNTER{1'b0}};
                valid   <= 1'b1;
            end
            else begin
                counter <= counter + 1; //{NB_COUNTER{1'b0}};
                valid   <= 1'b0;
            end
        end
        else begin
            counter <= counter;
            valid   <= valid;
        end
        
    end

    assign o_valid = valid;


endmodule