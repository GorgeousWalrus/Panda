// ------------------------ Disclaimer -----------------------
// No warranty of correctness, synthesizability or 
// functionality of this code is given.
// Use this code under your own risk.
// When using this code, copy this disclaimer at the top of 
// Your file
//
// (c) Luca Hanel 2020
//
// ------------------------------------------------------------
//
// Module name: branch_predictor
// 
// Functionality: A simple branch predictor, based on forward
//                and backward branches
//                If the branch is backwards, it is likely that
//                we are in a loop - take the branch
//
// ------------------------------------------------------------

`include "instructions.sv"

module branch_predictor(
    input logic [31:0]  instr_i,
    input logic [31:0]  pc_i,
    output logic [31:0] pc_o,
    // output logic [4:0]  rs_o,
    // input logic [31:0]  rs_di,
    output logic        branch
);

logic [31:0] imm;
logic [31:0] pc;

assign pc_o = pc;

assign imm = {{19{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30 : 25], instr_i[11:8], 1'b0};

always_comb
begin
    pc = 'b0;
    branch = 1'b0;
    // If instr_i[31] is set, the offset is negative
    if(instr_i[6:0] == `BRANCH && instr_i[31]) begin
            branch  = 1'b1;
            pc      = pc_i + imm;
        end
end

endmodule
