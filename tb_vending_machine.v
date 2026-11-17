module tb_vending_machine;

    reg clk;
    reg reset;
    reg [1:0] coin;
    wire dispense;

    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .coin(coin),
        .dispense(dispense)
    );

    // Clock generation
    initial
    begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // VCD generation
    initial
    begin
        $dumpfile("vending_machine.vcd");
        $dumpvars(0, tb_vending_machine);
    end

    initial
    begin
        reset = 1;
        coin = 2'b00;

        #10;
        reset = 0;

        // Insert ₹5
        #10;
        coin = 2'b01;

        // Insert ₹5
        #10;
        coin = 2'b01;

        // Insert ₹5 -> total ₹15
        #10;
        coin = 2'b01;

        // No coin
        #10;
        coin = 2'b00;

        // Insert ₹10
        #10;
        coin = 2'b10;

        // Insert ₹5 -> total ₹15
        #10;
        coin = 2'b01;

        #20;

        $finish;
    end

endmodule
