module controller(opcode,phase,zero,sel,rd,ld_ir,inc_pc,halt,ld_pc,data_e,ld_ac,wr);

    input wire [2:0] opcode;
    input wire [2:0] phase;
    input wire zero;
    output reg sel;
    output reg rd;
    output reg ld_ir;  
    output reg inc_pc; 
    output reg halt; 
    output reg ld_pc;  
    output reg data_e;
    output reg ld_ac;    
    output reg wr;

    reg H =0,A=0,Z=0,S=0,J=0;
    always @(opcode) begin

        H=(opcode==3'b000)? 1:0;
        Z=(opcode==3'b001 & zero ==1)? 1:0;
        A=(opcode==3'b010 | opcode==3'b011  | opcode==3'b110 | opcode==3'b101 )? 1:0;
        S=(opcode==3'b110)? 1:0;
        J=(opcode==3'b111)? 1:0;
    end
    always @(phase ) begin

        if (phase == 3'b000) begin
            sel=1;rd=0;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;
        end
        else if(phase ==3'b001) begin
            sel=1;rd=1;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;
        end
        else if(phase ==3'b010) begin
            sel=1;rd=1;ld_ir=1;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;
        end
        else if(phase ==3'b011) begin
            sel=1;rd=1;ld_ir=1;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;
        end
        else if(phase ==3'b100) begin
            sel=0;rd=0;ld_ir=0;inc_pc=1;halt=H;ld_pc=0;data_e=0;ld_ac=0;wr=0;
        end
        else if(phase ==3'b101) begin
            sel=0;rd=A;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;
        end
        else if(phase ==3'b110) begin
            sel=0;rd=A;ld_ir=0;inc_pc=Z;halt=0;ld_pc=J;data_e=S;ld_ac=0;wr=0;
        end
        else begin
            sel=0;rd=A;ld_ir=0;inc_pc=0;halt=0;ld_pc=J;data_e=S;ld_ac=A;wr=S;
        end
    end
endmodule