module braun_multiplier_tb_top;
    logic [1:0] a, b;
    output [2:0] p;
    
    braun_multiplier dut (a, b, p);

    initial begin
        // Test case 1: 0 * 0 = 0
        a = 2'b00; b = 2'b00;
        #10;
        assert (p == 3'b000) else $fatal("Test case 1 failed: %b * %b = %b", a, b, p);

        // Test case 2: 0 * 1 = 0
        a = 2'b00; b = 2'b01;
        #10;
        assert (p == 3'b000) else $fatal("Test case 2 failed: %b * %b = %b", a, b, p);

        // Test case 3: 1 * 0 = 0
        a = 2'b01; b = 2'b00;
        #10;
        assert (p == 3'b000) else $fatal("Test case 3 failed: %b * %b = %b", a, b, p);

        // Test case 4: 1 * 1 = 1
        a = 2'b01; b = 2'b01;
        #10;
        assert (p == 3'b001) else $fatal("Test case 4 failed: %b * %b = %b", a, b, p);

        // Test case 5: 1 * 2 = 2
        a = 2'b01; b = 2'b10;
        #10;
        assert (p == 3'b010) else $fatal("Test case 5 failed: %b * %b = %b", a, b, p);

        // Test case 6: 2 * 1 = 2
        a = 2'b10; b = 2'b01;
        #10;
        assert (p == 3'b010) else $fatal("Test case 6 failed: %b * %b = %b", a, b, p);

        // Test case 7: Max value test: (3*3=9)
        a = 'h11; b = 'h11;
        #10;
        assert (p == 'h1001) else $fatal("Test case max value failed: %h * %h != %h", a, b, p);
        
    end
endmodule