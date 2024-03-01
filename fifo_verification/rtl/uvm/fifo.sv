`timescale 1ns / 1ps

module fifo #(parameter DEPTH = 63, WIDTH = 8) (
    input                      clk,                            // clock
    input                      rst,                            // reset
    input                      wr_en,                          // write enable
    input                      rd_en,                          // read enable
    input        [WIDTH-1:0]   data_in,                        // input data
    output logic               empty,                          
    output logic               full,
    output logic [WIDTH-1:0]   data_out                        // output data
    );

    logic [WIDTH-1:0]          data_mem        [DEPTH];        // data memory array used for storing data at contiguous memory locations
    logic [$clog2(DEPTH)-1:0]  wr_ptr;                         // pointers used to point locations in array
    logic [$clog2(DEPTH)-1:0]  rd_ptr;

    always_ff @(posedge clk) begin
        if (rst) begin                                         // initialize signals
            wr_ptr           <= 0;
            rd_ptr           <= 0;
            data_out         <= 0;
            empty            <= 1;
            full             <= 0;
        end

        else begin
            if (wr_en && !full) begin                          // condition for filling the fifo 
                data_mem[wr_ptr] <= data_in;
                wr_ptr           <= wr_ptr + 1;
                
                if (wr_ptr == DEPTH - 1) begin
                    full   <= 1;
                end
            end
            
            if (rd_en    && !empty) begin                       // condition for taking data
                data_out <= data_mem[rd_ptr];
                rd_ptr   <= rd_ptr + 1;
                
                if (rd_ptr == DEPTH - 1) begin
                    empty  <= 1;
                end
            end
            
            else begin
                empty <= 0;
            end
        end
    end
endmodule
