module braun_multiplier #(parameter N = 4) (
    input  [N-1:0] A, B,
    output [2*N-1:0] P
);
    wire [N-1:0] partial_products[N-1:0];
    wire [2*N-1:0] sum[N:0];
    wire [2*N-1:0] carry[N:0];

    assign sum[0] = 0;
    assign carry[0] = 0;

    genvar i, j;
    generate
        // Generate Partial Products
        for (i = 0; i < N; i = i + 1) begin : partial_prod_gen
            assign partial_products[i] = A & {N{B[i]}};
        end

        // Generate Full Adders for Summation
        for (i = 0; i < N; i = i + 1) begin : sum_gen
            for (j = 0; j < 2*N; j = j + 1) begin : fa_gen
                full_adder FA (
                    .a(partial_products[i][j]),
                    .b(sum[i][j]),
                    .cin(carry[i][j]),
                    .sum(sum[i+1][j]),
                    .cout(carry[i+1][j])
                );
            end
        end
    endgenerate

    // Final Product Output
    assign P = sum[N];

endmodule
