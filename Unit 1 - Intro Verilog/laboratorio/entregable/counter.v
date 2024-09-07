module counter 
#(
    parameter NUM_BITS      = 32
)
(
    output                    o_compare,

    input [3 - 1: 0]          i_switch ,
    input                     i_reset  ,
    input                     clock
);

    localparam R0 = (2**(NUM_BITS-20))-1;
    localparam R1 = (2**(NUM_BITS-19)) -1;
    localparam R2 = (2**(NUM_BITS-18)) -1;
    localparam R3 = (2**(NUM_BITS-17)) -1;

    reg [NUM_BITS-1 : 0] reference;

    always @(*) begin
        case (i_switch[2 : 1])
            4'h0:    reference <= R0;
            4'h1:    reference <= R1;
            4'h2:    reference <= R2;
            4'h3:    reference <= R3;
            default: reference <= R0;
        endcase
    end

    reg  [NUM_BITS-1 : 0] count;
    reg                   compare;

    always @(posedge clock ) begin
        
        if (i_reset) begin
            count <= {NUM_BITS{1'b0}};
            compare <= 1'b0;
        end

        else if (i_switch[0]) begin
            
            if (count >= reference) begin
                count   <= {NUM_BITS{1'b0}};
                compare <= 1'b1;
            end

            else begin
                count   <= count + {{(NUM_BITS - 1){1'b0}}, 1'b1};
                compare <= 1'b0;
            end

        end

        else begin
            count   <= count;
            compare <= compare;
        end

    end

    assign o_compare = compare;

endmodule