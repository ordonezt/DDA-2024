module shiftRegister 
#(
    parameter SHIFT_SIZE = 4
)
(
    output [SHIFT_SIZE - 1 : 0] o_shift,
    input                       i_valid,
    input                       i_reset,
    input                       clock
);

    reg [SHIFT_SIZE - 1 : 0] r_shiftreg ;
    
    always @(posedge clock) begin

        // If reset, all leds but 0 should be off
        if (i_reset) begin
            r_shiftreg <= {{(SHIFT_SIZE - 1){1'b0}}, 1'b1};
        end

        // If i_valid pulse, shift the register 1 bit
        else if (i_valid) begin
            r_shiftreg <= r_shiftreg << 1;
            
            r_shiftreg[0] <= r_shiftreg[SHIFT_SIZE - 1];
        end

        else begin
            r_shiftreg <= r_shiftreg;
        end

    end

    assign o_shift = r_shiftreg;
endmodule