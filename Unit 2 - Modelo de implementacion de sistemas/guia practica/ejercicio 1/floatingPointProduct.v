module floatingPointProduct 
#(
    parameter NB_SIGN = 1,
    parameter NB_EXPO = 4,
    parameter NB_MANT = 8
)
(
    output [NB_SIGN + NB_EXPO + NB_MANT - 1 : 0] o_data ,
    
    input  [NB_SIGN + NB_EXPO + NB_MANT - 1 : 0] i_dataA,
    input  [NB_SIGN + NB_EXPO + NB_MANT - 1 : 0] i_dataB
);

    localparam NB   = NB_SIGN + NB_EXPO + NB_MANT;
    localparam MSB  = NB - 1;
    localparam BIAS = ((2 ** NB_EXPO) - 1) >> 1;

    //--------------------------------------------------------------
    // Sign = sA xor sB
    //--------------------------------------------------------------
    wire [NB_SIGN - 1 : 0] sign;
    wire [NB_SIGN - 1 : 0] signA;
    wire [NB_SIGN - 1 : 0] signB;

    assign signA = i_dataA[MSB -: NB_SIGN];
    assign signB = i_dataB[MSB -: NB_SIGN];

    assign sign  = signA ^ signB;

    //--------------------------------------------------------------
    // Exponent = eA + eB - bias
    //--------------------------------------------------------------
    localparam EXP_MSB = MSB - NB_SIGN;

    wire [NB_EXPO - 1 : 0] exponent;
    wire [NB_EXPO - 1 : 0] exponentA;
    wire [NB_EXPO - 1 : 0] exponentB;

    assign exponentA = i_dataA[EXP_MSB -: NB_EXPO];
    assign exponentB = i_dataB[EXP_MSB -: NB_EXPO];

    assign exponent  = exponentA + exponentB - BIAS;

    //--------------------------------------------------------------
    // Mantissa = mA x mB
    //--------------------------------------------------------------
    localparam MAN_MSB = EXP_MSB - NB_EXPO;

    wire [NB_MANT - 1 : 0] mantissa;
    wire [NB_MANT - 1 : 0] mantissaA;
    wire [NB_MANT - 1 : 0] mantissaB;

    assign mantissaA = i_dataA[MAN_MSB -: NB_MANT];
    assign mantissaB = i_dataB[MAN_MSB -: NB_MANT];
    
    assign mantissa  = mantissaA * mantissaB;

    assign o_data = {sign, exponent, mantissa};

endmodule