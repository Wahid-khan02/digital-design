module tb_alu;
    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] result;
    wire zero;

    alu dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero(zero)
    );

    task check;
        input [2:0] test_op;
        input [7:0] test_a;
        input [7:0] test_b;
        input [7:0] expected;
        begin
            op = test_op;
            a = test_a;
            b = test_b;
            #10;
            if (result !== expected || zero !== (expected == 8'b0)) begin
                $display("FAIL op=%b result=%h expected=%h zero=%b",
                         op, result, expected, zero);
                $fatal(1);
            end
            $display("PASS op=%b result=%h", op, result);
        end
    endtask

    initial begin
        check(3'b000, 8'hA5, 8'h01, 8'hA6);
        check(3'b001, 8'hA5, 8'h01, 8'hA4);
        check(3'b010, 8'hA5, 8'h3C, 8'h24);
        check(3'b011, 8'hA5, 8'h3C, 8'hBD);
        check(3'b100, 8'hA5, 8'h3C, 8'h99);
        check(3'b101, 8'h81, 8'h00, 8'h02);
        check(3'b110, 8'h81, 8'h00, 8'h40);
        check(3'b111, 8'hA5, 8'h00, 8'h5A);
        check(3'b001, 8'h55, 8'h55, 8'h00);

        $display("ALL TESTS PASSED");
        $finish;
    end
endmodule