module swap(
    input en,
    input [3:0] a,
    input [3:0] b,
    output reg [3:0] x,
    output reg [3:0] y
);
    /*
    When en is 0, x = a and y = b
    when en is 1, x = b and y = a
    */
    //Do not modify above this line

    always @(*) begin
    if (en == 1'b0) begin
        x = a;
        y = b;
    end
    else begin
        x = b;
        y = a;
    end
end

endmodule

// Nancy
