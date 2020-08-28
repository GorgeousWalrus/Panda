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
// Module name: testbench
// 
// Functionality: testbench for the core
//
// ------------------------------------------------------------

module testbench(
    input wire          ext_clk_i,
    input wire          ext_rstn_i,
    // Debug interface
    input wire          dbg_uart_rx_i,
    output wire         dbg_uart_tx_o
    // input wire [7:0]    dbg_cmd_i,
    // input wire [31:0]   dbg_addr_i,
    // input wire [31:0]   dbg_data_i,
    // output wire [31:0]  dbg_data_o,
    // output wire         dbg_ready_o
);

logic [7:0] gpio_dir;
logic [7:0] gpio_val;

logic uart_x;

core_wrapper core_i(
    .sys_clk_i  ( ext_clk_i),
    .rstn_i     ( ext_rstn_i),
    .gpio_dir_o ( gpio_dir ),
    .gpio_val_o ( gpio_val ),
    .gpio_val_i ( {gpio_val[0], gpio_val[1], gpio_val[2], gpio_val[3], gpio_val[4], gpio_val[5], gpio_val[6], gpio_val[7]} ),
    .uart_tx_o  ( uart_x   ),
    .uart_rx_i  ( uart_x   ),
    .*
);

endmodule