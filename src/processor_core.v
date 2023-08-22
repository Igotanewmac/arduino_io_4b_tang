











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

    // 14 bit address registers
    reg [13:0] usr_address_0;
    reg [13:0] usr_address_1;
    reg [13:0] usr_address_2;
    reg [13:0] usr_address_3;
    reg [13:0] usr_address_4;
    reg [13:0] usr_address_5;
    reg [13:0] usr_address_6;
    reg [13:0] usr_address_7;
    reg [13:0] usr_address_8;
    reg [13:0] usr_address_9;
    reg [13:0] usr_address_A;
    reg [13:0] usr_address_B;
    reg [13:0] usr_address_C;
    reg [13:0] usr_address_D;
    reg [13:0] usr_address_E;
    reg [13:0] usr_address_F;
    
    // 8 bit data registers
    reg [7:0]  usr_data_0;
    reg [7:0]  usr_data_1;
    reg [7:0]  usr_data_2;
    reg [7:0]  usr_data_3;
    reg [7:0]  usr_data_4;
    reg [7:0]  usr_data_5;
    reg [7:0]  usr_data_6;
    reg [7:0]  usr_data_7;
    reg [7:0]  usr_data_8;
    reg [7:0]  usr_data_9;
    reg [7:0]  usr_data_A;
    reg [7:0]  usr_data_B;
    reg [7:0]  usr_data_C;
    reg [7:0]  usr_data_D;
    reg [7:0]  usr_data_E;
    reg [7:0]  usr_data_F;
    

    // 16 bit wideptr registers
    reg [15:0] usr_wideptr_0;
    reg [15:0] usr_wideptr_1;
    reg [15:0] usr_wideptr_2;
    reg [15:0] usr_wideptr_3;
    reg [15:0] usr_wideptr_4;
    reg [15:0] usr_wideptr_5;
    reg [15:0] usr_wideptr_6;
    reg [15:0] usr_wideptr_7;
    reg [15:0] usr_wideptr_8;
    reg [15:0] usr_wideptr_9;
    reg [15:0] usr_wideptr_A;
    reg [15:0] usr_wideptr_B;
    reg [15:0] usr_wideptr_C;
    reg [15:0] usr_wideptr_D;
    reg [15:0] usr_wideptr_E;
    reg [15:0] usr_wideptr_F;
    
    
    // bank selection register
    reg [7:0] usr_bank_select;

    // register selection register
    reg [15:0] usr_register_select;




    // cpu mode registers

    // 14 bit address registers
    reg [13:0] cpu_address_0;
    reg [13:0] cpu_address_1;
    reg [13:0] cpu_address_2;
    reg [13:0] cpu_address_3;
    reg [13:0] cpu_address_4;
    reg [13:0] cpu_address_5;
    reg [13:0] cpu_address_6;
    reg [13:0] cpu_address_7;
    reg [13:0] cpu_address_8;
    reg [13:0] cpu_address_9;
    reg [13:0] cpu_address_A;
    reg [13:0] cpu_address_B;
    reg [13:0] cpu_address_C;
    reg [13:0] cpu_address_D;
    reg [13:0] cpu_address_E;
    reg [13:0] cpu_address_F;
    

    // 8 bit data registers
    reg [7:0] cpu_data_0;
    reg [7:0] cpu_data_1;
    reg [7:0] cpu_data_2;
    reg [7:0] cpu_data_3;
    reg [7:0] cpu_data_4;
    reg [7:0] cpu_data_5;
    reg [7:0] cpu_data_6;
    reg [7:0] cpu_data_7;
    reg [7:0] cpu_data_8;
    reg [7:0] cpu_data_9;
    reg [7:0] cpu_data_A;
    reg [7:0] cpu_data_B;
    reg [7:0] cpu_data_C;
    reg [7:0] cpu_data_D;
    reg [7:0] cpu_data_E;
    reg [7:0] cpu_data_F;
    

    // 16 bit wideptr registers
    reg [15:0] cpu_wideptr_0;
    reg [15:0] cpu_wideptr_1;
    reg [15:0] cpu_wideptr_2;
    reg [15:0] cpu_wideptr_3;
    reg [15:0] cpu_wideptr_4;
    reg [15:0] cpu_wideptr_5;
    reg [15:0] cpu_wideptr_6;
    reg [15:0] cpu_wideptr_7;
    reg [15:0] cpu_wideptr_8;
    reg [15:0] cpu_wideptr_9;
    reg [15:0] cpu_wideptr_A;
    reg [15:0] cpu_wideptr_B;
    reg [15:0] cpu_wideptr_C;
    reg [15:0] cpu_wideptr_D;
    reg [15:0] cpu_wideptr_E;
    reg [15:0] cpu_wideptr_F;
    






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
                                    cpu_address_0 = 14'd0;
                                    cpu_data_0 = 8'd0;
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
                                    cpu_data_0 <= mem_cmd_dout;
                                    reg_statemachine_command <= 8'h04;
                                end

                                // set up memory transaction
                                8'h04 : begin
                                    case (usr_bank_select[7:6])
                                        2'b00 : begin
                                            mem_src_ad <= cpu_address_0;
                                            mem_src_din <= cpu_data_0;
                                            mem_src_ce <= 1'b1;
                                            mem_src_wre <= 1'b1;
                                        end
                                        2'b01 : begin
                                            mem_key_ad <= cpu_address_0;
                                            mem_key_din <= cpu_data_0;
                                            mem_key_ce <= 1'b1;
                                            mem_key_wre <= 1'b1;
                                        end
                                        2'b10 : begin
                                            mem_cmd_ad <= cpu_address_0;
                                            mem_cmd_din <= cpu_data_0;
                                            mem_cmd_ce <= 1'b1;
                                            mem_cmd_wre <= 1'b1;
                                        end
                                        2'b11 : begin
                                            mem_dst_ad <= cpu_address_0;
                                            mem_dst_din <= cpu_data_0;
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
                                    cpu_address_0 <= cpu_address_0 + 1;
                                    reg_statemachine_command <= 8'h07;
                                end

                                // loop
                                8'h07 : begin
                                    if ( cpu_address_0 == 14'd0 ) reg_statemachine_command <= 8'h08;
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


                        // 0x20 load immedeate value into register select register
                        8'h20 : begin
                            case (reg_statemachine_command)

                                // increment program counter
                                8'h00 : begin
                                    reg_programcounter <= reg_programcounter + 1;
                                    reg_statemachine_command <= 8'h01;
                                end

                                // prepare memory transaction
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

                                // clock down and copy
                                8'h03 : begin
                                    mem_cmd_clk <= 1'b0;
                                    usr_register_select[15:8] <= mem_cmd_dout;
                                    reg_statemachine_command <= 8'h04;
                                end

                                // increment program counter
                                8'h04 : begin
                                    reg_programcounter <= reg_programcounter + 1;
                                    reg_statemachine_command <= 8'h05;
                                end

                                // prepare memory transaction
                                8'h05 : begin
                                    mem_cmd_ad <= reg_programcounter;
                                    reg_statemachine_command <= 8'h06;
                                end

                                // clock up
                                8'h06 : begin
                                    mem_cmd_clk <= 1'b1;
                                    reg_statemachine_command <= 8'h07;
                                end

                                // clock down
                                8'h07 : begin
                                    mem_cmd_clk <= 1'b0;
                                    usr_register_select[7:0] <= mem_cmd_dout;
                                    reg_statemachine_command <= 8'h08;
                                end

                                // finish
                                8'h08 : begin
                                    mem_cmd_ce <= 1'b0;
                                    mem_cmd_oce <= 1'b0;
                                    reg_statemachine_program <= 8'hFE;
                                end



                            endcase
                        end

                        // 0x21 write register select register to src 0x0000
                        8'h21 : begin
                            case (reg_statemachine_command)


                                // prepare for memory transaction
                                8'h00 : begin
                                    mem_src_ad <= 14'd0;
                                    mem_src_din <= usr_register_select[15:8];
                                    mem_src_ce <= 1'b1;
                                    mem_src_wre <= 1'b1;
                                    reg_statemachine_command <= 8'h01;
                                end

                                // clock up
                                8'h01 : begin
                                    mem_src_clk <= 1'b1;
                                    reg_statemachine_command <= 8'h02;
                                end

                                // clock down
                                8'h02 : begin
                                    mem_src_clk <= 1'b0;
                                    reg_statemachine_command <= 8'h03;
                                end

                                // prepare for memory transaction
                                8'h03 : begin
                                    mem_src_ad <= 14'd1;
                                    mem_src_din <= usr_register_select[7:0];
                                    reg_statemachine_command <= 8'h04;
                                end

                                // clock up
                                8'h04 : begin
                                    mem_src_clk <= 1'b1;
                                    reg_statemachine_command <= 8'h05;
                                end

                                // clock down
                                8'h05 : begin
                                    mem_src_clk <= 1'b0;
                                    mem_src_ce <= 1'b0;
                                    mem_src_wre <= 1'b0;
                                    reg_statemachine_program <= 8'hFE;
                                end



                            endcase
                        end


                        
                        // 0x23 write register A to wideptr B
                        8'h23 : begin
                            case (reg_statemachine_command)

                                
                                // select register A into register 0
                                8'h00 : begin
                                    case (usr_register_select[15:12])
                                        // usr_data
                                        4'b0000 : begin
                                            case (usr_register_select[11:8])
                                                4'b0000 : cpu_data_0 <= usr_data_0;
                                                4'b0001 : cpu_data_0 <= usr_data_1;
                                                4'b0010 : cpu_data_0 <= usr_data_2;
                                                4'b0011 : cpu_data_0 <= usr_data_3;
                                                4'b0100 : cpu_data_0 <= usr_data_4;
                                                4'b0101 : cpu_data_0 <= usr_data_5;
                                                4'b0110 : cpu_data_0 <= usr_data_6;
                                                4'b0111 : cpu_data_0 <= usr_data_7;
                                                4'b1000 : cpu_data_0 <= usr_data_8;
                                                4'b1001 : cpu_data_0 <= usr_data_9;
                                                4'b1010 : cpu_data_0 <= usr_data_A;
                                                4'b1011 : cpu_data_0 <= usr_data_B;
                                                4'b1100 : cpu_data_0 <= usr_data_C;
                                                4'b1101 : cpu_data_0 <= usr_data_D;
                                                4'b1110 : cpu_data_0 <= usr_data_E;
                                                4'b1111 : cpu_data_0 <= usr_data_F;
                                            endcase
                                        end
                                        // usr_wideptr high
                                        4'b1000 : begin
                                            case (usr_register_select[11:8])
                                                4'b0000 : cpu_data_0 <= usr_wideptr_0[15:8];
                                                4'b0001 : cpu_data_0 <= usr_wideptr_1[15:8];
                                                4'b0010 : cpu_data_0 <= usr_wideptr_2[15:8];
                                                4'b0011 : cpu_data_0 <= usr_wideptr_3[15:8];
                                                4'b0100 : cpu_data_0 <= usr_wideptr_4[15:8];
                                                4'b0101 : cpu_data_0 <= usr_wideptr_5[15:8];
                                                4'b0110 : cpu_data_0 <= usr_wideptr_6[15:8];
                                                4'b0111 : cpu_data_0 <= usr_wideptr_7[15:8];
                                                4'b1000 : cpu_data_0 <= usr_wideptr_8[15:8];
                                                4'b1001 : cpu_data_0 <= usr_wideptr_9[15:8];
                                                4'b1010 : cpu_data_0 <= usr_wideptr_A[15:8];
                                                4'b1011 : cpu_data_0 <= usr_wideptr_B[15:8];
                                                4'b1100 : cpu_data_0 <= usr_wideptr_C[15:8];
                                                4'b1101 : cpu_data_0 <= usr_wideptr_D[15:8];
                                                4'b1110 : cpu_data_0 <= usr_wideptr_E[15:8];
                                                4'b1111 : cpu_data_0 <= usr_wideptr_F[15:8];
                                            endcase
                                        end
                                        // usr_wideptr
                                        4'b0100 : begin
                                            case (usr_register_select[11:8])
                                                4'b0000 : cpu_data_0 <= usr_wideptr_0[7:0];
                                                4'b0001 : cpu_data_0 <= usr_wideptr_1[7:0];
                                                4'b0010 : cpu_data_0 <= usr_wideptr_2[7:0];
                                                4'b0011 : cpu_data_0 <= usr_wideptr_3[7:0];
                                                4'b0100 : cpu_data_0 <= usr_wideptr_4[7:0];
                                                4'b0101 : cpu_data_0 <= usr_wideptr_5[7:0];
                                                4'b0110 : cpu_data_0 <= usr_wideptr_6[7:0];
                                                4'b0111 : cpu_data_0 <= usr_wideptr_7[7:0];
                                                4'b1000 : cpu_data_0 <= usr_wideptr_8[7:0];
                                                4'b1001 : cpu_data_0 <= usr_wideptr_9[7:0];
                                                4'b1010 : cpu_data_0 <= usr_wideptr_A[7:0];
                                                4'b1011 : cpu_data_0 <= usr_wideptr_B[7:0];
                                                4'b1100 : cpu_data_0 <= usr_wideptr_C[7:0];
                                                4'b1101 : cpu_data_0 <= usr_wideptr_D[7:0];
                                                4'b1110 : cpu_data_0 <= usr_wideptr_E[7:0];
                                                4'b1111 : cpu_data_0 <= usr_wideptr_F[7:0];
                                            endcase
                                        end
                                        // usr_address
                                        4'b0010 : begin
                                            case (usr_register_select[11:8])
                                                4'b0000 : cpu_data_0 <= { 2'b00 , usr_address_0[13:8] };
                                                4'b0001 : cpu_data_0 <= { 2'b00 , usr_address_1[13:8] };
                                                4'b0010 : cpu_data_0 <= { 2'b00 , usr_address_2[13:8] };
                                                4'b0011 : cpu_data_0 <= { 2'b00 , usr_address_3[13:8] };
                                                4'b0100 : cpu_data_0 <= { 2'b00 , usr_address_4[13:8] };
                                                4'b0101 : cpu_data_0 <= { 2'b00 , usr_address_5[13:8] };
                                                4'b0110 : cpu_data_0 <= { 2'b00 , usr_address_6[13:8] };
                                                4'b0111 : cpu_data_0 <= { 2'b00 , usr_address_7[13:8] };
                                                4'b1000 : cpu_data_0 <= { 2'b00 , usr_address_8[13:8] };
                                                4'b1001 : cpu_data_0 <= { 2'b00 , usr_address_9[13:8] };
                                                4'b1010 : cpu_data_0 <= { 2'b00 , usr_address_A[13:8] };
                                                4'b1011 : cpu_data_0 <= { 2'b00 , usr_address_B[13:8] };
                                                4'b1100 : cpu_data_0 <= { 2'b00 , usr_address_C[13:8] };
                                                4'b1101 : cpu_data_0 <= { 2'b00 , usr_address_D[13:8] };
                                                4'b1110 : cpu_data_0 <= { 2'b00 , usr_address_E[13:8] };
                                                4'b1111 : cpu_data_0 <= { 2'b00 , usr_address_F[13:8] };
                                            endcase
                                        end
                                        // usr_data
                                        4'b0001 : begin
                                            case (usr_register_select[11:8])
                                                4'b0000 : cpu_data_0 <= usr_address_0[7:0];
                                                4'b0001 : cpu_data_0 <= usr_address_1[7:0];
                                                4'b0010 : cpu_data_0 <= usr_address_2[7:0];
                                                4'b0011 : cpu_data_0 <= usr_address_3[7:0];
                                                4'b0100 : cpu_data_0 <= usr_address_4[7:0];
                                                4'b0101 : cpu_data_0 <= usr_address_5[7:0];
                                                4'b0110 : cpu_data_0 <= usr_address_6[7:0];
                                                4'b0111 : cpu_data_0 <= usr_address_7[7:0];
                                                4'b1000 : cpu_data_0 <= usr_address_8[7:0];
                                                4'b1001 : cpu_data_0 <= usr_address_9[7:0];
                                                4'b1010 : cpu_data_0 <= usr_address_A[7:0];
                                                4'b1011 : cpu_data_0 <= usr_address_B[7:0];
                                                4'b1100 : cpu_data_0 <= usr_address_C[7:0];
                                                4'b1101 : cpu_data_0 <= usr_address_D[7:0];
                                                4'b1110 : cpu_data_0 <= usr_address_E[7:0];
                                                4'b1111 : cpu_data_0 <= usr_address_F[7:0];
                                            endcase
                                        end
                                    endcase
                                    reg_statemachine_command <= 8'h01;
                                end

                                


                                
                                // select register B into wideptr 0
                                8'h01 : begin
                                    case (usr_register_select[3:0])
                                        4'b0000 : cpu_wideptr_0 <= usr_wideptr_0;
                                        4'b0001 : cpu_wideptr_0 <= usr_wideptr_1;
                                        4'b0010 : cpu_wideptr_0 <= usr_wideptr_2;
                                        4'b0011 : cpu_wideptr_0 <= usr_wideptr_3;
                                        4'b0100 : cpu_wideptr_0 <= usr_wideptr_4;
                                        4'b0101 : cpu_wideptr_0 <= usr_wideptr_5;
                                        4'b0110 : cpu_wideptr_0 <= usr_wideptr_6;
                                        4'b0111 : cpu_wideptr_0 <= usr_wideptr_7;
                                        4'b1000 : cpu_wideptr_0 <= usr_wideptr_8;
                                        4'b1001 : cpu_wideptr_0 <= usr_wideptr_9;
                                        4'b1010 : cpu_wideptr_0 <= usr_wideptr_A;
                                        4'b1011 : cpu_wideptr_0 <= usr_wideptr_B;
                                        4'b1100 : cpu_wideptr_0 <= usr_wideptr_C;
                                        4'b1101 : cpu_wideptr_0 <= usr_wideptr_D;
                                        4'b1110 : cpu_wideptr_0 <= usr_wideptr_E;
                                        4'b1111 : cpu_wideptr_0 <= usr_wideptr_F;
                                    endcase
                                    reg_statemachine_command <= 8'h02;
                                end
                                
                                
                                // prepare memory transaction
                                8'h02 : begin
                                    case (cpu_wideptr_0[15:14])
                                        2'b00 : begin
                                            mem_src_ad <= cpu_wideptr_0[13:0];
                                            mem_src_din <= cpu_data_0;
                                            mem_src_ce <= 1'b1;
                                            mem_src_wre <= 1'b1;
                                        end
                                        2'b01 : begin
                                            mem_key_ad <= cpu_wideptr_0[13:0];
                                            mem_key_din <= cpu_data_0;
                                            mem_key_ce <= 1'b1;
                                            mem_key_wre <= 1'b1;
                                        end
                                        2'b10 : begin
                                            mem_cmd_ad <= cpu_wideptr_0[13:0];
                                            mem_cmd_din <= cpu_data_0;
                                            mem_cmd_ce <= 1'b1;
                                            mem_cmd_wre <= 1'b1;
                                        end
                                        2'b11 : begin
                                            mem_dst_ad <= cpu_wideptr_0[13:0];
                                            mem_dst_din <= cpu_data_0;
                                            mem_dst_ce <= 1'b1;
                                            mem_dst_wre <= 1'b1;
                                        end
                                    endcase
                                    reg_statemachine_command <= 8'h03;
                                end

                                
                                // clock high
                                8'h03 : begin
                                    case (cpu_wideptr_0[15:14])
                                        2'b00 : mem_src_clk <= 1'b1;
                                        2'b01 : mem_key_clk <= 1'b1;
                                        2'b10 : mem_cmd_clk <= 1'b1;
                                        2'b11 : mem_dst_clk <= 1'b1;
                                    endcase
                                    reg_statemachine_command <= 8'h04;
                                end
                                
                                // clock low
                                8'h04 : begin
                                    mem_src_clk <= 1'b0;
                                    mem_key_clk <= 1'b0;
                                    mem_cmd_clk <= 1'b0;
                                    mem_dst_clk <= 1'b0;
                                    reg_statemachine_command <= 8'h05;
                                end

                                // finish up
                                8'h05 : begin
                                    mem_src_ce <= 1'b0;
                                    mem_src_wre <= 1'b0;
                                    mem_key_ce <= 1'b0;
                                    mem_key_wre <= 1'b0;
                                    mem_cmd_ce <= 1'b0;
                                    mem_cmd_wre <= 1'b0;
                                    mem_dst_ce <= 1'b0;
                                    mem_dst_wre <= 1'b0;
                                    
                                    reg_statemachine_program <= 8'hFE;
                                end

                                
                                
                            endcase
                        end
                        


                        // 0x24 load immedeate into register
                        8'h24 : begin
                            case (reg_statemachine_command)

                                // initialise and increment program counter
                                8'h00 : begin
                                    cpu_address_0 <= 14'd0;
                                    cpu_data_0 <= 8'd0;
                                    reg_programcounter <= reg_programcounter + 1;
                                    reg_statemachine_command <= 8'h01;
                                end

                                // prepare memory transaction
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

                                // clock down and copy data into cpu register
                                8'h03 : begin
                                    mem_cmd_clk <= 1'b0;
                                    cpu_data_0 <= mem_cmd_dout;
                                    reg_programcounter <= reg_programcounter + 1;
                                    reg_statemachine_command <= 8'h04;
                                end

                                
                                // prepare for memory transaction
                                8'h04 : begin
                                    mem_cmd_ad <= reg_programcounter;
                                    reg_statemachine_command <= 8'h05;
                                end


                                // clock up
                                8'h05 : begin
                                    mem_cmd_clk <= 1'b1;
                                    reg_statemachine_command <= 8'h06;
                                end

                                // clock down
                                8'h06 : begin
                                    mem_cmd_clk <= 1'b0;
                                    mem_cmd_ce <= 1'b0;
                                    mem_cmd_oce <= 1'b0;
                                    reg_statemachine_command <= 8'h07;
                                end

                                // copy data to register
                                8'h07 : begin

                                    case (cpu_data_0[7:4])
                                        // 0000 data register
                                        4'b0000 : begin
                                            case (cpu_data_0[3:0])
                                                4'b0000 : usr_data_0 <= mem_cmd_dout;
                                                4'b0001 : usr_data_1 <= mem_cmd_dout;
                                                4'b0010 : usr_data_2 <= mem_cmd_dout;
                                                4'b0011 : usr_data_3 <= mem_cmd_dout;
                                                4'b0100 : usr_data_4 <= mem_cmd_dout;
                                                4'b0101 : usr_data_5 <= mem_cmd_dout;
                                                4'b0110 : usr_data_6 <= mem_cmd_dout;
                                                4'b0111 : usr_data_7 <= mem_cmd_dout;
                                                4'b1000 : usr_data_8 <= mem_cmd_dout;
                                                4'b1001 : usr_data_9 <= mem_cmd_dout;
                                                4'b1010 : usr_data_A <= mem_cmd_dout;
                                                4'b1011 : usr_data_B <= mem_cmd_dout;
                                                4'b1100 : usr_data_C <= mem_cmd_dout;
                                                4'b1101 : usr_data_D <= mem_cmd_dout;
                                                4'b1110 : usr_data_E <= mem_cmd_dout;
                                                4'b1111 : usr_data_F <= mem_cmd_dout;
                                            endcase
                                        end
                                        
                                        // 1000 wideptr high
                                        4'b1000 : begin
                                            case (cpu_data_0[3:0])
                                                4'b0000 : usr_wideptr_0[15:8] <= mem_cmd_dout;
                                                4'b0001 : usr_wideptr_1[15:8] <= mem_cmd_dout;
                                                4'b0010 : usr_wideptr_2[15:8] <= mem_cmd_dout;
                                                4'b0011 : usr_wideptr_3[15:8] <= mem_cmd_dout;
                                                4'b0100 : usr_wideptr_4[15:8] <= mem_cmd_dout;
                                                4'b0101 : usr_wideptr_5[15:8] <= mem_cmd_dout;
                                                4'b0110 : usr_wideptr_6[15:8] <= mem_cmd_dout;
                                                4'b0111 : usr_wideptr_7[15:8] <= mem_cmd_dout;
                                                4'b1000 : usr_wideptr_8[15:8] <= mem_cmd_dout;
                                                4'b1001 : usr_wideptr_9[15:8] <= mem_cmd_dout;
                                                4'b1010 : usr_wideptr_A[15:8] <= mem_cmd_dout;
                                                4'b1011 : usr_wideptr_B[15:8] <= mem_cmd_dout;
                                                4'b1100 : usr_wideptr_C[15:8] <= mem_cmd_dout;
                                                4'b1101 : usr_wideptr_D[15:8] <= mem_cmd_dout;
                                                4'b1110 : usr_wideptr_E[15:8] <= mem_cmd_dout;
                                                4'b1111 : usr_wideptr_F[15:8] <= mem_cmd_dout;
                                            endcase
                                        end

                                        // 0100 wideptr low
                                        4'b0100 : begin
                                            case (cpu_data_0[3:0])
                                                4'b0000 : usr_wideptr_0[7:0] <= mem_cmd_dout;
                                                4'b0001 : usr_wideptr_1[7:0] <= mem_cmd_dout;
                                                4'b0010 : usr_wideptr_2[7:0] <= mem_cmd_dout;
                                                4'b0011 : usr_wideptr_3[7:0] <= mem_cmd_dout;
                                                4'b0100 : usr_wideptr_4[7:0] <= mem_cmd_dout;
                                                4'b0101 : usr_wideptr_5[7:0] <= mem_cmd_dout;
                                                4'b0110 : usr_wideptr_6[7:0] <= mem_cmd_dout;
                                                4'b0111 : usr_wideptr_7[7:0] <= mem_cmd_dout;
                                                4'b1000 : usr_wideptr_8[7:0] <= mem_cmd_dout;
                                                4'b1001 : usr_wideptr_9[7:0] <= mem_cmd_dout;
                                                4'b1010 : usr_wideptr_A[7:0] <= mem_cmd_dout;
                                                4'b1011 : usr_wideptr_B[7:0] <= mem_cmd_dout;
                                                4'b1100 : usr_wideptr_C[7:0] <= mem_cmd_dout;
                                                4'b1101 : usr_wideptr_D[7:0] <= mem_cmd_dout;
                                                4'b1110 : usr_wideptr_E[7:0] <= mem_cmd_dout;
                                                4'b1111 : usr_wideptr_F[7:0] <= mem_cmd_dout;
                                            endcase
                                        end

                                        // 0010 wideptr high
                                        4'b0010 : begin
                                            case (cpu_data_0[3:0])
                                                4'b0000 : usr_address_0[13:8] <= mem_cmd_dout[5:0];
                                                4'b0001 : usr_address_1[13:8] <= mem_cmd_dout[5:0];
                                                4'b0010 : usr_address_2[13:8] <= mem_cmd_dout[5:0];
                                                4'b0011 : usr_address_3[13:8] <= mem_cmd_dout[5:0];
                                                4'b0100 : usr_address_4[13:8] <= mem_cmd_dout[5:0];
                                                4'b0101 : usr_address_5[13:8] <= mem_cmd_dout[5:0];
                                                4'b0110 : usr_address_6[13:8] <= mem_cmd_dout[5:0];
                                                4'b0111 : usr_address_7[13:8] <= mem_cmd_dout[5:0];
                                                4'b1000 : usr_address_8[13:8] <= mem_cmd_dout[5:0];
                                                4'b1001 : usr_address_9[13:8] <= mem_cmd_dout[5:0];
                                                4'b1010 : usr_address_A[13:8] <= mem_cmd_dout[5:0];
                                                4'b1011 : usr_address_B[13:8] <= mem_cmd_dout[5:0];
                                                4'b1100 : usr_address_C[13:8] <= mem_cmd_dout[5:0];
                                                4'b1101 : usr_address_D[13:8] <= mem_cmd_dout[5:0];
                                                4'b1110 : usr_address_E[13:8] <= mem_cmd_dout[5:0];
                                                4'b1111 : usr_address_F[13:8] <= mem_cmd_dout[5:0];
                                            endcase
                                        end

                                        // 0001 wideptr high
                                        4'b0001 : begin
                                            case (cpu_data_0[3:0])
                                                4'b0000 : usr_address_0[7:0] <= mem_cmd_dout;
                                                4'b0001 : usr_address_1[7:0] <= mem_cmd_dout;
                                                4'b0010 : usr_address_2[7:0] <= mem_cmd_dout;
                                                4'b0011 : usr_address_3[7:0] <= mem_cmd_dout;
                                                4'b0100 : usr_address_4[7:0] <= mem_cmd_dout;
                                                4'b0101 : usr_address_5[7:0] <= mem_cmd_dout;
                                                4'b0110 : usr_address_6[7:0] <= mem_cmd_dout;
                                                4'b0111 : usr_address_7[7:0] <= mem_cmd_dout;
                                                4'b1000 : usr_address_8[7:0] <= mem_cmd_dout;
                                                4'b1001 : usr_address_9[7:0] <= mem_cmd_dout;
                                                4'b1010 : usr_address_A[7:0] <= mem_cmd_dout;
                                                4'b1011 : usr_address_B[7:0] <= mem_cmd_dout;
                                                4'b1100 : usr_address_C[7:0] <= mem_cmd_dout;
                                                4'b1101 : usr_address_D[7:0] <= mem_cmd_dout;
                                                4'b1110 : usr_address_E[7:0] <= mem_cmd_dout;
                                                4'b1111 : usr_address_F[7:0] <= mem_cmd_dout;
                                            endcase
                                        end

                                        


                                    endcase
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































