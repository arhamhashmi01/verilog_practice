module seq_controller(opcode,zero,clk,rst,mem_rd,load_ir,halt,inc_pc,load_ac,load_pc,mem_wr);

    input wire [2:0]opcode;
    input wire zero;
    input wire clk;
    input wire rst;

    output reg mem_rd;
    output reg load_ir;
    output reg halt;
    output reg inc_pc;
    output reg load_ac;
    output reg load_pc;
    output reg mem_wr;

    localparam INST_ADDR = 3'b000;
    localparam INST_FETCH = 3'b001;
    localparam INST_LOAD = 3'b010;
    localparam IDLE = 3'b011;
    localparam OP_ADDR = 3'b100;
    localparam OP_FETCH = 3'b101;
    localparam ALU_OP = 3'b110;
    localparam STORE = 3'b111;

    reg [2:0]state;
    reg [2:0]nextstate;

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            state <= INST_ADDR;
        end
        else begin
            state <= nextstate;
        end
    end

    always @(*)begin
        case (state)
            INST_ADDR : nextstate = INST_FETCH;
            INST_FETCH : nextstate = INST_LOAD;
            INST_LOAD : nextstate = IDLE;
            IDLE : nextstate = OP_ADDR;
            OP_ADDR : nextstate = OP_FETCH;
            OP_FETCH : nextstate = ALU_OP;
            ALU_OP : nextstate = STORE;
            STORE : nextstate = INST_ADDR;
            default : nextstate = INST_ADDR;
        endcase
    end

    reg H,Z,A,S,J;

    always @(opcode)begin
        H = (opcode == 3'b000)? 1:0;
        Z = (opcode == 3'b001 & zero == 1)? 1:0;
        A = (opcode == 3'b010 | opcode == 3'b011 | opcode == 3'b100 | opcode == 3'b101)? 1:0;
        S = (opcode == 3'b110)? 1:0;
        J = (opcode == 3'b111)? 1:0;
    end

    always @(state)begin
        if (state == INST_ADDR)begin
            mem_rd=0; 
            load_ir=0; 
            halt=0; 
            inc_pc=0; 
            load_ac=0; 
            load_pc=0; 
            mem_wr=0;
        end
        else if (state == INST_FETCH)begin
            mem_rd=1; 
            load_ir=0; 
            halt=0; 
            inc_pc=0; 
            load_ac=0; 
            load_pc=0; 
            mem_wr=0;
        end
        else if (state == INST_LOAD)begin
            mem_rd=1; 
            load_ir=1; 
            halt=0; 
            inc_pc=0; 
            load_ac=0; 
            load_pc=0; 
            mem_wr=0;
        end
        else if (state == IDLE)begin
            mem_rd=1; 
            load_ir=1; 
            halt=0; 
            inc_pc=0; 
            load_ac=0; 
            load_pc=0; 
            mem_wr=0;
        end
        else if (state == OP_ADDR)begin
            mem_rd=1; 
            load_ir=0; 
            halt=H; 
            inc_pc=1; 
            load_ac=0; 
            load_pc=0; 
            mem_wr=0;
        end
        else if (state == OP_FETCH)begin
            mem_rd=A; 
            load_ir=0; 
            halt=0; 
            inc_pc=0; 
            load_ac=0; 
            load_pc=0; 
            mem_wr=0;
        end
        else if (state == ALU_OP)begin
            mem_rd=A; 
            load_ir=0; 
            halt=0; 
            inc_pc=Z; 
            load_ac=A; 
            load_pc=J; 
            mem_wr=0;
        end
        else begin
            mem_rd=A; 
            load_ir=0; 
            halt=0; 
            inc_pc=J; 
            load_ac=A; 
            load_pc=J; 
            mem_wr=S;
        end
    end
endmodule