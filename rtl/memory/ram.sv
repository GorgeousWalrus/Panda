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
// Module name: ram
// 
// Functionality: Single port ram
//
// ------------------------------------------------------------

module ram #(
    parameter DEPTH = 1024,
    parameter WORD_WIDTH = 32
)(
    input logic                     clk,
    input logic                     rstn_i,
    input logic [$clog2(DEPTH)-1:0] addr_i,
    input logic                     en_i,
    input logic                     we_i,
    input logic [WORD_WIDTH-1:0]    din_i,
    output logic [WORD_WIDTH-1:0]   dout_o
);

(*ram_style = "block" *) reg [WORD_WIDTH-1:0] data[0:DEPTH-1];

always_ff @(posedge clk)
begin
    if(en_i) begin
        if(we_i)
            data[addr_i] <= din_i;
        else
            dout_o <= data[addr_i];
    end
end

endmodule