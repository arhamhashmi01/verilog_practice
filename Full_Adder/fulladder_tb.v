`timescale 1ns/1ps
module fulladder_tb();
    reg a_tb;
    reg b_tb;
    reg cin_tb;
    wire sum_tb;
    wire cout_tb;

    initial begin
        //initial values
        a_tb=0;
        b_tb=0;
        cin_tb=0;
        #1;
        a_tb=1;b_tb=1;cin_tb=0;
        #1;
        a_tb=0;b_tb=1;cin_tb=0;
        #1;
        a_tb=1;b_tb=1;cin_tb=1;
        $display ("sum_tb=%d",sum_tb);
        $display("cout_tb value is %d",cout_tb);        
    end

    fulladder u_fulladdre0 (
        .a(a_tb),
        .b(b_tb),
        .cin(cin_tb),
        .sum(sum_tb),
        .cout(cout_tb)
    );

    initial begin 
        $dumpfile("fulladder.vcd");
        $dumpvars(0,fulladder_tb);
    end
endmodule