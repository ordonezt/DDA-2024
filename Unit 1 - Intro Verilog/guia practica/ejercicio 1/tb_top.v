`timescale 1ns/100ps

module tb_top();

wire [6 - 1 : 0] o_data    ;
wire             o_overflow;


reg [3 - 1 : 0] i_data1;
reg [3 - 1 : 0] i_data2;

reg [2 - 1 : 0] i_sel  ;
reg             i_reset; //! Reset
reg             clock  ; //! System clock

//! Stimulus by initial
initial begin: stimulus
    i_data1      = 3'h0;
    i_data2      = 3'h0;
    i_sel        = 2'h0;
    clock        = 1'b0;
    i_reset      = 1'b0;

    #100 i_data1 = 3'h1;
    #100 i_data2 = 3'h1;
    #100 i_reset = 1'b1;
    #100 i_sel   = 2'h0;
    
    #300 i_reset = 1'b0;
    #300 i_sel   = 2'h1;
    #301 i_reset = 1'b1;
    
    #500 i_reset = 1'b0;
    #500 i_sel   = 2'h2;
    #501 i_reset = 1'b1;
    
    #1000000 $finish;
end

//! Clock generator
always #5 clock = ~clock;

//! Instance of top module
top
u_top
    (
        .o_data     (o_data)    ,
        .o_overflow (o_overflow),
        
        .i_data1    (i_data1)   ,
        .i_data2    (i_data2)   ,
        .i_sel      (i_sel)     ,
        
        .i_rst_n    (i_reset)   ,
        .clk        (clock)
    );

endmodule // tb_top
