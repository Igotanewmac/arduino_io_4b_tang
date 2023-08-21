




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

    
    wire [7:0] wire_mem_src_dout;
    wire wire_mem_src_clk;
    wire wire_mem_src_oce;
    wire wire_mem_src_ce;
    wire wire_mem_src_wre;
    wire [13:0] wire_mem_src_ad;
    wire [7:0] wire_mem_src_din;
    Gowin_SP_16k blockmem_src(
        .dout(wire_mem_src_dout), //output [7:0] dout
        .clk(wire_mem_src_clk), //input clk
        .oce(wire_mem_src_oce), //input oce
        .ce(wire_mem_src_ce), //input ce
        .reset(arduino_reset), //input reset
        .wre(wire_mem_src_wre), //input wre
        .ad(wire_mem_src_ad), //input [13:0] ad
        .din(wire_mem_src_din) //input [7:0] din
    );


    wire [7:0] wire_mem_key_dout;
    wire wire_mem_key_clk;
    wire wire_mem_key_oce;
    wire wire_mem_skey_ce;
    wire wire_mem_key_wre;
    wire [13:0] wire_mem_key_ad;
    wire [7:0] wire_mem_key_din;
    Gowin_SP_16k blockmem_key(
        .dout(wire_mem_key_dout), //output [7:0] dout
        .clk(wire_mem_key_clk), //input clk
        .oce(wire_mem_key_oce), //input oce
        .ce(wire_mem_key_ce), //input ce
        .reset(arduino_reset), //input reset
        .wre(wire_mem_key_wre), //input wre
        .ad(wire_mem_key_ad), //input [13:0] ad
        .din(wire_mem_key_din) //input [7:0] din
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


    wire [7:0] wire_mem_dst_dout;
    wire wire_mem_dst_clk;
    wire wire_mem_dst_oce;
    wire wire_mem_dst_ce;
    wire wire_mem_dst_wre;
    wire [13:0] wire_mem_dst_ad;
    wire [7:0] wire_mem_dst_din;
    Gowin_SP_16k blockmem_dst(
        .dout(wire_mem_dst_dout), //output [7:0] dout
        .clk(wire_mem_dst_clk), //input clk
        .oce(wire_mem_dst_oce), //input oce
        .ce(wire_mem_dst_ce), //input ce
        .reset(arduino_reset), //input reset
        .wre(wire_mem_dst_wre), //input wre
        .ad(wire_mem_dst_ad), //input [13:0] ad
        .din(wire_mem_dst_din) //input [7:0] din
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
        .mem_src_dout(wire_mem_src_dout),
        .mem_src_din(wire_mem_src_din),
        .mem_src_ad(wire_mem_src_ad),
        .mem_src_ce(wire_mem_src_ce),
        .mem_src_wre(wire_mem_src_wre),
        .mem_src_oce(wire_mem_src_oce),
        .mem_src_clk(wire_mem_src_clk),

        // mem key
        .mem_key_dout(wire_mem_key_dout),
        .mem_key_din(wire_mem_key_din),
        .mem_key_ad(wire_mem_key_ad),
        .mem_key_ce(wire_mem_key_ce),
        .mem_key_wre(wire_mem_key_wre),
        .mem_key_oce(wire_mem_key_oce),
        .mem_key_clk(wire_mem_key_clk),

        // mem cmd
        .mem_cmd_dout(wire_mem_cmd_douta),
        .mem_cmd_din(wire_mem_cmd_dina),
        .mem_cmd_ad(wire_mem_cmd_ada),
        .mem_cmd_ce(wire_mem_cmd_cea),
        .mem_cmd_wre(wire_mem_cmd_wrea),
        .mem_cmd_oce(wire_mem_cmd_ocea),
        .mem_cmd_clk(wire_mem_cmd_clka),

        // mem dst
        .mem_dst_dout(wire_mem_dst_dout),
        .mem_dst_din(wire_mem_dst_din),
        .mem_dst_ad(wire_mem_dst_ad),
        .mem_dst_ce(wire_mem_dst_ce),
        .mem_dst_wre(wire_mem_dst_wre),
        .mem_dst_oce(wire_mem_dst_oce),
        .mem_dst_clk(wire_mem_dst_clk)
        
    );


    processor_core myprocessorcore(
        // sysclk
        .sysclk(sysclk),
        // arduino
        .arduino_execute(arduino_execute),
        .arduino_isfinished(wire_arduino_isfinished),
        .arduino_reset(arduino_reset),
        // mem cmd
        .mem_cmd_dout(wire_mem_cmd_doutb),
        .mem_cmd_din(wire_mem_cmd_dinb),
        .mem_cmd_ad(wire_mem_cmd_adb),
        .mem_cmd_ce(wire_mem_cmd_ceb),
        .mem_cmd_wre(wire_mem_cmd_wreb),
        .mem_cmd_oce(wire_mem_cmd_oceb),
        .mem_cmd_clk(wire_mem_cmd_clkb)
    );








endmodule










































