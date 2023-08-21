











module processor_core (
    
    // sysclk
    input wire sysclk,

    // arduino
    input wire arduino_execute,
    output reg arduino_isfinished,
    input wire arduino_reset,

    // mem src
    input wire [7:0] mem_src_dout,
    output reg [7:0] mem_src_din,
    output reg [13:0] mem_src_ad,
    output reg mem_src_ce,
    output reg mem_src_wre,
    output reg mem_src_oce,
    output reg mem_src_clk,
    // mem key
    input wire [7:0] mem_key_dout,
    output reg [7:0] mem_key_din,
    output reg [13:0] mem_key_ad,
    output reg mem_key_ce,
    output reg mem_key_wre,
    output reg mem_key_oce,
    output reg mem_key_clk,
    // mem cmd
    input wire [7:0] mem_cmd_dout,
    output reg [7:0] mem_cmd_din,
    output reg [13:0] mem_cmd_ad,
    output reg mem_cmd_ce,
    output reg mem_cmd_wre,
    output reg mem_cmd_oce,
    output reg mem_cmd_clk,
    // mem dst
    input wire [7:0] mem_dst_dout,
    output reg [7:0] mem_dst_din,
    output reg [13:0] mem_dst_ad,
    output reg mem_dst_ce,
    output reg mem_dst_wre,
    output reg mem_dst_oce,
    output reg mem_dst_clk
    
);


    reg [13:0] reg_programcounter;

    reg [7:0] reg_commandbuffer;

    reg [7:0] reg_statemachine_program;

    reg [7:0] reg_statemachine_command;



    // user mode registers

    // bank selection register
    reg [7:0] usr_bank_select;




    // cpu mode registers

    // 14 bit address registers
    reg [13:0] cpu_address [3:0];

    // 8 bit data registers
    reg [7:0]  cpu_data [3:0];

    // 16 bit wideptr registers
    reg [15:0] cpu_wideptr [3:0];






    // do stuff!
    always @(posedge sysclk) begin

        //arduino_isfinished <= arduino_execute;

        if (arduino_reset) begin
            // reset condition!
            reg_programcounter <= 14'd0;
            reg_commandbuffer <= 8'h00;
            reg_statemachine_program <= 8'h00;
            reg_statemachine_command <= 8'h00;
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
                    reg_statemachine_command <= 8'h00;
                    reg_statemachine_program <= 8'h04;
                end

                // do something here!
                8'h04 : begin

                    case (reg_commandbuffer)

                        // 0x00 noop
                        8'h00 : reg_statemachine_program <= 8'hFE;

                        // 0x01 halt
                        8'h01 : reg_statemachine_program <= 8'hFF;

                        
                        
                        
                        // 0x10 load immedeate value into bank select register
                        8'h10 : begin
                           case (reg_statemachine_command)

                            // increment program counter
                            8'h00 : begin
                                reg_programcounter <= reg_programcounter + 1;
                                reg_statemachine_command <= 8'h01;
                            end

                            // set up memory transaction
                            8'h01 : begin
                                mem_cmd_ad <= reg_programcounter;
                                mem_cmd_ce <= 1'b1;
                                mem_cmd_oce <= 1'b1;
                                reg_statemachine_command <= 8'h02;
                            end

                            // clock up
                            8'h02 : begin
                                mem_cmd_clk <= 1'b1;
                                reg_statemachine_command <= 8'h03;
                            end

                            // clock down, copy and clean up
                            8'h03 : begin
                                mem_cmd_clk <= 1'b0;
                                mem_cmd_ce <= 1'b0;
                                mem_cmd_oce <= 1'b0;
                                usr_bank_select <= mem_cmd_dout;
                                reg_statemachine_program <= 8'hFE;
                            end

                           endcase
                        end


                        // 0x11 write bank select register to src 0x0000
                        8'h11 : begin
                            case (reg_statemachine_command)

                                // prepare for memory transaction
                                8'h00 : begin
                                    mem_src_ad <= 14'd0;
                                    mem_src_din <= usr_bank_select;
                                    mem_src_ce <= 1'b1;
                                    mem_src_wre <= 1'b1;
                                    reg_statemachine_command <= 8'h01;
                                end

                                // clock up
                                8'h01 : begin
                                    mem_src_clk <= 1'b1;
                                    reg_statemachine_command <= 8'h02;
                                end

                                // clock down and clean up
                                8'h02 : begin
                                    mem_src_clk <= 1'b0;
                                    mem_src_ce <= 1'b0;
                                    mem_src_wre <= 1'b0;
                                    reg_statemachine_program <= 8'hFE;
                                end

                            endcase
                        end


                        // 0x14 fill bank A with immedeate value
                        8'h14 : begin
                            case (reg_statemachine_command)

                                // increment program counter
                                8'h00 : begin
                                    reg_programcounter <= reg_programcounter + 1;
                                    cpu_address[0] = 14'd0;
                                    cpu_data[0] = 8'd0;
                                    reg_statemachine_command <= 8'h01;
                                end

                                // set up memory
                                8'h01 : begin
                                    mem_cmd_ad <= reg_programcounter;
                                    mem_cmd_ce <= 1'b1;
                                    mem_cmd_oce <= 1'b1;
                                    reg_statemachine_command <= 8'h02;
                                end

                                // clock up
                                8'h02 : begin
                                    mem_cmd_clk <= 1'b1;
                                    reg_statemachine_command <= 8'h03;
                                end

                                // clock down
                                8'h03 : begin
                                    mem_cmd_clk <= 1'b0;
                                    mem_cmd_ce <= 1'b0;
                                    mem_cmd_oce <= 1'b0;
                                    cpu_data[0] <= mem_cmd_dout;
                                    reg_statemachine_command <= 8'h04;
                                end

                                // set up memory transaction
                                8'h04 : begin
                                    case (usr_bank_select[7:6])
                                        2'b00 : begin
                                            mem_src_ad <= cpu_address[0];
                                            mem_src_din <= cpu_data[0];
                                            mem_src_ce <= 1'b1;
                                            mem_src_wre <= 1'b1;
                                        end
                                        2'b01 : begin
                                            mem_key_ad <= cpu_address[0];
                                            mem_key_din <= cpu_data[0];
                                            mem_key_ce <= 1'b1;
                                            mem_key_wre <= 1'b1;
                                        end
                                        2'b10 : begin
                                            mem_cmd_ad <= cpu_address[0];
                                            mem_cmd_din <= cpu_data[0];
                                            mem_cmd_ce <= 1'b1;
                                            mem_cmd_wre <= 1'b1;
                                        end
                                        2'b11 : begin
                                            mem_dst_ad <= cpu_address[0];
                                            mem_dst_din <= cpu_data[0];
                                            mem_dst_ce <= 1'b1;
                                            mem_dst_wre <= 1'b1;
                                        end
                                    endcase
                                    reg_statemachine_command <= 8'h05;
                                end

                                // clock up
                                8'h05 : begin
                                    case (usr_bank_select[7:6])
                                        2'b00 : mem_src_clk <= 1'b1;
                                        2'b01 : mem_key_clk <= 1'b1;
                                        2'b10 : mem_cmd_clk <= 1'b1;
                                        2'b11 : mem_dst_clk <= 1'b1;
                                    endcase
                                    reg_statemachine_command <= 8'h06;
                                end

                                // clock down and increment
                                8'h06 : begin
                                    mem_src_clk <= 1'b0;
                                    mem_key_clk <= 1'b0;
                                    mem_cmd_clk <= 1'b0;
                                    mem_dst_clk <= 1'b0;
                                    cpu_address[0] <= cpu_address[0] + 1;
                                    reg_statemachine_command <= 8'h07;
                                end

                                // loop
                                8'h07 : begin
                                    if ( cpu_address[0] == 14'd0 ) reg_statemachine_command <= 8'h08;
                                    else reg_statemachine_command <= 8'h04;
                                end

                                // clean up
                                8'h08 : begin
                                    mem_src_ce <= 1'b0;
                                    mem_src_wre <= 1'b0;
                                    mem_src_oce <= 1'b0;
                                    mem_key_ce <= 1'b0;
                                    mem_key_wre <= 1'b0;
                                    mem_key_oce <= 1'b0;
                                    mem_cmd_ce <= 1'b0;
                                    mem_cmd_wre <= 1'b0;
                                    mem_cmd_oce <= 1'b0;
                                    mem_dst_ce <= 1'b0;
                                    mem_dst_wre <= 1'b0;
                                    mem_dst_oce <= 1'b0;

                                    reg_statemachine_program <= 8'hFE;

                                end



                            endcase
                        end







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































