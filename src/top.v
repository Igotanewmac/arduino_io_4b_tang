




module top (
    
    // sysclk
    input wire sysclk,
    
    // arduino
    input wire [7:0] arduino_dataout,
    output reg [7:0] arduino_datain,
    input wire arduino_shiftin,
    input wire arduino_readwrite,
    input wire arduino_commit,
    input wire arduino_reset,
    input wire arduino_execute,
    output reg arduino_isfinished
);
    

    wire [7:0] wire_arduino_datain;
    always @(wire_arduino_datain) begin
        arduino_datain <= wire_arduino_datain;
    end

    wire wire_arduino_isfinished;
    always @(wire_arduino_isfinished) begin
        arduino_isfinished <= wire_arduino_isfinished;
    end

    
    wire [7:0] wire_mem_src_douta;
    wire wire_mem_src_clka;
    wire wire_mem_src_ocea;
    wire wire_mem_src_cea;
    wire wire_mem_src_wrea;
    wire [13:0] wire_mem_src_ada;
    wire [7:0] wire_mem_src_dina;
    wire [7:0] wire_mem_src_doutb;
    wire wire_mem_src_clkb;
    wire wire_mem_src_oceb;
    wire wire_mem_src_ceb;
    wire wire_mem_src_wreb;
    wire [13:0] wire_mem_src_adb;
    wire [7:0] wire_mem_src_dinb;
    Gowin_DPB_16k blockmem_src(
        .douta(wire_mem_src_douta), //output [7:0] douta
        .doutb(wire_mem_src_doutb), //output [7:0] doutb
        .clka(wire_mem_src_clka), //input clka
        .ocea(wire_mem_src_ocea), //input ocea
        .cea(wire_mem_src_cea), //input cea
        .reseta(arduino_reset), //input reseta
        .wrea(wire_mem_src_wrea), //input wrea
        .clkb(wire_mem_src_clkb), //input clkb
        .oceb(wire_mem_src_oceb), //input oceb
        .ceb(wire_mem_src_ceb), //input ceb
        .resetb(arduino_reset), //input resetb
        .wreb(wire_mem_src_wreb), //input wreb
        .ada(wire_mem_src_ada), //input [13:0] ada
        .dina(wire_mem_src_dina), //input [7:0] dina
        .adb(wire_mem_src_adb), //input [13:0] adb
        .dinb(wire_mem_src_dinb) //input [7:0] dinb
    );

    wire [7:0] wire_mem_key_douta;
    wire wire_mem_key_clka;
    wire wire_mem_key_ocea;
    wire wire_mem_key_cea;
    wire wire_mem_key_wrea;
    wire [13:0] wire_mem_key_ada;
    wire [7:0] wire_mem_key_dina;
    wire [7:0] wire_mem_key_doutb;
    wire wire_mem_key_clkb;
    wire wire_mem_key_oceb;
    wire wire_mem_key_ceb;
    wire wire_mem_key_wreb;
    wire [13:0] wire_mem_key_adb;
    wire [7:0] wire_mem_key_dinb;
    Gowin_DPB_16k blockmem_key(
        .douta(wire_mem_key_douta), //output [7:0] douta
        .doutb(wire_mem_key_doutb), //output [7:0] doutb
        .clka(wire_mem_key_clka), //input clka
        .ocea(wire_mem_key_ocea), //input ocea
        .cea(wire_mem_key_cea), //input cea
        .reseta(arduino_reset), //input reseta
        .wrea(wire_mem_key_wrea), //input wrea
        .clkb(wire_mem_key_clkb), //input clkb
        .oceb(wire_mem_key_oceb), //input oceb
        .ceb(wire_mem_key_ceb), //input ceb
        .resetb(arduino_reset), //input resetb
        .wreb(wire_mem_key_wreb), //input wreb
        .ada(wire_mem_key_ada), //input [13:0] ada
        .dina(wire_mem_key_dina), //input [7:0] dina
        .adb(wire_mem_key_adb), //input [13:0] adb
        .dinb(wire_mem_key_dinb) //input [7:0] dinb
    );


    

    wire [7:0] wire_mem_cmd_douta;
    wire wire_mem_cmd_clka;
    wire wire_mem_cmd_ocea;
    wire wire_mem_cmd_cea;
    wire wire_mem_cmd_wrea;
    wire [13:0] wire_mem_cmd_ada;
    wire [7:0] wire_mem_cmd_dina;
    wire [7:0] wire_mem_cmd_doutb;
    wire wire_mem_cmd_clkb;
    wire wire_mem_cmd_oceb;
    wire wire_mem_cmd_ceb;
    wire wire_mem_cmd_wreb;
    wire [13:0] wire_mem_cmd_adb;
    wire [7:0] wire_mem_cmd_dinb;
    Gowin_DPB_16k blockmem_cmd(
        .douta(wire_mem_cmd_douta), //output [7:0] douta
        .doutb(wire_mem_cmd_doutb), //output [7:0] doutb
        .clka(wire_mem_cmd_clka), //input clka
        .ocea(wire_mem_cmd_ocea), //input ocea
        .cea(wire_mem_cmd_cea), //input cea
        .reseta(arduino_reset), //input reseta
        .wrea(wire_mem_cmd_wrea), //input wrea
        .clkb(wire_mem_cmd_clkb), //input clkb
        .oceb(wire_mem_cmd_oceb), //input oceb
        .ceb(wire_mem_cmd_ceb), //input ceb
        .resetb(arduino_reset), //input resetb
        .wreb(wire_mem_cmd_wreb), //input wreb
        .ada(wire_mem_cmd_ada), //input [13:0] ada
        .dina(wire_mem_cmd_dina), //input [7:0] dina
        .adb(wire_mem_cmd_adb), //input [13:0] adb
        .dinb(wire_mem_cmd_dinb) //input [7:0] dinb
    );

    wire [7:0] wire_mem_dst_douta;
    wire wire_mem_dst_clka;
    wire wire_mem_dst_ocea;
    wire wire_mem_dst_cea;
    wire wire_mem_dst_wrea;
    wire [13:0] wire_mem_dst_ada;
    wire [7:0] wire_mem_dst_dina;
    wire [7:0] wire_mem_dst_doutb;
    wire wire_mem_dst_clkb;
    wire wire_mem_dst_oceb;
    wire wire_mem_dst_ceb;
    wire wire_mem_dst_wreb;
    wire [13:0] wire_mem_dst_adb;
    wire [7:0] wire_mem_dst_dinb;
    Gowin_DPB_16k blockmem_dst(
        .douta(wire_mem_dst_douta), //output [7:0] douta
        .doutb(wire_mem_dst_doutb), //output [7:0] doutb
        .clka(wire_mem_dst_clka), //input clka
        .ocea(wire_mem_dst_ocea), //input ocea
        .cea(wire_mem_dst_cea), //input cea
        .reseta(arduino_reset), //input reseta
        .wrea(wire_mem_dst_wrea), //input wrea
        .clkb(wire_mem_dst_clkb), //input clkb
        .oceb(wire_mem_dst_oceb), //input oceb
        .ceb(wire_mem_dst_ceb), //input ceb
        .resetb(arduino_reset), //input resetb
        .wreb(wire_mem_dst_wreb), //input wreb
        .ada(wire_mem_dst_ada), //input [13:0] ada
        .dina(wire_mem_dst_dina), //input [7:0] dina
        .adb(wire_mem_dst_adb), //input [13:0] adb
        .dinb(wire_mem_dst_dinb) //input [7:0] dinb
    );

    

    arduino_io myarduino_io(

        // sysclk
        .sysclk(sysclk),
        
        // arduino
        .arduino_dataout(arduino_dataout),
        .arduino_datain(wire_arduino_datain),
        .arduino_shiftin(arduino_shiftin),
        .arduino_readwrite(arduino_readwrite),
        .arduino_commit(arduino_commit),
        .arduino_reset(arduino_reset),

        // mem src
        .mem_src_dout(wire_mem_src_douta),
        .mem_src_din(wire_mem_src_dina),
        .mem_src_ad(wire_mem_src_ada),
        .mem_src_ce(wire_mem_src_cea),
        .mem_src_wre(wire_mem_src_wrea),
        .mem_src_oce(wire_mem_src_ocea),
        .mem_src_clk(wire_mem_src_clka),

        // mem key
        .mem_key_dout(wire_mem_key_douta),
        .mem_key_din(wire_mem_key_dina),
        .mem_key_ad(wire_mem_key_ada),
        .mem_key_ce(wire_mem_key_cea),
        .mem_key_wre(wire_mem_key_wrea),
        .mem_key_oce(wire_mem_key_ocea),
        .mem_key_clk(wire_mem_key_clka),

        // mem cmd
        .mem_cmd_dout(wire_mem_cmd_douta),
        .mem_cmd_din(wire_mem_cmd_dina),
        .mem_cmd_ad(wire_mem_cmd_ada),
        .mem_cmd_ce(wire_mem_cmd_cea),
        .mem_cmd_wre(wire_mem_cmd_wrea),
        .mem_cmd_oce(wire_mem_cmd_ocea),
        .mem_cmd_clk(wire_mem_cmd_clka),

        // mem dst
        .mem_dst_dout(wire_mem_dst_douta),
        .mem_dst_din(wire_mem_dst_dina),
        .mem_dst_ad(wire_mem_dst_ada),
        .mem_dst_ce(wire_mem_dst_cea),
        .mem_dst_wre(wire_mem_dst_wrea),
        .mem_dst_oce(wire_mem_dst_ocea),
        .mem_dst_clk(wire_mem_dst_clka)
        
    );


    processor_core myprocessorcore(
        // sysclk
        .sysclk(sysclk),
        // arduino
        .arduino_execute(arduino_execute),
        .arduino_isfinished(wire_arduino_isfinished),
        .arduino_reset(arduino_reset),
        // mem src
        .mem_src_dout(wire_mem_src_doutb),
        .mem_src_din(wire_mem_src_dinb),
        .mem_src_ad(wire_mem_src_adb),
        .mem_src_ce(wire_mem_src_ceb),
        .mem_src_wre(wire_mem_src_wreb),
        .mem_src_oce(wire_mem_src_oceb),
        .mem_src_clk(wire_mem_src_clkb),
        // mem key
        .mem_key_dout(wire_mem_key_doutb),
        .mem_key_din(wire_mem_key_dinb),
        .mem_key_ad(wire_mem_key_adb),
        .mem_key_ce(wire_mem_key_ceb),
        .mem_key_wre(wire_mem_key_wreb),
        .mem_key_oce(wire_mem_key_oceb),
        .mem_key_clk(wire_mem_key_clkb),
        // mem cmd
        .mem_cmd_dout(wire_mem_cmd_doutb),
        .mem_cmd_din(wire_mem_cmd_dinb),
        .mem_cmd_ad(wire_mem_cmd_adb),
        .mem_cmd_ce(wire_mem_cmd_ceb),
        .mem_cmd_wre(wire_mem_cmd_wreb),
        .mem_cmd_oce(wire_mem_cmd_oceb),
        .mem_cmd_clk(wire_mem_cmd_clkb),
        // mem dst
        .mem_dst_dout(wire_mem_dst_doutb),
        .mem_dst_din(wire_mem_dst_dinb),
        .mem_dst_ad(wire_mem_dst_adb),
        .mem_dst_ce(wire_mem_dst_ceb),
        .mem_dst_wre(wire_mem_dst_wreb),
        .mem_dst_oce(wire_mem_dst_oceb),
        .mem_dst_clk(wire_mem_dst_clkb)
        
    );








endmodule










































