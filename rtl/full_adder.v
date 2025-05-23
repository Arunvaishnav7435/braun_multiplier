`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 16:47:05
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
  input a, b, cin,
  output sum, cout
    );
    wire temp_sum, c1, c2;
    half_adder ha1 (a, b, temp_sum, c1);
    half_adder ha2 (temp_sum, c, sum, c2);
    
    assign carry = c1 | c2;
endmodule
