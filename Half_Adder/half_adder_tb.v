`timescale 1ns/1ps
module half_adder_tb ();
    reg a_tb;
    reg b_tb;

    wire sum_tb;
    wire cout_tb;

    initial begin
        a_tb=0;
        b_tb=1;
        #5;
        $display("sum = %d", sum_tb, " cout = %d", cout_tb);
        #5;
        a_tb=0;
        b_tb=1;
        #5;
        $display("sum = %d", sum_tb, " cout = %d", cout_tb);
    end
    half_adder u_half_adder0(
        .a(a_tb),
        .b(b_tb),
        .sum(sum_tb),
        .cout(cout_tb)
    );
    initial begin
        $dumpfile("half_adder.vcd");
        $dumpvars(0,half_adder_tb);
    end
endmodule