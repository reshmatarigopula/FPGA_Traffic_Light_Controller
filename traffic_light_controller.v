module traffic_controller(
    input clk,
    input reset,
    output reg roadA_red,
    output reg roadA_yellow,
    output reg roadA_green,
    output reg roadB_red,
    output reg roadB_yellow,
    output reg roadB_green
);

reg [1:0] state;
reg [3:0] count;

parameter A_GREEN  = 2'b00;
parameter A_YELLOW = 2'b01;
parameter B_GREEN  = 2'b10;
parameter B_YELLOW = 2'b11;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= A_GREEN;
        count <= 0;
    end
    else
    begin
        count <= count + 1;

        case(state)

            A_GREEN:
            begin
                if(count == 5)
                begin
                    state <= A_YELLOW;
                    count <= 0;
                end
            end

            A_YELLOW:
            begin
                if(count == 2)
                begin
                    state <= B_GREEN;
                    count <= 0;
                end
            end

            B_GREEN:
            begin
                if(count == 5)
                begin
                    state <= B_YELLOW;
                    count <= 0;
                end
            end

            B_YELLOW:
            begin
                if(count == 2)
                begin
                    state <= A_GREEN;
                    count <= 0;
                end
            end

        endcase
    end
end

always @(*)
begin

    roadA_red    = 0;
    roadA_yellow = 0;
    roadA_green  = 0;

    roadB_red    = 0;
    roadB_yellow = 0;
    roadB_green  = 0;

    case(state)

        A_GREEN:
        begin
            roadA_green = 1;
            roadB_red   = 1;
        end

        A_YELLOW:
        begin
            roadA_yellow = 1;
            roadB_red    = 1;
        end

        B_GREEN:
        begin
            roadA_red   = 1;
            roadB_green = 1;
        end

        B_YELLOW:
        begin
            roadA_red     = 1;
            roadB_yellow  = 1;
        end

    endcase

end

endmodule
