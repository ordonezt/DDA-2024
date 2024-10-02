`timescale 1ns/100ps

module tb_floatingPointProduct();

    // Parameters
    parameter NB_SIGN = 1;
    parameter NB_EXPO = 4;
    parameter NB_MANT = 8;
    parameter NB      = NB_SIGN + NB_EXPO + NB_MANT;

    wire signed [NB - 1 : 0] o_data          ; //! Output

    reg  signed [NB - 1 : 0] i_dataA, i_dataB; //! Data inputs

    //! Stimulus by initial
    initial begin: stimulus
        // Estímulo 1: Multiplicación de dos números positivos en punto flotante
        i_dataA = {1'b0, 4'b0111, 8'b11000000}; // Signo: 0, Exponente: 7, Mantisa: 0xC0
        i_dataB = {1'b0, 4'b0101, 8'b10100000}; // Signo: 0, Exponente: 5, Mantisa: 0xA0
        #5;
        // Resultado esperado: signo 0, exponente 7 + 5 - 7 = 5, mantisa 0xC0 * 0xA0 = 0x7800 (sin normalizar)
        $display("Resultado 1: o_data = %b, Esperado: 0_0101_01111000", o_data);

        // Estímulo 2: Multiplicación de un número positivo y uno negativo
        i_dataA = {1'b0, 4'b0110, 8'b10010000}; // Signo: 0, Exponente: 6, Mantisa: 0x90
        i_dataB = {1'b1, 4'b0011, 8'b01100000}; // Signo: 1, Exponente: 3, Mantisa: 0x60
        #5;
        // Resultado esperado: signo 1, exponente 6 + 3 - 7 = 2, mantisa 0x90 * 0x60 = 0x3480 (sin normalizar)
        $display("Resultado 2: o_data = %b, Esperado: 1_0010_00110100", o_data);

        // Estímulo 3: Multiplicación de dos números negativos
        i_dataA = {1'b1, 4'b0111, 8'b11110000}; // Signo: 1, Exponente: 7, Mantisa: 0xF0
        i_dataB = {1'b1, 4'b0100, 8'b10110000}; // Signo: 1, Exponente: 4, Mantisa: 0xB0
        #5;
        // Resultado esperado: signo 0, exponente 7 + 4 - 7 = 4, mantisa 0xF0 * 0xB0 = 0xA500 (sin normalizar)
        $display("Resultado 3: o_data = %b, Esperado: 0_0100_10100101", o_data);

        // Estímulo 4: Multiplicación de un número con cero
        i_dataA = {1'b0, 4'b0000, 8'b00000000}; // Signo: 0, Exponente: 0 (cero), Mantisa: 0x00
        i_dataB = {1'b0, 4'b0101, 8'b10000000}; // Signo: 0, Exponente: 5, Mantisa: 0x80
        #5;
        // Resultado esperado: cero (cualquier número multiplicado por cero es cero)
        $display("Resultado 4: o_data = %b, Esperado: 0_0000_00000000", o_data);

        // Estímulo 5: Multiplicación de números cercanos a cero (subnormales)
        i_dataA = {1'b0, 4'b0001, 8'b00000001}; // Signo: 0, Exponente: 1, Mantisa: 0x01
        i_dataB = {1'b0, 4'b0001, 8'b00000010}; // Signo: 0, Exponente: 1, Mantisa: 0x02
        #5;
        // Resultado esperado: signo 0, exponente 1 + 1 - 7 = -5 (muy cercano a cero), mantisa 0x01 * 0x02 = 0x02 (sin normalizar)
        $display("Resultado 5: o_data = %b, Esperado: 0_0000_00000010", o_data);

        // Estímulo 6: Multiplicación de un número positivo con infinito
        i_dataA = {1'b0, 4'b1111, 8'b00000000}; // Signo: 0, Exponente: todo 1 (infinito), Mantisa: 0x00
        i_dataB = {1'b0, 4'b0101, 8'b10100000}; // Signo: 0, Exponente: 5, Mantisa: 0xA0
        #5;
        // Resultado esperado: infinito (cualquier número multiplicado por infinito es infinito)
        $display("Resultado 6: o_data = %b, Esperado: 0_1111_00000000", o_data);

    #10 $finish;
    end

    //! Instance of floating point product
    floatingPointProduct
        #(
            .NB_SIGN(NB_SIGN),
            .NB_EXPO(NB_EXPO),
            .NB_MANT(NB_MANT)
        )
        u_floatingPointProduct
        (
            .o_data(o_data) ,
            
            .i_dataA(i_dataA),
            .i_dataB(i_dataB)
        );

endmodule // tb_floatingPointProduct
