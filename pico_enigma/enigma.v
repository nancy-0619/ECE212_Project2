module enigma(
    input clk,
    input reset,
    input [7:0] seed,
    input [3:0] in,
    output [3:0] out,
    output [3:0] key
);
    /*
    Implement the enigma machine using the following modules:
        -xorshift798
        -ones_comp_add
        -negate
        -sbox

    The cipher must be symmetric, so it will follow this pattern:
        input -> negate -> sbox -> XOR w/ key -> sbox -> negate -> output

    The key for the XOR cipher will be:
    a = ones_comp_add(random[3:0], random[7:4])
    b = ones_comp_add(random[11:8], random[15:12])
    key = ones_comp_add(a, b)
    This ensures that key will never be zero. If key is zero, the output
    would be the same as the input.

    random[0] will be used as the enable input for both negate modules
    random[1] will be used as the enable input for both sbox modules

    reset will reset the xorshift798 with seed. It is ok that the xorshift798
    module has a 16 bit input and seed is 8 bits. Just use {8'b0,seed} as the
    input to the module. That zero extends the value. Alternatively, you can
    just put the 8 bit value into the input, but it may print a warning. That
    is acceptable though.
    */
    //Do not modify above this line

    wire [15:0] random;
    wire [3:0] a, b;
    wire [3:0] neg1, sbox1, xor_result, sbox2;

    xorshift798 rng(
        .clk(clk),
        .reset(reset),
        .seed({8'b0, seed}),
        .random(random)
    );

    ones_comp_add add1(
        .a(random[3:0]),
        .b(random[7:4]),
        .out(a)
    );

    ones_comp_add add2(
        .a(random[11:8]),
        .b(random[15:12]),
        .out(b)
    );

    ones_comp_add add3(
        .a(a),
        .b(b),
        .out(key)
    );

    negate n1(
        .en(random[0]),
        .in(in),
        .out(neg1)
    );

    sbox sb1(
        .en(random[1]),
        .in(neg1),
        .out(sbox1)
    );

    assign xor_result = sbox1 ^ key;

    sbox sb2(
        .en(random[1]),
        .in(xor_result),
        .out(sbox2)
    );

    negate n2(
        .en(random[0]),
        .in(sbox2),
        .out(out)
    );

endmodule

// Nancy
