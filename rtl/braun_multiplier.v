module half_adder(
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
/*
module braun_multiplier #(parameter n = 3)(
    input  [n-1:0]   a, // n-bit input a
    input  [n-1:0]   b, // n-bit input b
//    input           rst, // Reset signal
    output [2*n-1:0] prod  // 2n-bit output product
);

  wire [n-1:0] partial_products [n-1:0]; // Partial products
  wire [2*n-1:0] sum;          // Intermediate sums starting with 0
  wire [2*n-1:0] carry ;           // Carry bits
  wire [n-1:0] partial_sum;
  wire [n-1:0] partial_carry [n-1:0]; // TODO: find the correct size for this wire

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
  

  always@(*) begin
    if(rst) begin
      for (p = 0; p < 2*n-1; p = p + 1) begin
        sum[p] = 0; // Reset sum to zero
      end
      partial_sum = 0; // Reset partial sum to zero
    end
    else begin
      for (p = 0; p < 2*n-1; p = p + 1) begin
        for (q = 0; q < n; q = q + 1) begin
          partial_sum = partial_sum partial_products[q][p-q]; // Sum of partial products
        end
        if(p == 0)
          sum[p] = partial_sum;
        else
          sum[p] = sum[p-1][1] + partial_sum; // Cumulative sum of partial products
        partial_sum = 0; // Reset partial sum for next iteration
      end
    end 
  end

  genvar p, q, r;
  generate
    for (p = 0; p < 2*n-2; p = p + 1) begin
      for(q = 0; q < n; q = q + 1) begin
        for(r = 0; r < n; r = r + 1) begin
          if(p == q + r) begin
            if(q == 0)
              full_adder FA(partial_products[q][r], 0, 0, partial_sum[q], partial_carry[q][r]);
            else
              full_adder FA(partial_products[q][r], partial_sum[q-1], partial_carry[q-1][r+1], partial_sum[q], partial_carry[q][r]); // Full adder for subsequent rows
            if(p == q)
              assign sum[p] = partial_sum[q]; // Assign sum for the last column
          end
        end
      end
    end    
  endgenerate

  genvar k;
  generate
    for (k = 0; k < 2*n-1; k = k + 1) begin
      assign prod[k] = sum[k]; // Assign final product bits
    end
  endgenerate
endmodule
*/
module braun_multiplier #(parameter N = 2) (
    input  [N-1:0] A, B,
    output [2*N-1:0] P
);
    wire [N-1:0] partial_products[N-1:0];
    wire [2*N-1:0] sum[N:0];

    assign sum[0] = 0;

    // Generate partial products
    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : partial_prod_gen
            assign partial_products[i] = A & {N{B[i]}};
        end
    endgenerate

    // Generate carry-save adders
    generate
        for (i = 0; i < N; i = i + 1) begin : sum_gen
            assign sum[i+1] = sum[i] + (partial_products[i] << i);
        end
    endgenerate

    // Final product output
    assign P = sum[N];

endmodule