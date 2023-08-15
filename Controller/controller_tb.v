`timescale 1ns/1ps
module controller_tb ();

    reg zero;
    reg [2:0] phase;
    reg [2:0] opcode;

    wire sel;
    wire rd;
    wire ld_ir;
    wire inc_pc;
    wire halt;
    wire ld_pc;
    wire data_e;
    wire ld_ac;
    wire wr;

    initial begin 

        opcode=3'b111;
        zero=1;
        phase =3'b000;
        #10;
        opcode=3'b111;
        zero=1;
        phase =3'b110;
        #10;
        opcode=3'b101;
        zero=1;
        phase =3'b010;
        #10;
        opcode=3'b110;
        zero=1;
        phase =3'b011;
        #10;
        opcode=3'b000;
        zero=1;
        phase =3'b110;                
    end

    initial begin
        $dumpfile("controller.vcd");
        $dumpvars(0, controller_tb);
    end
    controller u_controller (
        .zero(zero),
        .phase(phase),
        .opcode(opcode),
        .sel(sel),
        .rd(rd),
        .ld_ir(ld_ir),
        .inc_pc(inc_pc),
        .halt(halt),
        .ld_pc(ld_pc),
        .data_e(data_e),
        .ld_ac(ld_ac),
        .wr(wr)
    );
endmodule