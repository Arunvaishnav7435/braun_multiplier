/*module half_adder(
    input  a, // First input
    input  b, // Second input
    output sum, // Sum output
    output carry // Carry output
);
  assign sum = a ^ b; // Sum is XOR of inputs
  assign carry = a & b; // Carry is AND of inputs
endmodule

module full_adder(
    input  a, // First input
    input  b, // Second input
    input  cin, // Carry-in input
    output sum, // Sum output
    output cout // Carry-out output
);
  wire s1, c1, c2; // Intermediate wires

  half_adder HA1(.a(a), .b(b), .sum(s1), .carry(c1)); // First half adder
  half_adder HA2(.a(s1), .b(cin), .sum(sum), .carry(c2)); // Second half adder

  assign cout = c1 | c2; // Final carry-out is OR of both carries
endmodule
*/
module braun_multiplier #(parameter n = 4)(
    input  [n-1:0]   a, // n-bit input a
    input  [n-1:0]   b, // n-bit input b
    output [2*n-1:0] prod  // 2n-bit output product
);

  wire [n-1:0] partial_products [n-1:0]; // Partial products
  reg [2*n-1:0] sum = 0;          // Intermediate sums starting with 0

  // Generate partial products
  genvar i, j;
  generate
    for (i = 0; i < n; i = i + 1) begin
      for (j = 0; j < n; j = j + 1) begin
        assign partial_products[i][j] = a[i] & b[j];
      end
    end
  endgenerate

//  assign p[0] = partial_products[0][0]; // First bit of product

  // first row has only half adders
  integer p, q, r;

  always@(*) begin
    for (p = 0; p < 2*n-1; p = p + 1) begin
      for (q = 0; q < n; q = q + 1) begin
        for (r = 0; r < n; r = r + 1) begin
          if (p == q + r) begin
            sum[p] = sum[p] + partial_products[q][r];
          end
        end
      end
    end
  end

  assign prod = sum; // Assign final product
endmodule
