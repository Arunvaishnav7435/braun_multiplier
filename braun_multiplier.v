module braun_multiplier #(parameter n = 4)(
    input  [n-1:0]   a, // n-bit input a
    input  [n-1:0]   b, // n-bit input b
    output [2*n-1:0] p  // 2n-bit output product
);

  wire [n-1:0][n-1:0] partial_products; // Partial products
  wire [2*n-1:0] sum [n-1:0];          // Intermediate sums
  wire [2*n-1:0] carry [n-1:0];        // Intermediate carries

  // Generate partial products
  genvar i, j;
  generate
    for (i = 0; i < n; i = i + 1) begin
      for (j = 0; j < n; j = j + 1) begin
        assign partial_products[i][j] = a[i] & b[j];
      end
    end
  endgenerate

  // Add partial products
  generate
    for (i = 0; i < n; i = i + 1) begin
      if (i == 0) begin
        assign sum[i] = { {n{1'b0}}, partial_products[i] }; // Align LSB
        assign carry[i] = {2*n{1'b0}};
      end else begin
        assign {carry[i], sum[i]} = sum[i-1] + { {n{1'b0}}, partial_products[i] } + carry[i-1];
      end
    end
  endgenerate

  // Final product
  assign p = sum[n-1] + carry[n-1];

endmodule
