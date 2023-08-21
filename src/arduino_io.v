







module arduino_io (
    
    // sysclk
    input wire sysclk,
    
    // arduino
    input wire [7:0] arduino_dataout,
    output reg [7:0] arduino_datain,
    input wire arduino_shiftin,
    input wire arduino_readwrite,
    input wire arduino_commit,
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
    




    reg reg_readwrite_bit;

    reg [23:0] reg_shiftregister_input;

    reg [1:0] reg_statemachine_shiftin;
    reg [1:0] reg_statemachine_commit;

    reg [1:0] reg_statemachine_memory;
    

    

    // need to have a sysclk based trigger so everything can write to everything
    always @(posedge sysclk) begin

        // if reset is high, hammer everything with zeros.
        if (arduino_reset) begin
            // reset condition
        end

        
        // on the rising edge of shiftin, trigger a data copy
        case (reg_statemachine_shiftin)

            // wait for rising edge
            2'b00 : begin
                if (arduino_shiftin) reg_statemachine_shiftin <= 2'b01;
                end

            // do the copy
            2'b01 : begin
                reg_shiftregister_input <= { reg_shiftregister_input[15:0] , arduino_dataout };
                reg_statemachine_shiftin <= 2'b10;
                end

            // wait for the falling edge
            2'b10 : begin
                if (!arduino_shiftin) reg_statemachine_shiftin <= 2'b00;
                end

        endcase

        case (reg_statemachine_commit)

            // chonky commit!
            
            // wait for rising edge
            2'b00 : begin
                reg_readwrite_bit <= arduino_readwrite;
                if (arduino_commit) reg_statemachine_commit <= 1'b01;
            end

            // do copy
            2'b01 : begin

                // if write
                if ( reg_readwrite_bit ) begin

                    // memory access part

                    case ( reg_statemachine_memory ) 

                        // set up memory
                        2'b00 : begin

                            case (reg_shiftregister_input[23:22])

                                2'b00 : begin
                                    mem_src_ad <= reg_shiftregister_input[21:8];
                                    mem_src_din <= reg_shiftregister_input[7:0];
                                    mem_src_ce <= 1'b1;
                                    mem_src_wre <= 1'b1;
                                end
                                2'b01 : begin
                                    mem_key_ad <= reg_shiftregister_input[21:8];
                                    mem_key_din <= reg_shiftregister_input[7:0];
                                    mem_key_ce <= 1'b1;
                                    mem_key_wre <= 1'b1;
                                end
                                2'b10 : begin
                                    mem_cmd_ad <= reg_shiftregister_input[21:8];
                                    mem_cmd_din <= reg_shiftregister_input[7:0];
                                    mem_cmd_ce <= 1'b1;
                                    mem_cmd_wre <= 1'b1;
                                end
                                2'b11 : begin
                                    mem_dst_ad <= reg_shiftregister_input[21:8];
                                    mem_dst_din <= reg_shiftregister_input[7:0];
                                    mem_dst_ce <= 1'b1;
                                    mem_dst_wre <= 1'b1;
                                end
                                
                            endcase

                            reg_statemachine_memory <= 2'b01;
                        end

                        // clock up
                        1'b01 : begin
                            case (reg_shiftregister_input[23:22])
                                2'b00 : mem_src_clk <= 1'b1;
                                2'b01 : mem_key_clk <= 1'b1;
                                2'b10 : mem_cmd_clk <= 1'b1;
                                2'b11 : mem_dst_clk <= 1'b1;
                            endcase

                            reg_statemachine_memory <= 2'b10;
                        end

                        // clock down and finsh up
                        2'b10 : begin
                            mem_src_clk <= 1'b0;
                            mem_src_ce <= 1'b0;
                            mem_src_wre <= 1'b0;
                            mem_key_clk <= 1'b0;
                            mem_key_ce <= 1'b0;
                            mem_key_wre <= 1'b0;
                            mem_cmd_clk <= 1'b0;
                            mem_cmd_ce <= 1'b0;
                            mem_cmd_wre <= 1'b0;
                            mem_dst_clk <= 1'b0;
                            mem_dst_ce <= 1'b0;
                            mem_dst_wre <= 1'b0;
                            reg_statemachine_commit <= 2'b10;
                        end

                        
                    endcase


                end
                // else it's a read
                else begin

                    // memory access part
                    
                    case ( reg_statemachine_memory ) 

                        // set up memory
                        2'b00 : begin

                            case (reg_shiftregister_input[15:14])

                                2'b00 : begin
                                    mem_src_ad <= reg_shiftregister_input[13:0];
                                    mem_src_ce <= 1'b1;
                                    mem_src_oce <= 1'b1;
                                end
                                2'b01 : begin
                                    mem_key_ad <= reg_shiftregister_input[13:0];
                                    mem_key_ce <= 1'b1;
                                    mem_key_oce <= 1'b1;
                                end
                                2'b10 : begin
                                    mem_cmd_ad <= reg_shiftregister_input[13:0];
                                    mem_cmd_ce <= 1'b1;
                                    mem_cmd_oce <= 1'b1;
                                end
                                2'b11 : begin
                                    mem_dst_ad <= reg_shiftregister_input[13:0];
                                    mem_dst_ce <= 1'b1;
                                    mem_dst_oce <= 1'b1;
                                end
                                
                            endcase

                            reg_statemachine_memory <= 2'b01;
                        end

                        // clock up
                        2'b01 : begin
                            case (reg_shiftregister_input[15:14])
                                2'b00 : mem_src_clk <= 1'b1;
                                2'b01 : mem_key_clk <= 1'b1;
                                2'b10 : mem_cmd_clk <= 1'b1;
                                2'b11 : mem_dst_clk <= 1'b1;
                            endcase

                            reg_statemachine_memory <= 2'b10;
                        end

                        // clock down and finsh up
                        2'b10 : begin
                            mem_src_clk <= 1'b0;
                            mem_src_ce <= 1'b0;
                            mem_src_wre <= 1'b0;
                            mem_key_clk <= 1'b0;
                            mem_key_ce <= 1'b0;
                            mem_key_wre <= 1'b0;
                            mem_cmd_clk <= 1'b0;
                            mem_cmd_ce <= 1'b0;
                            mem_cmd_wre <= 1'b0;
                            mem_dst_clk <= 1'b0;
                            mem_dst_ce <= 1'b0;
                            mem_dst_wre <= 1'b0;
                            case (reg_shiftregister_input[15:14])
                                2'b00 : arduino_datain <= mem_src_dout;
                                2'b10 : arduino_datain <= mem_key_dout;
                                2'b01 : arduino_datain <= mem_cmd_dout;
                                2'b11 : arduino_datain <= mem_dst_dout;
                            endcase
                            reg_statemachine_commit <= 2'b10;
                        end

                        
                    endcase


                end

            end

            // wait for falling edge
            2'b10 : begin
                reg_statemachine_memory <= 2'b00;
                if (!arduino_commit) reg_statemachine_commit <= 1'b00;
            end


        endcase


    end











endmodule
