






module lfsr_16bit_8high (
    input wire clock,
    input wire [7:0] keyin,
    input wire keyinclock,
    output reg [7:0] keyout,
    input wire keyoutclock
);

    reg [15:0] lfsr_storage_0;
    reg [15:0] lfsr_storage_1;
    reg [15:0] lfsr_storage_2;
    reg [15:0] lfsr_storage_3;
    reg [15:0] lfsr_storage_4;
    reg [15:0] lfsr_storage_5;
    reg [15:0] lfsr_storage_6;
    reg [15:0] lfsr_storage_7;



    always @(posedge clock) begin

        // what kind of clock is this?
        if ( keyinclock ) begin
            // shift the whole key space one byte to the left
            lfsr_storage_7 = { lfsr_storage_7[7:0] , lfsr_storage_6[15:8] };
            lfsr_storage_6 = { lfsr_storage_6[7:0] , lfsr_storage_5[15:8] };
            lfsr_storage_5 = { lfsr_storage_5[7:0] , lfsr_storage_4[15:8] };
            lfsr_storage_4 = { lfsr_storage_4[7:0] , lfsr_storage_3[15:8] };
            lfsr_storage_3 = { lfsr_storage_3[7:0] , lfsr_storage_2[15:8] };
            lfsr_storage_2 = { lfsr_storage_2[7:0] , lfsr_storage_1[15:8] };
            lfsr_storage_1 = { lfsr_storage_1[7:0] , lfsr_storage_0[15:8] };
            lfsr_storage_0 = { lfsr_storage_0[7:0] , keyin };
        end

        if ( keyoutclock ) begin

            // direct assignment!
            
            // these shifts *must* happen first, prior to the actual calulation.
            lfsr_storage_0[15:1] = lfsr_storage_0[14:0];
            lfsr_storage_1[15:1] = lfsr_storage_1[14:0];
            lfsr_storage_2[15:1] = lfsr_storage_2[14:0];
            lfsr_storage_3[15:1] = lfsr_storage_3[14:0];
            lfsr_storage_4[15:1] = lfsr_storage_4[14:0];
            lfsr_storage_5[15:1] = lfsr_storage_5[14:0];
            lfsr_storage_6[15:1] = lfsr_storage_6[14:0];
            lfsr_storage_7[15:1] = lfsr_storage_7[14:0];
            
            // after the shifts, calculate the new bit
            lfsr_storage_0[0] = ( ( ( lfsr_storage_0[15] ^ lfsr_storage_0[13] ) ^ lfsr_storage_0[12] ) ^ lfsr_storage_0[11] );
            lfsr_storage_1[0] = ( ( ( lfsr_storage_1[15] ^ lfsr_storage_1[13] ) ^ lfsr_storage_1[12] ) ^ lfsr_storage_1[11] );
            lfsr_storage_2[0] = ( ( ( lfsr_storage_2[15] ^ lfsr_storage_2[13] ) ^ lfsr_storage_2[12] ) ^ lfsr_storage_2[11] );
            lfsr_storage_3[0] = ( ( ( lfsr_storage_3[15] ^ lfsr_storage_3[13] ) ^ lfsr_storage_3[12] ) ^ lfsr_storage_3[11] );
            lfsr_storage_4[0] = ( ( ( lfsr_storage_4[15] ^ lfsr_storage_4[13] ) ^ lfsr_storage_4[12] ) ^ lfsr_storage_4[11] );
            lfsr_storage_5[0] = ( ( ( lfsr_storage_5[15] ^ lfsr_storage_5[13] ) ^ lfsr_storage_5[12] ) ^ lfsr_storage_5[11] );
            lfsr_storage_6[0] = ( ( ( lfsr_storage_6[15] ^ lfsr_storage_6[13] ) ^ lfsr_storage_6[12] ) ^ lfsr_storage_6[11] );
            lfsr_storage_7[0] = ( ( ( lfsr_storage_7[15] ^ lfsr_storage_7[13] ) ^ lfsr_storage_7[12] ) ^ lfsr_storage_7[11] );
            
            // now set the output
            keyout = {  lfsr_storage_0[0] ,
                        lfsr_storage_1[0] ,
                        lfsr_storage_2[0] ,
                        lfsr_storage_3[0] ,
                        lfsr_storage_4[0] ,
                        lfsr_storage_5[0] ,
                        lfsr_storage_6[0] ,
                        lfsr_storage_7[0] };
                        
        end


    end



    
endmodule



























































