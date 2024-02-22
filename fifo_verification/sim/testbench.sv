`timescale 1ns / 1ps

module testbench;

    logic       clk;
    logic       rst;
    logic [7:0] data_out;
    
    fifo_top #(
        .WIDTH(8),
        .DEPTH(63)
        ) top(                              //instantiate the module fpga
        .clk(clk),
        .rst(rst),
        .data_out(data_out)
        );
    
    initial begin                           // initialize and generate clock and reset
        clk = 0;
        rst = 1;
        #10 rst = 0;
    end

    always begin
        #5
        clk = ~clk;
    end

endmodule
