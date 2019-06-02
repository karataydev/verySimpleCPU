`timescale 1ns / 1ns

module testbench;
parameter SIZE = 14, DEPTH = 1024;

reg clk;
initial begin
  clk = 1;
  forever
	  #5 clk = ~clk;
end

reg rst;
initial begin
  rst = 1;
  repeat (10) @(posedge clk);
  rst <= #1 0;
  repeat (600) @(posedge clk);
  // uncomment the following line to display the content at address 50 in console
  $display("Content of address 101 is %d.", inst_blram.memory[101]);
  $finish;
end

wire wrEn;
wire [SIZE-1:0] addr_toRAM;
wire [31:0] data_toRAM, data_fromRAM;

VerySimpleCPU inst_VerySimpleCPU(
  .clk(clk),
  .rst(rst),
  .wrEn(wrEn),
  .data_fromRAM(data_fromRAM),
  .addr_toRAM(addr_toRAM),
  .data_toRAM(data_toRAM)
);

blram #(SIZE, DEPTH) inst_blram(
  .clk(clk),
  .rst(rst),
  .i_we(wrEn),
  .i_addr(addr_toRAM),
  .i_ram_data_in(data_toRAM),
  .o_ram_data_out(data_fromRAM)
);

endmodule

module blram(clk, rst, i_we, i_addr, i_ram_data_in, o_ram_data_out);

parameter SIZE = 10, DEPTH = 1024;

input clk;
input rst;
input i_we;
input [SIZE-1:0] i_addr;
input [31:0] i_ram_data_in;
output reg [31:0] o_ram_data_out;

reg [31:0] memory[0:DEPTH-1];

always @(posedge clk) begin
  o_ram_data_out <= #1 memory[i_addr[SIZE-1:0]];
  if (i_we)
		memory[i_addr[SIZE-1:0]] <= #1 i_ram_data_in;
end 

initial begin
//////////////////////////
// write BRAM content here
memory[0] = 32'h20114045;
memory[1] = 32'h10114001;
memory[2] = 32'hb0118064;
memory[3] = 32'h190045;
memory[4] = 32'h8011c064;
memory[5] = 32'h7011c001;
memory[6] = 32'h10118001;
memory[7] = 32'hc0120047;
memory[8] = 32'h118045;
memory[9] = 32'ha0128046;
memory[10] = 32'h8012c046;
memory[11] = 32'h12c045;
memory[12] = 32'ha013004b;
memory[13] = 32'he013004a;
memory[14] = 32'h8012804c;
memory[15] = 32'h8013404b;
memory[16] = 32'h701343e9;
memory[17] = 32'hc012404d;
memory[18] = 32'h8019404c;
memory[19] = 32'hd0050013;
memory[20] = 32'h0;
memory[69] = 32'h1;
memory[70] = 32'h3e8;
memory[72] = 32'h2;
memory[73] = 32'hb;
memory[100] = 32'h6;
memory[101] = 32'h0;
memory[999] = 32'h1;


//////////////////////////
end

endmodule
