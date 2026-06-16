module traffic_controller_tb;

reg clk;
reg reset;

wire roadA_red;
wire roadA_yellow;
wire roadA_green;
wire roadB_red;
wire roadB_yellow;
wire roadB_green;

traffic_controller uut (
    .clk(clk),
    .reset(reset),
    .roadA_red(roadA_red),
    .roadA_yellow(roadA_yellow),
    .roadA_green(roadA_green),
    .roadB_red(roadB_red),
    .roadB_yellow(roadB_yellow),
    .roadB_green(roadB_green)
);

always #5 clk = ~clk;

initial
begin
    $dumpfile("dump.vcd");
    $dumpvars;
end

initial
begin
    clk = 0;
    reset = 1;

    #10 reset = 0;

    #250 $finish;
end

initial
begin
    $monitor("Time=%0t | A: R=%b Y=%b G=%b | B: R=%b Y=%b G=%b",
             $time,
             roadA_red,
             roadA_yellow,
             roadA_green,
             roadB_red,
             roadB_yellow,
             roadB_green);
end

endmodule
