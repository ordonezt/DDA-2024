`timescale 1ns/100ps

module tb_top();

  // Parameters
  parameter NUM_LEDS  = 4;
  parameter NUM_BITS  = 32; //! Number of bits of the counter (32)

  wire [NUM_LEDS - 1 : 0] o_led    ; //! Leds
  wire [NUM_LEDS - 1 : 0] o_led_b  ; //! RGB Leds - Color Blue
  wire [NUM_LEDS - 1 : 0] o_led_g  ; //! RGB Leds - Color Green
 
  reg  [4 - 1 : 0]        i_sw     ; //! Switchs
  reg                     i_reset  ; //! Reset
  reg                     clock    ; //! System clock

  wire [NUM_BITS - 1 : 0] tb_count; //! Read internal counter

  wire [NUM_BITS - 1 : 0] tb_R0;
  wire [NUM_BITS - 1 : 0] tb_R1;
  wire [NUM_BITS - 1 : 0] tb_R2;
  wire [NUM_BITS - 1 : 0] tb_R3;

  wire [NUM_BITS - 1 : 0] tb_reference;

  wire tb_valid;

  //! Read the counter from module
  assign tb_count = tb_top.u_top.u_counter.count;

  assign tb_R0 = tb_top.u_top.u_counter.R0;
  assign tb_R1 = tb_top.u_top.u_counter.R1;
  assign tb_R2 = tb_top.u_top.u_counter.R2;
  assign tb_R3 = tb_top.u_top.u_counter.R3;

  assign tb_reference = tb_top.u_top.u_counter.reference;

  assign tb_valid = tb_top.u_top.u_counter.o_compare;

     
  //! Stimulus by initial
  initial begin: stimulus
      i_sw[0]      = 1'b0  ;
      clock        = 1'b0  ;
      i_reset      = 1'b0  ;
      i_sw[2:1]    = 4'h0  ;
      i_sw[3]      = 1'b0  ;
      #100 i_reset = 1'b1  ;
      #100 i_sw[0] = 1'b1  ;
      
      //force tb_shiftleds.u_shiftleds.o_led = 4'b0001;
      
      #1000000 i_sw[2:1]  = 4'h1 ;
      #1000000 i_sw[2:1]  = 4'h2 ;
      #1000000 i_sw[3]    = 1'b1 ;
      #1000000 i_sw[2:1]  = 4'h3 ;
      #1000000 $finish;
  end

  //! Clock generator
  always #5 clock = ~clock;

  //! Instance of shiftleds module
  top
    #(
      .NUM_LEDS (NUM_LEDS),
      .NUM_BITS (NUM_BITS)
      )
    u_top
      (
      .o_led     (o_led  ),
      .o_led_b   (o_led_b),
      .o_led_g   (o_led_g),
      
      .i_sw      (i_sw   ),
      .i_reset   (i_reset),
      .clock     (clock  )
      );

endmodule // tb_top
