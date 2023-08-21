











module processor_core (
    
    // sysclk
    input wire sysclk,

    // arduino
    input wire arduino_execute,
    output reg arduino_isfinished,
    input wire arduino_reset,

    // mem cmd
    input wire [7:0] mem_cmd_dout,
    output reg [7:0] mem_cmd_din,
    output reg [13:0] mem_cmd_ad,
    output reg mem_cmd_ce,
    output reg mem_cmd_wre,
    output reg mem_cmd_oce,
    output reg mem_cmd_clk

);


    reg [13:0] reg_programcounter;

    reg [7:0] reg_commandbuffer;


    reg [7:0] reg_statemachine_program;

    reg [7:0] reg_statemachine_command;

    // do stuff!
    always @(posedge sysclk) begin

        //arduino_isfinished <= arduino_execute;

        if (arduino_reset) begin
            // reset condition!
            reg_programcounter <= 14'd0;
            reg_commandbuffer <= 8'd0;
            reg_statemachine_program <= 8'd0;
            reg_statemachine_command <= 8'd0;
            arduino_isfinished <= 1'b0;
        end
        else begin
            
            case (reg_statemachine_program)

                // initialise and wait for execute
                8'h00 : begin
                    arduino_isfinished <= 1'b0;
                    reg_programcounter <= 14'd0;
                    reg_commandbuffer <= 8'b0;
                    reg_statemachine_command <= 8'h00;
                    if ( arduino_execute ) reg_statemachine_program <= 8'h01;
                end

                // set up memory transaction
                8'h01 : begin
                    mem_cmd_ad <= reg_programcounter;
                    mem_cmd_ce <= 1'b1;
                    mem_cmd_oce <= 1'b1;
                    reg_statemachine_program <= 8'h02;
                end

                // clock up
                8'h02 : begin
                    mem_cmd_clk <= 1'b1;
                    reg_statemachine_program <= 8'h03;
                end

                // clock down
                8'h03 : begin
                    mem_cmd_clk <= 1'b0;
                    mem_cmd_ce <= 1'b0;
                    mem_cmd_oce <= 1'b0;
                    reg_commandbuffer <= mem_cmd_dout;
                    reg_statemachine_program <= 8'h04;
                end

                // do something here!
                8'h04 : begin

                    case (reg_commandbuffer)

                        // 0x00 noop
                        8'h00 : reg_statemachine_program <= 8'hFE;

                        // 0x01 halt
                        8'h01 : reg_statemachine_program <= 8'hFF;

                    endcase
                    
                end


                // go around
                8'hFE : begin
                    reg_programcounter <= reg_programcounter + 1;
                    reg_statemachine_program <= 8'h01;
                end



                // set finished and halt
                8'hFF : begin
                    arduino_isfinished <= 1'b1;
                    if (!arduino_execute) reg_statemachine_program <= 8'h00;
                end

            endcase


        end 

        

    end





    
endmodule































