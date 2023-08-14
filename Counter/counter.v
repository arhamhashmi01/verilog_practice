module counter(rst,clk,out);
    input wire rst;
    input wire clk;

    output reg[3:0] out;

    always @(posedge clk)
    begin
        if (rst)
        begin
            out <= 4'b0000;
        end
        else
        begin
            out <= out + 1'b1;
        end
    end
endmodule