module vending_machine (
    input clk,
    input reset,
    input [1:0] coin,
    output reg dispense
);

    // Coin encoding
    // 00 = No coin
    // 01 = ₹5
    // 10 = ₹10

    // State encoding
    parameter S0  = 2'b00;
    parameter S5  = 2'b01;
    parameter S10 = 2'b10;
    parameter S15 = 2'b11;

    reg [1:0] state, next_state;

    // State register
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*)
    begin
        case (state)

            S0:
            begin
                case (coin)
                    2'b01: next_state = S5;   // ₹5
                    2'b10: next_state = S10;  // ₹10
                    default: next_state = S0;
                endcase
            end

            S5:
            begin
                case (coin)
                    2'b01: next_state = S10;  // ₹5 + ₹5
                    2'b10: next_state = S15;  // ₹5 + ₹10
                    default: next_state = S5;
                endcase
            end

            S10:
            begin
                case (coin)
                    2'b01: next_state = S15;  // ₹10 + ₹5
                    2'b10: next_state = S15;  // ₹10 + ₹10
                    default: next_state = S10;
                endcase
            end

            S15:
                next_state = S0;

            default:
                next_state = S0;

        endcase
    end

    // Moore output logic
    always @(*)
    begin
        case (state)

            S0:  dispense = 1'b0;
            S5:  dispense = 1'b0;
            S10: dispense = 1'b0;
            S15: dispense = 1'b1;

            default: dispense = 1'b0;

        endcase
    end

endmodule
