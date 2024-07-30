// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : tt_um_monotone_player
// Git hash  : cf01085adad830c6c574592ad70e74e8243b592d

`timescale 1ns/1ps

module tt_um_monotone_player (
  input  wire [7:0]    ui_in,
  output reg  [7:0]    uo_out,
  input  wire [7:0]    uio_in,
  output reg  [7:0]    uio_out,
  output reg  [7:0]    uio_oe,
  input  wire          ena,
  input  wire          clk,
  input  wire          rst_n
);

  wire                top_1_spi_miso;
  wire                top_1_spi_sclk;
  wire                top_1_spi_mosi;
  wire       [0:0]    top_1_spi_ss;
  wire                top_1_vga_hsync;
  wire                top_1_vga_vsync;
  wire       [1:0]    top_1_vga_r;
  wire       [1:0]    top_1_vga_g;
  wire       [1:0]    top_1_vga_b;
  wire                top_1_osc;
  function [7:0] zz_uio_oe(input dummy);
    begin
      zz_uio_oe = 8'h0;
      zz_uio_oe[0] = 1'b1;
      zz_uio_oe[1] = 1'b1;
      zz_uio_oe[3] = 1'b1;
      zz_uio_oe[7] = 1'b1;
    end
  endfunction
  wire [7:0] _zz_1;

  Top top_1 (
    .spi_ss    (top_1_spi_ss    ), //o
    .spi_sclk  (top_1_spi_sclk  ), //o
    .spi_mosi  (top_1_spi_mosi  ), //o
    .spi_miso  (top_1_spi_miso  ), //i
    .vga_hsync (top_1_vga_hsync ), //o
    .vga_vsync (top_1_vga_vsync ), //o
    .vga_r     (top_1_vga_r[1:0]), //o
    .vga_g     (top_1_vga_g[1:0]), //o
    .vga_b     (top_1_vga_b[1:0]), //o
    .osc       (top_1_osc       ), //o
    .clk       (clk             ), //i
    .rst_n     (rst_n           )  //i
  );
  assign _zz_1 = zz_uio_oe(1'b0);
  always @(*) uio_oe = _zz_1;
  always @(*) begin
    uio_out = 8'h0;
    uio_out[0] = top_1_spi_ss[0];
    uio_out[1] = top_1_spi_sclk;
    uio_out[3] = top_1_spi_mosi;
    uio_out[7] = top_1_osc;
  end

  always @(*) begin
    uo_out = 8'h0;
    uo_out[0] = top_1_vga_r[1];
    uo_out[1] = top_1_vga_g[1];
    uo_out[2] = top_1_vga_b[1];
    uo_out[3] = top_1_vga_vsync;
    uo_out[4] = top_1_vga_r[0];
    uo_out[5] = top_1_vga_g[0];
    uo_out[6] = top_1_vga_b[0];
    uo_out[7] = top_1_vga_hsync;
  end

  assign top_1_spi_miso = uio_in[2];

endmodule

module Top (
  output wire [0:0]    spi_ss,
  output wire          spi_sclk,
  output wire          spi_mosi,
  input  wire          spi_miso,
  output wire          vga_hsync,
  output wire          vga_vsync,
  output wire [1:0]    vga_r,
  output wire [1:0]    vga_g,
  output wire [1:0]    vga_b,
  output wire          osc,
  input  wire          clk,
  input  wire          rst_n
);

  wire                oscillatorControl_1_io_readReq_valid;
  wire       [15:0]   oscillatorControl_1_io_readReq_payload;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_0;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_1;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_2;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_3;
  wire                oscillatorControl_1_io_noise_enable;
  wire                oscillatorControl_1_io_noise_clocken;
  wire                oscillatorControl_1_io_oscillator_en;
  wire       [3:0]    enableArea_oscillatorGroup_io_oscillator_outputs;
  wire                enableArea_oscillatorGroup_io_oscillator;
  wire                spiRom_1_io_spi_sclk;
  wire                spiRom_1_io_spi_mosi;
  wire       [0:0]    spiRom_1_io_spi_ss;
  wire                spiRom_1_io_readReq_ready;
  wire                spiRom_1_io_readResp_valid;
  wire       [7:0]    spiRom_1_io_readResp_payload;
  wire                vgaVideoGenerator_1_io_vga_hsync;
  wire                vgaVideoGenerator_1_io_vga_vsync;
  wire       [1:0]    vgaVideoGenerator_1_io_vga_r;
  wire       [1:0]    vgaVideoGenerator_1_io_vga_g;
  wire       [1:0]    vgaVideoGenerator_1_io_vga_b;
  wire                enableArea_newClockEnable;

  OscillatorControl oscillatorControl_1 (
    .io_readReq_valid          (oscillatorControl_1_io_readReq_valid               ), //o
    .io_readReq_ready          (spiRom_1_io_readReq_ready                          ), //i
    .io_readReq_payload        (oscillatorControl_1_io_readReq_payload[15:0]       ), //o
    .io_readResp_valid         (spiRom_1_io_readResp_valid                         ), //i
    .io_readResp_payload       (spiRom_1_io_readResp_payload[7:0]                  ), //i
    .io_oscillatorIncrements_0 (oscillatorControl_1_io_oscillatorIncrements_0[11:0]), //o
    .io_oscillatorIncrements_1 (oscillatorControl_1_io_oscillatorIncrements_1[11:0]), //o
    .io_oscillatorIncrements_2 (oscillatorControl_1_io_oscillatorIncrements_2[11:0]), //o
    .io_oscillatorIncrements_3 (oscillatorControl_1_io_oscillatorIncrements_3[11:0]), //o
    .io_noise_enable           (oscillatorControl_1_io_noise_enable                ), //o
    .io_noise_clocken          (oscillatorControl_1_io_noise_clocken               ), //o
    .io_oscillator_en          (oscillatorControl_1_io_oscillator_en               ), //o
    .clk                       (clk                                                ), //i
    .rst_n                     (rst_n                                              )  //i
  );
  OscillatorGroup enableArea_oscillatorGroup (
    .io_increments_0           (oscillatorControl_1_io_oscillatorIncrements_0[11:0]  ), //i
    .io_increments_1           (oscillatorControl_1_io_oscillatorIncrements_1[11:0]  ), //i
    .io_increments_2           (oscillatorControl_1_io_oscillatorIncrements_2[11:0]  ), //i
    .io_increments_3           (oscillatorControl_1_io_oscillatorIncrements_3[11:0]  ), //i
    .io_noise_enable           (oscillatorControl_1_io_noise_enable                  ), //i
    .io_noise_clocken          (oscillatorControl_1_io_noise_clocken                 ), //i
    .io_oscillator_outputs     (enableArea_oscillatorGroup_io_oscillator_outputs[3:0]), //o
    .io_oscillator             (enableArea_oscillatorGroup_io_oscillator             ), //o
    .enableArea_newClockEnable (enableArea_newClockEnable                            ), //i
    .clk                       (clk                                                  ), //i
    .rst_n                     (rst_n                                                )  //i
  );
  SpiRom spiRom_1 (
    .io_spi_ss           (spiRom_1_io_spi_ss                          ), //o
    .io_spi_sclk         (spiRom_1_io_spi_sclk                        ), //o
    .io_spi_mosi         (spiRom_1_io_spi_mosi                        ), //o
    .io_spi_miso         (spi_miso                                    ), //i
    .io_readReq_valid    (oscillatorControl_1_io_readReq_valid        ), //i
    .io_readReq_ready    (spiRom_1_io_readReq_ready                   ), //o
    .io_readReq_payload  (oscillatorControl_1_io_readReq_payload[15:0]), //i
    .io_readResp_valid   (spiRom_1_io_readResp_valid                  ), //o
    .io_readResp_payload (spiRom_1_io_readResp_payload[7:0]           ), //o
    .clk                 (clk                                         ), //i
    .rst_n               (rst_n                                       )  //i
  );
  VGAVideoGenerator vgaVideoGenerator_1 (
    .io_vga_hsync                   (vgaVideoGenerator_1_io_vga_hsync                     ), //o
    .io_vga_vsync                   (vgaVideoGenerator_1_io_vga_vsync                     ), //o
    .io_vga_r                       (vgaVideoGenerator_1_io_vga_r[1:0]                    ), //o
    .io_vga_g                       (vgaVideoGenerator_1_io_vga_g[1:0]                    ), //o
    .io_vga_b                       (vgaVideoGenerator_1_io_vga_b[1:0]                    ), //o
    .io_oscillatorData_increments_0 (oscillatorControl_1_io_oscillatorIncrements_0[11:0]  ), //i
    .io_oscillatorData_increments_1 (oscillatorControl_1_io_oscillatorIncrements_1[11:0]  ), //i
    .io_oscillatorData_increments_2 (oscillatorControl_1_io_oscillatorIncrements_2[11:0]  ), //i
    .io_oscillatorData_increments_3 (oscillatorControl_1_io_oscillatorIncrements_3[11:0]  ), //i
    .io_oscillatorData_combined     (enableArea_oscillatorGroup_io_oscillator             ), //i
    .io_oscillatorData_outputs      (enableArea_oscillatorGroup_io_oscillator_outputs[3:0]), //i
    .io_oscillatorData_enable       (oscillatorControl_1_io_oscillator_en                 ), //i
    .clk                            (clk                                                  ), //i
    .rst_n                          (rst_n                                                )  //i
  );
  assign enableArea_newClockEnable = (1'b1 && oscillatorControl_1_io_oscillator_en);
  assign spi_ss = spiRom_1_io_spi_ss;
  assign spi_sclk = spiRom_1_io_spi_sclk;
  assign spi_mosi = spiRom_1_io_spi_mosi;
  assign osc = enableArea_oscillatorGroup_io_oscillator;
  assign vga_hsync = vgaVideoGenerator_1_io_vga_hsync;
  assign vga_vsync = vgaVideoGenerator_1_io_vga_vsync;
  assign vga_r = vgaVideoGenerator_1_io_vga_r;
  assign vga_g = vgaVideoGenerator_1_io_vga_g;
  assign vga_b = vgaVideoGenerator_1_io_vga_b;

endmodule

module VGAVideoGenerator (
  output wire          io_vga_hsync,
  output wire          io_vga_vsync,
  output reg  [1:0]    io_vga_r,
  output reg  [1:0]    io_vga_g,
  output reg  [1:0]    io_vga_b,
  input  wire [11:0]   io_oscillatorData_increments_0,
  input  wire [11:0]   io_oscillatorData_increments_1,
  input  wire [11:0]   io_oscillatorData_increments_2,
  input  wire [11:0]   io_oscillatorData_increments_3,
  input  wire          io_oscillatorData_combined,
  input  wire [3:0]    io_oscillatorData_outputs,
  input  wire          io_oscillatorData_enable,
  input  wire          clk,
  input  wire          rst_n
);

  wire                timing_generator_io_hsync;
  wire                timing_generator_io_vsync;
  wire                timing_generator_io_video_active;
  wire                timing_generator_io_frame_start;
  wire                timing_generator_io_line_start;
  wire       [9:0]    timing_generator_io_x_coord;
  wire       [8:0]    timing_generator_io_y_coord;
  wire       [9:0]    _zz_when_VGAVideoGenerator_l55;
  wire       [9:0]    _zz_when_VGAVideoGenerator_l55_1;
  wire       [9:0]    _zz_when_VGAVideoGenerator_l58;
  wire       [9:0]    _zz_when_VGAVideoGenerator_l58_1;
  wire       [9:0]    _zz_when_VGAVideoGenerator_l61;
  wire       [9:0]    _zz_when_VGAVideoGenerator_l61_1;
  wire       [9:0]    _zz_when_VGAVideoGenerator_l64;
  reg        [7:0]    frame_count;
  wire                _zz_when_VGAVideoGenerator_l36;
  reg        [4:0]    channelCounts_0;
  reg                 _zz_when_VGAVideoGenerator_l36_1;
  wire                when_VGAVideoGenerator_l36;
  wire                _zz_when_VGAVideoGenerator_l36_2;
  reg        [4:0]    channelCounts_1;
  reg                 _zz_when_VGAVideoGenerator_l36_3;
  wire                when_VGAVideoGenerator_l36_1;
  wire                _zz_when_VGAVideoGenerator_l36_4;
  reg        [4:0]    channelCounts_2;
  reg                 _zz_when_VGAVideoGenerator_l36_5;
  wire                when_VGAVideoGenerator_l36_2;
  wire                _zz_when_VGAVideoGenerator_l36_6;
  reg        [4:0]    channelCounts_3;
  reg                 _zz_when_VGAVideoGenerator_l36_7;
  wire                when_VGAVideoGenerator_l36_3;
  reg        [8:0]    chAllCount;
  reg                 io_oscillatorData_combined_regNext;
  wire                when_VGAVideoGenerator_l46;
  wire                when_VGAVideoGenerator_l55;
  wire                when_VGAVideoGenerator_l58;
  wire                when_VGAVideoGenerator_l61;
  wire                when_VGAVideoGenerator_l64;

  assign _zz_when_VGAVideoGenerator_l55 = (timing_generator_io_x_coord / 6'h20);
  assign _zz_when_VGAVideoGenerator_l55_1 = {5'd0, channelCounts_1};
  assign _zz_when_VGAVideoGenerator_l58 = (timing_generator_io_x_coord / 6'h20);
  assign _zz_when_VGAVideoGenerator_l58_1 = {5'd0, channelCounts_2};
  assign _zz_when_VGAVideoGenerator_l61 = (timing_generator_io_x_coord / 6'h20);
  assign _zz_when_VGAVideoGenerator_l61_1 = {5'd0, channelCounts_3};
  assign _zz_when_VGAVideoGenerator_l64 = {1'd0, chAllCount};
  VGATimingGenerator timing_generator (
    .io_hsync        (timing_generator_io_hsync       ), //o
    .io_vsync        (timing_generator_io_vsync       ), //o
    .io_video_active (timing_generator_io_video_active), //o
    .io_frame_start  (timing_generator_io_frame_start ), //o
    .io_line_start   (timing_generator_io_line_start  ), //o
    .io_x_coord      (timing_generator_io_x_coord[9:0]), //o
    .io_y_coord      (timing_generator_io_y_coord[8:0]), //o
    .clk             (clk                             ), //i
    .rst_n           (rst_n                           )  //i
  );
  assign io_vga_hsync = timing_generator_io_hsync;
  assign io_vga_vsync = timing_generator_io_vsync;
  always @(*) begin
    io_vga_r = 2'b00;
    if(timing_generator_io_video_active) begin
      if(when_VGAVideoGenerator_l55) begin
        io_vga_r = 2'b11;
      end
      if(when_VGAVideoGenerator_l64) begin
        io_vga_r = 2'b11;
      end
    end
  end

  always @(*) begin
    io_vga_g = 2'b00;
    if(timing_generator_io_video_active) begin
      if(when_VGAVideoGenerator_l58) begin
        io_vga_g = 2'b11;
      end
      if(when_VGAVideoGenerator_l64) begin
        io_vga_g = 2'b11;
      end
    end
  end

  always @(*) begin
    io_vga_b = 2'b00;
    if(timing_generator_io_video_active) begin
      if(when_VGAVideoGenerator_l61) begin
        io_vga_b = 2'b11;
      end
      if(when_VGAVideoGenerator_l64) begin
        io_vga_b = 2'b11;
      end
    end
  end

  assign _zz_when_VGAVideoGenerator_l36 = io_oscillatorData_outputs[0];
  assign when_VGAVideoGenerator_l36 = (_zz_when_VGAVideoGenerator_l36 != _zz_when_VGAVideoGenerator_l36_1);
  assign _zz_when_VGAVideoGenerator_l36_2 = io_oscillatorData_outputs[1];
  assign when_VGAVideoGenerator_l36_1 = (_zz_when_VGAVideoGenerator_l36_2 != _zz_when_VGAVideoGenerator_l36_3);
  assign _zz_when_VGAVideoGenerator_l36_4 = io_oscillatorData_outputs[2];
  assign when_VGAVideoGenerator_l36_2 = (_zz_when_VGAVideoGenerator_l36_4 != _zz_when_VGAVideoGenerator_l36_5);
  assign _zz_when_VGAVideoGenerator_l36_6 = io_oscillatorData_outputs[3];
  assign when_VGAVideoGenerator_l36_3 = (_zz_when_VGAVideoGenerator_l36_6 != _zz_when_VGAVideoGenerator_l36_7);
  assign when_VGAVideoGenerator_l46 = (io_oscillatorData_combined != io_oscillatorData_combined_regNext);
  assign when_VGAVideoGenerator_l55 = (_zz_when_VGAVideoGenerator_l55 < _zz_when_VGAVideoGenerator_l55_1);
  assign when_VGAVideoGenerator_l58 = (_zz_when_VGAVideoGenerator_l58 < _zz_when_VGAVideoGenerator_l58_1);
  assign when_VGAVideoGenerator_l61 = (_zz_when_VGAVideoGenerator_l61 < _zz_when_VGAVideoGenerator_l61_1);
  assign when_VGAVideoGenerator_l64 = (timing_generator_io_x_coord < _zz_when_VGAVideoGenerator_l64);
  always @(posedge clk) begin
    if(timing_generator_io_frame_start) begin
      frame_count <= (frame_count + 8'h01);
    end
    _zz_when_VGAVideoGenerator_l36_1 <= _zz_when_VGAVideoGenerator_l36;
    if(when_VGAVideoGenerator_l36) begin
      channelCounts_0 <= (channelCounts_0 + 5'h01);
    end
    if(timing_generator_io_frame_start) begin
      channelCounts_0 <= 5'h0;
    end
    _zz_when_VGAVideoGenerator_l36_3 <= _zz_when_VGAVideoGenerator_l36_2;
    if(when_VGAVideoGenerator_l36_1) begin
      channelCounts_1 <= (channelCounts_1 + 5'h01);
    end
    if(timing_generator_io_frame_start) begin
      channelCounts_1 <= 5'h0;
    end
    _zz_when_VGAVideoGenerator_l36_5 <= _zz_when_VGAVideoGenerator_l36_4;
    if(when_VGAVideoGenerator_l36_2) begin
      channelCounts_2 <= (channelCounts_2 + 5'h01);
    end
    if(timing_generator_io_frame_start) begin
      channelCounts_2 <= 5'h0;
    end
    _zz_when_VGAVideoGenerator_l36_7 <= _zz_when_VGAVideoGenerator_l36_6;
    if(when_VGAVideoGenerator_l36_3) begin
      channelCounts_3 <= (channelCounts_3 + 5'h01);
    end
    if(timing_generator_io_frame_start) begin
      channelCounts_3 <= 5'h0;
    end
    io_oscillatorData_combined_regNext <= io_oscillatorData_combined;
    if(when_VGAVideoGenerator_l46) begin
      chAllCount <= (chAllCount + 9'h001);
    end
    if(timing_generator_io_frame_start) begin
      chAllCount <= 9'h0;
    end
  end


endmodule

module SpiRom (
  output wire [0:0]    io_spi_ss,
  output wire          io_spi_sclk,
  output wire          io_spi_mosi,
  input  wire          io_spi_miso,
  input  wire          io_readReq_valid,
  output reg           io_readReq_ready,
  input  wire [15:0]   io_readReq_payload,
  output reg           io_readResp_valid,
  output reg  [7:0]    io_readResp_payload,
  input  wire          clk,
  input  wire          rst_n
);
  localparam fsm_enumDef_BOOT = 3'd0;
  localparam fsm_enumDef_idle = 3'd1;
  localparam fsm_enumDef_readCmd = 3'd2;
  localparam fsm_enumDef_readAddr1 = 3'd3;
  localparam fsm_enumDef_readAddr2 = 3'd4;
  localparam fsm_enumDef_readData = 3'd5;
  localparam fsm_enumDef_readDataWait = 3'd6;
  localparam fsm_enumDef_waitSS = 3'd7;

  reg                 spiMaster_1_io_cmd_valid;
  reg        [7:0]    spiMaster_1_io_cmd_payload;
  wire                spiMaster_1_io_spi_sclk;
  wire                spiMaster_1_io_spi_mosi;
  wire       [0:0]    spiMaster_1_io_spi_ss;
  wire                spiMaster_1_io_cmd_ready;
  wire                spiMaster_1_io_resp_valid;
  wire       [7:0]    spiMaster_1_io_resp_payload;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  `ifndef SYNTHESIS
  reg [95:0] fsm_stateReg_string;
  reg [95:0] fsm_stateNext_string;
  `endif


  SpiMaster spiMaster_1 (
    .io_spi_ss       (spiMaster_1_io_spi_ss           ), //o
    .io_spi_sclk     (spiMaster_1_io_spi_sclk         ), //o
    .io_spi_mosi     (spiMaster_1_io_spi_mosi         ), //o
    .io_spi_miso     (io_spi_miso                     ), //i
    .io_cmd_valid    (spiMaster_1_io_cmd_valid        ), //i
    .io_cmd_ready    (spiMaster_1_io_cmd_ready        ), //o
    .io_cmd_payload  (spiMaster_1_io_cmd_payload[7:0] ), //i
    .io_resp_valid   (spiMaster_1_io_resp_valid       ), //o
    .io_resp_payload (spiMaster_1_io_resp_payload[7:0]), //o
    .clk             (clk                             ), //i
    .rst_n           (rst_n                           )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_BOOT : fsm_stateReg_string = "BOOT        ";
      fsm_enumDef_idle : fsm_stateReg_string = "idle        ";
      fsm_enumDef_readCmd : fsm_stateReg_string = "readCmd     ";
      fsm_enumDef_readAddr1 : fsm_stateReg_string = "readAddr1   ";
      fsm_enumDef_readAddr2 : fsm_stateReg_string = "readAddr2   ";
      fsm_enumDef_readData : fsm_stateReg_string = "readData    ";
      fsm_enumDef_readDataWait : fsm_stateReg_string = "readDataWait";
      fsm_enumDef_waitSS : fsm_stateReg_string = "waitSS      ";
      default : fsm_stateReg_string = "????????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_BOOT : fsm_stateNext_string = "BOOT        ";
      fsm_enumDef_idle : fsm_stateNext_string = "idle        ";
      fsm_enumDef_readCmd : fsm_stateNext_string = "readCmd     ";
      fsm_enumDef_readAddr1 : fsm_stateNext_string = "readAddr1   ";
      fsm_enumDef_readAddr2 : fsm_stateNext_string = "readAddr2   ";
      fsm_enumDef_readData : fsm_stateNext_string = "readData    ";
      fsm_enumDef_readDataWait : fsm_stateNext_string = "readDataWait";
      fsm_enumDef_waitSS : fsm_stateNext_string = "waitSS      ";
      default : fsm_stateNext_string = "????????????";
    endcase
  end
  `endif

  always @(*) begin
    io_readReq_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_readCmd : begin
      end
      fsm_enumDef_readAddr1 : begin
      end
      fsm_enumDef_readAddr2 : begin
        if(spiMaster_1_io_cmd_ready) begin
          io_readReq_ready = 1'b1;
        end
      end
      fsm_enumDef_readData : begin
      end
      fsm_enumDef_readDataWait : begin
      end
      fsm_enumDef_waitSS : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_readResp_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_readCmd : begin
      end
      fsm_enumDef_readAddr1 : begin
      end
      fsm_enumDef_readAddr2 : begin
      end
      fsm_enumDef_readData : begin
      end
      fsm_enumDef_readDataWait : begin
        io_readResp_valid = spiMaster_1_io_resp_valid;
      end
      fsm_enumDef_waitSS : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_readResp_payload = 8'h0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_readCmd : begin
      end
      fsm_enumDef_readAddr1 : begin
      end
      fsm_enumDef_readAddr2 : begin
      end
      fsm_enumDef_readData : begin
      end
      fsm_enumDef_readDataWait : begin
        io_readResp_payload = spiMaster_1_io_resp_payload;
      end
      fsm_enumDef_waitSS : begin
      end
      default : begin
      end
    endcase
  end

  assign io_spi_ss = spiMaster_1_io_spi_ss;
  assign io_spi_sclk = spiMaster_1_io_spi_sclk;
  assign io_spi_mosi = spiMaster_1_io_spi_mosi;
  always @(*) begin
    spiMaster_1_io_cmd_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_readCmd : begin
        spiMaster_1_io_cmd_valid = 1'b1;
      end
      fsm_enumDef_readAddr1 : begin
        spiMaster_1_io_cmd_valid = 1'b1;
      end
      fsm_enumDef_readAddr2 : begin
        spiMaster_1_io_cmd_valid = 1'b1;
      end
      fsm_enumDef_readData : begin
        spiMaster_1_io_cmd_valid = 1'b1;
      end
      fsm_enumDef_readDataWait : begin
      end
      fsm_enumDef_waitSS : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    spiMaster_1_io_cmd_payload = 8'h0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_readCmd : begin
        spiMaster_1_io_cmd_payload = 8'h03;
      end
      fsm_enumDef_readAddr1 : begin
        spiMaster_1_io_cmd_payload = io_readReq_payload[15 : 8];
      end
      fsm_enumDef_readAddr2 : begin
        spiMaster_1_io_cmd_payload = io_readReq_payload[7 : 0];
      end
      fsm_enumDef_readData : begin
        spiMaster_1_io_cmd_payload = 8'h0;
      end
      fsm_enumDef_readDataWait : begin
      end
      fsm_enumDef_waitSS : begin
      end
      default : begin
      end
    endcase
  end

  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
      end
      fsm_enumDef_readCmd : begin
      end
      fsm_enumDef_readAddr1 : begin
      end
      fsm_enumDef_readAddr2 : begin
      end
      fsm_enumDef_readData : begin
      end
      fsm_enumDef_readDataWait : begin
      end
      fsm_enumDef_waitSS : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_idle : begin
        if(io_readReq_valid) begin
          fsm_stateNext = fsm_enumDef_readCmd;
        end
      end
      fsm_enumDef_readCmd : begin
        if(spiMaster_1_io_cmd_ready) begin
          fsm_stateNext = fsm_enumDef_readAddr1;
        end
      end
      fsm_enumDef_readAddr1 : begin
        if(spiMaster_1_io_cmd_ready) begin
          fsm_stateNext = fsm_enumDef_readAddr2;
        end
      end
      fsm_enumDef_readAddr2 : begin
        if(spiMaster_1_io_cmd_ready) begin
          fsm_stateNext = fsm_enumDef_readData;
        end
      end
      fsm_enumDef_readData : begin
        if(spiMaster_1_io_cmd_ready) begin
          fsm_stateNext = fsm_enumDef_readDataWait;
        end
      end
      fsm_enumDef_readDataWait : begin
        if(spiMaster_1_io_resp_valid) begin
          fsm_stateNext = fsm_enumDef_waitSS;
        end
      end
      fsm_enumDef_waitSS : begin
        fsm_stateNext = fsm_enumDef_idle;
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_BOOT;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      fsm_stateReg <= fsm_enumDef_BOOT;
    end else begin
      fsm_stateReg <= fsm_stateNext;
    end
  end


endmodule

module OscillatorGroup (
  input  wire [11:0]   io_increments_0,
  input  wire [11:0]   io_increments_1,
  input  wire [11:0]   io_increments_2,
  input  wire [11:0]   io_increments_3,
  input  wire          io_noise_enable,
  input  wire          io_noise_clocken,
  output wire [3:0]    io_oscillator_outputs,
  output wire          io_oscillator,
  input  wire          enableArea_newClockEnable,
  input  wire          clk,
  input  wire          rst_n
);

  wire                oscillator_4_io_oscillator;
  wire                oscillator_5_io_oscillator;
  wire                oscillator_6_io_oscillator;
  wire                oscillator_7_io_oscillator;
  wire                noiseEnableArea_noiseGenerator_io_oscillator;
  wire       [2:0]    _zz_sigmaDelta_increment_8;
  reg        [2:0]    _zz_sigmaDelta_increment_9;
  wire       [2:0]    _zz_sigmaDelta_increment_10;
  reg        [2:0]    _zz_sigmaDelta_increment_11;
  wire       [2:0]    _zz_sigmaDelta_increment_12;
  wire       [1:0]    _zz_sigmaDelta_increment_13;
  wire       [4:0]    oscillatorOutputs;
  wire                noiseEnableArea_newClockEnable;
  wire       [2:0]    _zz_sigmaDelta_increment;
  wire       [2:0]    _zz_sigmaDelta_increment_1;
  wire       [2:0]    _zz_sigmaDelta_increment_2;
  wire       [2:0]    _zz_sigmaDelta_increment_3;
  wire       [2:0]    _zz_sigmaDelta_increment_4;
  wire       [2:0]    _zz_sigmaDelta_increment_5;
  wire       [2:0]    _zz_sigmaDelta_increment_6;
  wire       [2:0]    _zz_sigmaDelta_increment_7;
  wire       [2:0]    sigmaDelta_increment;
  reg        [2:0]    sigmaDelta_counter;
  wire       [3:0]    sigmaDelta_countResult;
  reg                 _zz_io_oscillator;

  assign _zz_sigmaDelta_increment_8 = (_zz_sigmaDelta_increment_9 + _zz_sigmaDelta_increment_11);
  assign _zz_sigmaDelta_increment_13 = {oscillatorOutputs[4],oscillatorOutputs[3]};
  assign _zz_sigmaDelta_increment_12 = {1'd0, _zz_sigmaDelta_increment_13};
  assign _zz_sigmaDelta_increment_10 = {oscillatorOutputs[2],{oscillatorOutputs[1],oscillatorOutputs[0]}};
  Oscillator oscillator_4 (
    .io_increment              (io_increments_0[11:0]     ), //i
    .io_oscillator             (oscillator_4_io_oscillator), //o
    .clk                       (clk                       ), //i
    .rst_n                     (rst_n                     ), //i
    .enableArea_newClockEnable (enableArea_newClockEnable )  //i
  );
  Oscillator oscillator_5 (
    .io_increment              (io_increments_1[11:0]     ), //i
    .io_oscillator             (oscillator_5_io_oscillator), //o
    .clk                       (clk                       ), //i
    .rst_n                     (rst_n                     ), //i
    .enableArea_newClockEnable (enableArea_newClockEnable )  //i
  );
  Oscillator oscillator_6 (
    .io_increment              (io_increments_2[11:0]     ), //i
    .io_oscillator             (oscillator_6_io_oscillator), //o
    .clk                       (clk                       ), //i
    .rst_n                     (rst_n                     ), //i
    .enableArea_newClockEnable (enableArea_newClockEnable )  //i
  );
  Oscillator oscillator_7 (
    .io_increment              (io_increments_3[11:0]     ), //i
    .io_oscillator             (oscillator_7_io_oscillator), //o
    .clk                       (clk                       ), //i
    .rst_n                     (rst_n                     ), //i
    .enableArea_newClockEnable (enableArea_newClockEnable )  //i
  );
  NoiseGenerator noiseEnableArea_noiseGenerator (
    .io_enable                      (io_noise_enable                             ), //i
    .io_oscillator                  (noiseEnableArea_noiseGenerator_io_oscillator), //o
    .clk                            (clk                                         ), //i
    .rst_n                          (rst_n                                       ), //i
    .noiseEnableArea_newClockEnable (noiseEnableArea_newClockEnable              )  //i
  );
  always @(*) begin
    case(_zz_sigmaDelta_increment_10)
      3'b000 : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment;
      3'b001 : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment_1;
      3'b010 : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment_2;
      3'b011 : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment_3;
      3'b100 : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment_4;
      3'b101 : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment_5;
      3'b110 : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment_6;
      default : _zz_sigmaDelta_increment_9 = _zz_sigmaDelta_increment_7;
    endcase
  end

  always @(*) begin
    case(_zz_sigmaDelta_increment_12)
      3'b000 : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment;
      3'b001 : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment_1;
      3'b010 : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment_2;
      3'b011 : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment_3;
      3'b100 : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment_4;
      3'b101 : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment_5;
      3'b110 : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment_6;
      default : _zz_sigmaDelta_increment_11 = _zz_sigmaDelta_increment_7;
    endcase
  end

  assign io_oscillator_outputs = oscillatorOutputs[3 : 0];
  assign noiseEnableArea_newClockEnable = (enableArea_newClockEnable && io_noise_clocken);
  assign oscillatorOutputs = {{oscillator_7_io_oscillator,{oscillator_6_io_oscillator,{oscillator_5_io_oscillator,oscillator_4_io_oscillator}}},noiseEnableArea_noiseGenerator_io_oscillator};
  assign _zz_sigmaDelta_increment = 3'b000;
  assign _zz_sigmaDelta_increment_1 = 3'b001;
  assign _zz_sigmaDelta_increment_2 = 3'b001;
  assign _zz_sigmaDelta_increment_3 = 3'b010;
  assign _zz_sigmaDelta_increment_4 = 3'b001;
  assign _zz_sigmaDelta_increment_5 = 3'b010;
  assign _zz_sigmaDelta_increment_6 = 3'b010;
  assign _zz_sigmaDelta_increment_7 = 3'b011;
  assign sigmaDelta_increment = (_zz_sigmaDelta_increment_8 + 3'b001);
  assign sigmaDelta_countResult = ({1'b0,sigmaDelta_counter} + {1'b0,sigmaDelta_increment});
  assign io_oscillator = _zz_io_oscillator;
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      sigmaDelta_counter <= 3'b000;
    end else begin
      if(enableArea_newClockEnable) begin
        sigmaDelta_counter <= sigmaDelta_countResult[2:0];
      end
    end
  end

  always @(posedge clk) begin
    if(enableArea_newClockEnable) begin
      _zz_io_oscillator <= sigmaDelta_countResult[3];
    end
  end


endmodule

module OscillatorControl (
  output reg           io_readReq_valid,
  input  wire          io_readReq_ready,
  output wire [15:0]   io_readReq_payload,
  input  wire          io_readResp_valid,
  input  wire [7:0]    io_readResp_payload,
  output wire [11:0]   io_oscillatorIncrements_0,
  output wire [11:0]   io_oscillatorIncrements_1,
  output wire [11:0]   io_oscillatorIncrements_2,
  output wire [11:0]   io_oscillatorIncrements_3,
  output wire          io_noise_enable,
  output wire          io_noise_clocken,
  output wire          io_oscillator_en,
  input  wire          clk,
  input  wire          rst_n
);
  localparam controlFsm_enumDef_BOOT = 3'd0;
  localparam controlFsm_enumDef_fetchCmd = 3'd1;
  localparam controlFsm_enumDef_decodeCmd = 3'd2;
  localparam controlFsm_enumDef_decodeCmd_waitFrameEnd = 3'd3;
  localparam controlFsm_enumDef_setOscillatorRead = 3'd4;
  localparam controlFsm_enumDef_setOscillatorData = 3'd5;
  localparam controlFsm_enumDef_readPC = 3'd6;
  localparam controlFsm_enumDef_setPC = 3'd7;

  wire       [4:0]    _zz_oscillatorPrescaler_valueNext;
  wire       [0:0]    _zz_oscillatorPrescaler_valueNext_1;
  reg        [15:0]   pc;
  wire                when_Utils_l578;
  reg                 oscillatorPrescaler_willIncrement;
  wire                oscillatorPrescaler_willClear;
  reg        [4:0]    oscillatorPrescaler_valueNext;
  reg        [4:0]    oscillatorPrescaler_value;
  wire                oscillatorPrescaler_willOverflowIfInc;
  wire                oscillatorPrescaler_willOverflow;
  reg        [15:0]   frameLength;
  reg        [15:0]   count;
  wire                when_OscillatorControl_l27;
  wire                frameStart;
  reg        [11:0]   oscillatorControl_0;
  reg        [11:0]   oscillatorControl_1;
  reg        [11:0]   oscillatorControl_2;
  reg        [11:0]   oscillatorControl_3;
  reg                 noiseEnable;
  reg        [1:0]    oscillatorSel;
  reg        [3:0]    tempData;
  wire                controlFsm_wantExit;
  reg                 controlFsm_wantStart;
  wire                controlFsm_wantKill;
  reg        [2:0]    controlFsm_stateReg;
  reg        [2:0]    controlFsm_stateNext;
  wire       [3:0]    switch_OscillatorControl_l71;
  wire       [3:0]    _zz_frameLength;
  wire                when_OscillatorControl_l109;
  wire       [3:0]    _zz_1;
  wire       [11:0]   _zz_oscillatorControl_0;
  `ifndef SYNTHESIS
  reg [175:0] controlFsm_stateReg_string;
  reg [175:0] controlFsm_stateNext_string;
  `endif


  assign _zz_oscillatorPrescaler_valueNext_1 = oscillatorPrescaler_willIncrement;
  assign _zz_oscillatorPrescaler_valueNext = {4'd0, _zz_oscillatorPrescaler_valueNext_1};
  `ifndef SYNTHESIS
  always @(*) begin
    case(controlFsm_stateReg)
      controlFsm_enumDef_BOOT : controlFsm_stateReg_string = "BOOT                  ";
      controlFsm_enumDef_fetchCmd : controlFsm_stateReg_string = "fetchCmd              ";
      controlFsm_enumDef_decodeCmd : controlFsm_stateReg_string = "decodeCmd             ";
      controlFsm_enumDef_decodeCmd_waitFrameEnd : controlFsm_stateReg_string = "decodeCmd_waitFrameEnd";
      controlFsm_enumDef_setOscillatorRead : controlFsm_stateReg_string = "setOscillatorRead     ";
      controlFsm_enumDef_setOscillatorData : controlFsm_stateReg_string = "setOscillatorData     ";
      controlFsm_enumDef_readPC : controlFsm_stateReg_string = "readPC                ";
      controlFsm_enumDef_setPC : controlFsm_stateReg_string = "setPC                 ";
      default : controlFsm_stateReg_string = "??????????????????????";
    endcase
  end
  always @(*) begin
    case(controlFsm_stateNext)
      controlFsm_enumDef_BOOT : controlFsm_stateNext_string = "BOOT                  ";
      controlFsm_enumDef_fetchCmd : controlFsm_stateNext_string = "fetchCmd              ";
      controlFsm_enumDef_decodeCmd : controlFsm_stateNext_string = "decodeCmd             ";
      controlFsm_enumDef_decodeCmd_waitFrameEnd : controlFsm_stateNext_string = "decodeCmd_waitFrameEnd";
      controlFsm_enumDef_setOscillatorRead : controlFsm_stateNext_string = "setOscillatorRead     ";
      controlFsm_enumDef_setOscillatorData : controlFsm_stateNext_string = "setOscillatorData     ";
      controlFsm_enumDef_readPC : controlFsm_stateNext_string = "readPC                ";
      controlFsm_enumDef_setPC : controlFsm_stateNext_string = "setPC                 ";
      default : controlFsm_stateNext_string = "??????????????????????";
    endcase
  end
  `endif

  assign when_Utils_l578 = 1'b1;
  always @(*) begin
    oscillatorPrescaler_willIncrement = 1'b0;
    if(when_Utils_l578) begin
      oscillatorPrescaler_willIncrement = 1'b1;
    end
  end

  assign oscillatorPrescaler_willClear = 1'b0;
  assign oscillatorPrescaler_willOverflowIfInc = (oscillatorPrescaler_value == 5'h1f);
  assign oscillatorPrescaler_willOverflow = (oscillatorPrescaler_willOverflowIfInc && oscillatorPrescaler_willIncrement);
  always @(*) begin
    oscillatorPrescaler_valueNext = (oscillatorPrescaler_value + _zz_oscillatorPrescaler_valueNext);
    if(oscillatorPrescaler_willClear) begin
      oscillatorPrescaler_valueNext = 5'h0;
    end
  end

  assign io_oscillator_en = oscillatorPrescaler_willOverflow;
  assign when_OscillatorControl_l27 = (count == 16'h0);
  assign frameStart = ((count == 16'h0) && oscillatorPrescaler_willOverflow);
  assign io_readReq_payload = pc;
  always @(*) begin
    io_readReq_valid = 1'b0;
    case(controlFsm_stateReg)
      controlFsm_enumDef_fetchCmd : begin
        io_readReq_valid = oscillatorPrescaler_willOverflow;
      end
      controlFsm_enumDef_decodeCmd : begin
      end
      controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
      end
      controlFsm_enumDef_setOscillatorRead : begin
        io_readReq_valid = oscillatorPrescaler_willOverflow;
      end
      controlFsm_enumDef_setOscillatorData : begin
      end
      controlFsm_enumDef_readPC : begin
        io_readReq_valid = oscillatorPrescaler_willOverflow;
      end
      controlFsm_enumDef_setPC : begin
      end
      default : begin
      end
    endcase
  end

  assign io_oscillatorIncrements_0 = oscillatorControl_0;
  assign io_oscillatorIncrements_1 = oscillatorControl_1;
  assign io_oscillatorIncrements_2 = oscillatorControl_2;
  assign io_oscillatorIncrements_3 = oscillatorControl_3;
  assign io_noise_enable = noiseEnable;
  assign io_noise_clocken = (count[7 : 0] == 8'h0);
  assign controlFsm_wantExit = 1'b0;
  always @(*) begin
    controlFsm_wantStart = 1'b0;
    case(controlFsm_stateReg)
      controlFsm_enumDef_fetchCmd : begin
      end
      controlFsm_enumDef_decodeCmd : begin
      end
      controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
      end
      controlFsm_enumDef_setOscillatorRead : begin
      end
      controlFsm_enumDef_setOscillatorData : begin
      end
      controlFsm_enumDef_readPC : begin
      end
      controlFsm_enumDef_setPC : begin
      end
      default : begin
        controlFsm_wantStart = 1'b1;
      end
    endcase
  end

  assign controlFsm_wantKill = 1'b0;
  always @(*) begin
    controlFsm_stateNext = controlFsm_stateReg;
    case(controlFsm_stateReg)
      controlFsm_enumDef_fetchCmd : begin
        if(io_readReq_ready) begin
          controlFsm_stateNext = controlFsm_enumDef_decodeCmd;
        end
      end
      controlFsm_enumDef_decodeCmd : begin
        if(io_readResp_valid) begin
          case(switch_OscillatorControl_l71)
            4'b0000 : begin
              controlFsm_stateNext = controlFsm_enumDef_fetchCmd;
            end
            4'b0001 : begin
              controlFsm_stateNext = controlFsm_enumDef_fetchCmd;
            end
            4'b0010, 4'b0011 : begin
              controlFsm_stateNext = controlFsm_enumDef_decodeCmd_waitFrameEnd;
            end
            4'b1100 : begin
              controlFsm_stateNext = controlFsm_enumDef_setOscillatorRead;
            end
            4'b1101 : begin
              controlFsm_stateNext = controlFsm_enumDef_setOscillatorRead;
            end
            4'b1110 : begin
              controlFsm_stateNext = controlFsm_enumDef_setOscillatorRead;
            end
            4'b1111 : begin
              controlFsm_stateNext = controlFsm_enumDef_setOscillatorRead;
            end
            default : begin
            end
          endcase
        end
      end
      controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
        if(frameStart) begin
          if(!when_OscillatorControl_l109) begin
            controlFsm_stateNext = controlFsm_enumDef_fetchCmd;
          end
        end
      end
      controlFsm_enumDef_setOscillatorRead : begin
        if(io_readReq_ready) begin
          controlFsm_stateNext = controlFsm_enumDef_setOscillatorData;
        end
      end
      controlFsm_enumDef_setOscillatorData : begin
        if(io_readResp_valid) begin
          controlFsm_stateNext = controlFsm_enumDef_fetchCmd;
        end
      end
      controlFsm_enumDef_readPC : begin
        if(io_readReq_ready) begin
          controlFsm_stateNext = controlFsm_enumDef_setPC;
        end
      end
      controlFsm_enumDef_setPC : begin
        if(io_readResp_valid) begin
          controlFsm_stateNext = controlFsm_enumDef_fetchCmd;
        end
      end
      default : begin
      end
    endcase
    if(controlFsm_wantStart) begin
      controlFsm_stateNext = controlFsm_enumDef_fetchCmd;
    end
    if(controlFsm_wantKill) begin
      controlFsm_stateNext = controlFsm_enumDef_BOOT;
    end
  end

  assign switch_OscillatorControl_l71 = io_readResp_payload[7 : 4];
  assign _zz_frameLength = io_readResp_payload[3 : 0];
  assign when_OscillatorControl_l109 = (tempData != 4'b0000);
  assign _zz_1 = ({3'd0,1'b1} <<< oscillatorSel);
  assign _zz_oscillatorControl_0 = {tempData,io_readResp_payload};
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      pc <= 16'h0;
      oscillatorPrescaler_value <= 5'h0;
      frameLength <= 16'hffff;
      count <= 16'h0;
      noiseEnable <= 1'b0;
      controlFsm_stateReg <= controlFsm_enumDef_BOOT;
    end else begin
      oscillatorPrescaler_value <= oscillatorPrescaler_valueNext;
      if(oscillatorPrescaler_willOverflow) begin
        if(when_OscillatorControl_l27) begin
          count <= frameLength;
        end else begin
          count <= (count - 16'h0001);
        end
      end
      controlFsm_stateReg <= controlFsm_stateNext;
      case(controlFsm_stateReg)
        controlFsm_enumDef_fetchCmd : begin
          if(io_readReq_ready) begin
            pc <= (pc + 16'h0001);
          end
        end
        controlFsm_enumDef_decodeCmd : begin
          if(io_readResp_valid) begin
            case(switch_OscillatorControl_l71)
              4'b0001 : begin
                frameLength[15 : 12] <= _zz_frameLength;
              end
              default : begin
              end
            endcase
          end
        end
        controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
          noiseEnable <= oscillatorSel[0];
        end
        controlFsm_enumDef_setOscillatorRead : begin
          if(io_readReq_ready) begin
            pc <= (pc + 16'h0001);
          end
        end
        controlFsm_enumDef_setOscillatorData : begin
        end
        controlFsm_enumDef_readPC : begin
          if(io_readReq_ready) begin
            pc <= (pc + 16'h0001);
          end
        end
        controlFsm_enumDef_setPC : begin
          if(io_readResp_valid) begin
            pc <= {{tempData,io_readResp_payload},4'b0000};
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case(controlFsm_stateReg)
      controlFsm_enumDef_fetchCmd : begin
      end
      controlFsm_enumDef_decodeCmd : begin
        if(io_readResp_valid) begin
          tempData <= _zz_frameLength;
          case(switch_OscillatorControl_l71)
            4'b0010, 4'b0011 : begin
              oscillatorSel <= io_readResp_payload[5 : 4];
            end
            4'b1100 : begin
              oscillatorSel <= 2'b00;
            end
            4'b1101 : begin
              oscillatorSel <= 2'b01;
            end
            4'b1110 : begin
              oscillatorSel <= 2'b10;
            end
            4'b1111 : begin
              oscillatorSel <= 2'b11;
            end
            default : begin
            end
          endcase
        end
      end
      controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
        if(frameStart) begin
          if(when_OscillatorControl_l109) begin
            tempData <= (tempData - 4'b0001);
          end
        end
      end
      controlFsm_enumDef_setOscillatorRead : begin
      end
      controlFsm_enumDef_setOscillatorData : begin
        if(io_readResp_valid) begin
          if(_zz_1[0]) begin
            oscillatorControl_0 <= _zz_oscillatorControl_0;
          end
          if(_zz_1[1]) begin
            oscillatorControl_1 <= _zz_oscillatorControl_0;
          end
          if(_zz_1[2]) begin
            oscillatorControl_2 <= _zz_oscillatorControl_0;
          end
          if(_zz_1[3]) begin
            oscillatorControl_3 <= _zz_oscillatorControl_0;
          end
        end
      end
      controlFsm_enumDef_readPC : begin
      end
      controlFsm_enumDef_setPC : begin
      end
      default : begin
      end
    endcase
  end


endmodule

module VGATimingGenerator (
  output reg           io_hsync,
  output reg           io_vsync,
  output reg           io_video_active,
  output reg           io_frame_start,
  output reg           io_line_start,
  output reg  [9:0]    io_x_coord,
  output reg  [8:0]    io_y_coord,
  input  wire          clk,
  input  wire          rst_n
);
  localparam hSyncFsm_enumDef_BOOT = 3'd0;
  localparam hSyncFsm_enumDef_frontPorch = 3'd1;
  localparam hSyncFsm_enumDef_visible = 3'd2;
  localparam hSyncFsm_enumDef_backPorch = 3'd3;
  localparam hSyncFsm_enumDef_sync = 3'd4;
  localparam vSyncFsm_enumDef_BOOT = 3'd0;
  localparam vSyncFsm_enumDef_frontPorch = 3'd1;
  localparam vSyncFsm_enumDef_visible = 3'd2;
  localparam vSyncFsm_enumDef_backPorch = 3'd3;
  localparam vSyncFsm_enumDef_sync = 3'd4;

  reg        [9:0]    xCounter;
  reg        [8:0]    yCounter;
  reg                 newLine;
  wire                hSyncFsm_wantExit;
  reg                 hSyncFsm_wantStart;
  wire                hSyncFsm_wantKill;
  wire                vSyncFsm_wantExit;
  reg                 vSyncFsm_wantStart;
  wire                vSyncFsm_wantKill;
  reg        [2:0]    hSyncFsm_stateReg;
  reg        [2:0]    hSyncFsm_stateNext;
  wire                when_VGA_l57;
  wire                when_VGA_l69;
  wire                when_VGA_l78;
  wire                when_VGA_l89;
  reg        [2:0]    vSyncFsm_stateReg;
  reg        [2:0]    vSyncFsm_stateNext;
  wire                when_VGA_l104;
  wire                when_VGA_l117;
  wire                when_VGA_l129;
  wire                when_VGA_l143;
  `ifndef SYNTHESIS
  reg [79:0] hSyncFsm_stateReg_string;
  reg [79:0] hSyncFsm_stateNext_string;
  reg [79:0] vSyncFsm_stateReg_string;
  reg [79:0] vSyncFsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_BOOT : hSyncFsm_stateReg_string = "BOOT      ";
      hSyncFsm_enumDef_frontPorch : hSyncFsm_stateReg_string = "frontPorch";
      hSyncFsm_enumDef_visible : hSyncFsm_stateReg_string = "visible   ";
      hSyncFsm_enumDef_backPorch : hSyncFsm_stateReg_string = "backPorch ";
      hSyncFsm_enumDef_sync : hSyncFsm_stateReg_string = "sync      ";
      default : hSyncFsm_stateReg_string = "??????????";
    endcase
  end
  always @(*) begin
    case(hSyncFsm_stateNext)
      hSyncFsm_enumDef_BOOT : hSyncFsm_stateNext_string = "BOOT      ";
      hSyncFsm_enumDef_frontPorch : hSyncFsm_stateNext_string = "frontPorch";
      hSyncFsm_enumDef_visible : hSyncFsm_stateNext_string = "visible   ";
      hSyncFsm_enumDef_backPorch : hSyncFsm_stateNext_string = "backPorch ";
      hSyncFsm_enumDef_sync : hSyncFsm_stateNext_string = "sync      ";
      default : hSyncFsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(vSyncFsm_stateReg)
      vSyncFsm_enumDef_BOOT : vSyncFsm_stateReg_string = "BOOT      ";
      vSyncFsm_enumDef_frontPorch : vSyncFsm_stateReg_string = "frontPorch";
      vSyncFsm_enumDef_visible : vSyncFsm_stateReg_string = "visible   ";
      vSyncFsm_enumDef_backPorch : vSyncFsm_stateReg_string = "backPorch ";
      vSyncFsm_enumDef_sync : vSyncFsm_stateReg_string = "sync      ";
      default : vSyncFsm_stateReg_string = "??????????";
    endcase
  end
  always @(*) begin
    case(vSyncFsm_stateNext)
      vSyncFsm_enumDef_BOOT : vSyncFsm_stateNext_string = "BOOT      ";
      vSyncFsm_enumDef_frontPorch : vSyncFsm_stateNext_string = "frontPorch";
      vSyncFsm_enumDef_visible : vSyncFsm_stateNext_string = "visible   ";
      vSyncFsm_enumDef_backPorch : vSyncFsm_stateNext_string = "backPorch ";
      vSyncFsm_enumDef_sync : vSyncFsm_stateNext_string = "sync      ";
      default : vSyncFsm_stateNext_string = "??????????";
    endcase
  end
  `endif

  always @(*) begin
    io_x_coord = 10'h0;
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_frontPorch : begin
      end
      hSyncFsm_enumDef_visible : begin
        io_x_coord = xCounter;
      end
      hSyncFsm_enumDef_backPorch : begin
      end
      hSyncFsm_enumDef_sync : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_y_coord = 9'h0;
    case(vSyncFsm_stateReg)
      vSyncFsm_enumDef_frontPorch : begin
      end
      vSyncFsm_enumDef_visible : begin
        io_y_coord = yCounter;
      end
      vSyncFsm_enumDef_backPorch : begin
      end
      vSyncFsm_enumDef_sync : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_hsync = 1'b0;
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_frontPorch : begin
      end
      hSyncFsm_enumDef_visible : begin
      end
      hSyncFsm_enumDef_backPorch : begin
      end
      hSyncFsm_enumDef_sync : begin
        io_hsync = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_vsync = 1'b0;
    case(vSyncFsm_stateReg)
      vSyncFsm_enumDef_frontPorch : begin
      end
      vSyncFsm_enumDef_visible : begin
      end
      vSyncFsm_enumDef_backPorch : begin
      end
      vSyncFsm_enumDef_sync : begin
        io_vsync = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_frame_start = 1'b0;
    case(vSyncFsm_stateReg)
      vSyncFsm_enumDef_frontPorch : begin
        if(newLine) begin
          if(when_VGA_l104) begin
            io_frame_start = 1'b1;
          end
        end
      end
      vSyncFsm_enumDef_visible : begin
      end
      vSyncFsm_enumDef_backPorch : begin
      end
      vSyncFsm_enumDef_sync : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_line_start = 1'b0;
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_frontPorch : begin
        if(when_VGA_l57) begin
          io_line_start = 1'b1;
        end
      end
      hSyncFsm_enumDef_visible : begin
      end
      hSyncFsm_enumDef_backPorch : begin
      end
      hSyncFsm_enumDef_sync : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_video_active = 1'b0;
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_frontPorch : begin
      end
      hSyncFsm_enumDef_visible : begin
        io_video_active = 1'b1;
      end
      hSyncFsm_enumDef_backPorch : begin
      end
      hSyncFsm_enumDef_sync : begin
      end
      default : begin
      end
    endcase
    case(vSyncFsm_stateReg)
      vSyncFsm_enumDef_frontPorch : begin
        io_video_active = 1'b0;
      end
      vSyncFsm_enumDef_visible : begin
      end
      vSyncFsm_enumDef_backPorch : begin
        io_video_active = 1'b0;
      end
      vSyncFsm_enumDef_sync : begin
        io_video_active = 1'b0;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    newLine = 1'b0;
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_frontPorch : begin
      end
      hSyncFsm_enumDef_visible : begin
      end
      hSyncFsm_enumDef_backPorch : begin
      end
      hSyncFsm_enumDef_sync : begin
        if(when_VGA_l89) begin
          newLine = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign hSyncFsm_wantExit = 1'b0;
  always @(*) begin
    hSyncFsm_wantStart = 1'b0;
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_frontPorch : begin
      end
      hSyncFsm_enumDef_visible : begin
      end
      hSyncFsm_enumDef_backPorch : begin
      end
      hSyncFsm_enumDef_sync : begin
      end
      default : begin
        hSyncFsm_wantStart = 1'b1;
      end
    endcase
  end

  assign hSyncFsm_wantKill = 1'b0;
  assign vSyncFsm_wantExit = 1'b0;
  always @(*) begin
    vSyncFsm_wantStart = 1'b0;
    case(vSyncFsm_stateReg)
      vSyncFsm_enumDef_frontPorch : begin
      end
      vSyncFsm_enumDef_visible : begin
      end
      vSyncFsm_enumDef_backPorch : begin
      end
      vSyncFsm_enumDef_sync : begin
      end
      default : begin
        vSyncFsm_wantStart = 1'b1;
      end
    endcase
  end

  assign vSyncFsm_wantKill = 1'b0;
  always @(*) begin
    hSyncFsm_stateNext = hSyncFsm_stateReg;
    case(hSyncFsm_stateReg)
      hSyncFsm_enumDef_frontPorch : begin
        if(when_VGA_l57) begin
          hSyncFsm_stateNext = hSyncFsm_enumDef_visible;
        end
      end
      hSyncFsm_enumDef_visible : begin
        if(when_VGA_l69) begin
          hSyncFsm_stateNext = hSyncFsm_enumDef_backPorch;
        end
      end
      hSyncFsm_enumDef_backPorch : begin
        if(when_VGA_l78) begin
          hSyncFsm_stateNext = hSyncFsm_enumDef_sync;
        end
      end
      hSyncFsm_enumDef_sync : begin
        if(when_VGA_l89) begin
          hSyncFsm_stateNext = hSyncFsm_enumDef_frontPorch;
        end
      end
      default : begin
      end
    endcase
    if(hSyncFsm_wantStart) begin
      hSyncFsm_stateNext = hSyncFsm_enumDef_frontPorch;
    end
    if(hSyncFsm_wantKill) begin
      hSyncFsm_stateNext = hSyncFsm_enumDef_BOOT;
    end
  end

  assign when_VGA_l57 = (xCounter == 10'h00b);
  assign when_VGA_l69 = (xCounter == 10'h1fb);
  assign when_VGA_l78 = (xCounter == 10'h026);
  assign when_VGA_l89 = (xCounter == 10'h04b);
  always @(*) begin
    vSyncFsm_stateNext = vSyncFsm_stateReg;
    case(vSyncFsm_stateReg)
      vSyncFsm_enumDef_frontPorch : begin
        if(newLine) begin
          if(when_VGA_l104) begin
            vSyncFsm_stateNext = vSyncFsm_enumDef_visible;
          end
        end
      end
      vSyncFsm_enumDef_visible : begin
        if(newLine) begin
          if(when_VGA_l117) begin
            vSyncFsm_stateNext = vSyncFsm_enumDef_backPorch;
          end
        end
      end
      vSyncFsm_enumDef_backPorch : begin
        if(newLine) begin
          if(when_VGA_l129) begin
            vSyncFsm_stateNext = vSyncFsm_enumDef_sync;
          end
        end
      end
      vSyncFsm_enumDef_sync : begin
        if(newLine) begin
          if(when_VGA_l143) begin
            vSyncFsm_stateNext = vSyncFsm_enumDef_frontPorch;
          end
        end
      end
      default : begin
      end
    endcase
    if(vSyncFsm_wantStart) begin
      vSyncFsm_stateNext = vSyncFsm_enumDef_frontPorch;
    end
    if(vSyncFsm_wantKill) begin
      vSyncFsm_stateNext = vSyncFsm_enumDef_BOOT;
    end
  end

  assign when_VGA_l104 = (yCounter == 9'h009);
  assign when_VGA_l117 = (yCounter == 9'h1df);
  assign when_VGA_l129 = (yCounter == 9'h020);
  assign when_VGA_l143 = (yCounter == 9'h001);
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      xCounter <= 10'h0;
      yCounter <= 9'h0;
      hSyncFsm_stateReg <= hSyncFsm_enumDef_BOOT;
      vSyncFsm_stateReg <= vSyncFsm_enumDef_BOOT;
    end else begin
      hSyncFsm_stateReg <= hSyncFsm_stateNext;
      case(hSyncFsm_stateReg)
        hSyncFsm_enumDef_frontPorch : begin
          xCounter <= (xCounter + 10'h001);
          if(when_VGA_l57) begin
            xCounter <= 10'h0;
          end
        end
        hSyncFsm_enumDef_visible : begin
          xCounter <= (xCounter + 10'h001);
          if(when_VGA_l69) begin
            xCounter <= 10'h0;
          end
        end
        hSyncFsm_enumDef_backPorch : begin
          xCounter <= (xCounter + 10'h001);
          if(when_VGA_l78) begin
            xCounter <= 10'h0;
          end
        end
        hSyncFsm_enumDef_sync : begin
          xCounter <= (xCounter + 10'h001);
          if(when_VGA_l89) begin
            xCounter <= 10'h0;
          end
        end
        default : begin
        end
      endcase
      vSyncFsm_stateReg <= vSyncFsm_stateNext;
      case(vSyncFsm_stateReg)
        vSyncFsm_enumDef_frontPorch : begin
          if(newLine) begin
            yCounter <= (yCounter + 9'h001);
            if(when_VGA_l104) begin
              yCounter <= 9'h0;
            end
          end
        end
        vSyncFsm_enumDef_visible : begin
          if(newLine) begin
            yCounter <= (yCounter + 9'h001);
            if(when_VGA_l117) begin
              yCounter <= 9'h0;
            end
          end
        end
        vSyncFsm_enumDef_backPorch : begin
          if(newLine) begin
            yCounter <= (yCounter + 9'h001);
            if(when_VGA_l129) begin
              yCounter <= 9'h0;
            end
          end
        end
        vSyncFsm_enumDef_sync : begin
          if(newLine) begin
            yCounter <= (yCounter + 9'h001);
            if(when_VGA_l143) begin
              yCounter <= 9'h0;
            end
          end
        end
        default : begin
        end
      endcase
    end
  end


endmodule

module SpiMaster (
  output wire [0:0]    io_spi_ss,
  output wire          io_spi_sclk,
  output wire          io_spi_mosi,
  input  wire          io_spi_miso,
  input  wire          io_cmd_valid,
  output reg           io_cmd_ready,
  input  wire [7:0]    io_cmd_payload,
  output reg           io_resp_valid,
  output wire [7:0]    io_resp_payload,
  input  wire          clk,
  input  wire          rst_n
);
  localparam fsm_dataSend_fsm_enumDef_BOOT = 2'd0;
  localparam fsm_dataSend_fsm_enumDef_drive = 2'd1;
  localparam fsm_dataSend_fsm_enumDef_clock = 2'd2;
  localparam fsm_dataSend_fsm_enumDef_exitState = 2'd3;
  localparam fsm_enumDef_1_BOOT = 3'd0;
  localparam fsm_enumDef_1_idle = 3'd1;
  localparam fsm_enumDef_1_txBegin = 3'd2;
  localparam fsm_enumDef_1_dataSend = 3'd3;
  localparam fsm_enumDef_1_txEnd = 3'd4;

  reg        [0:0]    _zz_spi_mosi;
  wire                sclk_active;
  wire       [0:0]    ss_active;
  reg        [7:0]    dataIn;
  reg        [0:0]    spi_ss;
  reg                 spi_sclk;
  reg                 spi_mosi;
  reg                 spi_miso;
  reg        [2:0]    bitCount;
  reg                 en;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg                 fsm_dataSend_fsm_wantExit;
  reg                 fsm_dataSend_fsm_wantStart;
  wire                fsm_dataSend_fsm_wantKill;
  reg        [1:0]    fsm_dataSend_fsm_stateReg;
  reg        [1:0]    fsm_dataSend_fsm_stateNext;
  wire                when_SpiMaster_l90;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  wire                when_StateMachine_l253;
  `ifndef SYNTHESIS
  reg [71:0] fsm_dataSend_fsm_stateReg_string;
  reg [71:0] fsm_dataSend_fsm_stateNext_string;
  reg [63:0] fsm_stateReg_string;
  reg [63:0] fsm_stateNext_string;
  `endif


  always @(*) begin
    case(bitCount)
      3'b000 : _zz_spi_mosi = io_cmd_payload[0 : 0];
      3'b001 : _zz_spi_mosi = io_cmd_payload[1 : 1];
      3'b010 : _zz_spi_mosi = io_cmd_payload[2 : 2];
      3'b011 : _zz_spi_mosi = io_cmd_payload[3 : 3];
      3'b100 : _zz_spi_mosi = io_cmd_payload[4 : 4];
      3'b101 : _zz_spi_mosi = io_cmd_payload[5 : 5];
      3'b110 : _zz_spi_mosi = io_cmd_payload[6 : 6];
      default : _zz_spi_mosi = io_cmd_payload[7 : 7];
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_dataSend_fsm_stateReg)
      fsm_dataSend_fsm_enumDef_BOOT : fsm_dataSend_fsm_stateReg_string = "BOOT     ";
      fsm_dataSend_fsm_enumDef_drive : fsm_dataSend_fsm_stateReg_string = "drive    ";
      fsm_dataSend_fsm_enumDef_clock : fsm_dataSend_fsm_stateReg_string = "clock    ";
      fsm_dataSend_fsm_enumDef_exitState : fsm_dataSend_fsm_stateReg_string = "exitState";
      default : fsm_dataSend_fsm_stateReg_string = "?????????";
    endcase
  end
  always @(*) begin
    case(fsm_dataSend_fsm_stateNext)
      fsm_dataSend_fsm_enumDef_BOOT : fsm_dataSend_fsm_stateNext_string = "BOOT     ";
      fsm_dataSend_fsm_enumDef_drive : fsm_dataSend_fsm_stateNext_string = "drive    ";
      fsm_dataSend_fsm_enumDef_clock : fsm_dataSend_fsm_stateNext_string = "clock    ";
      fsm_dataSend_fsm_enumDef_exitState : fsm_dataSend_fsm_stateNext_string = "exitState";
      default : fsm_dataSend_fsm_stateNext_string = "?????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateReg)
      fsm_enumDef_1_BOOT : fsm_stateReg_string = "BOOT    ";
      fsm_enumDef_1_idle : fsm_stateReg_string = "idle    ";
      fsm_enumDef_1_txBegin : fsm_stateReg_string = "txBegin ";
      fsm_enumDef_1_dataSend : fsm_stateReg_string = "dataSend";
      fsm_enumDef_1_txEnd : fsm_stateReg_string = "txEnd   ";
      default : fsm_stateReg_string = "????????";
    endcase
  end
  always @(*) begin
    case(fsm_stateNext)
      fsm_enumDef_1_BOOT : fsm_stateNext_string = "BOOT    ";
      fsm_enumDef_1_idle : fsm_stateNext_string = "idle    ";
      fsm_enumDef_1_txBegin : fsm_stateNext_string = "txBegin ";
      fsm_enumDef_1_dataSend : fsm_stateNext_string = "dataSend";
      fsm_enumDef_1_txEnd : fsm_stateNext_string = "txEnd   ";
      default : fsm_stateNext_string = "????????";
    endcase
  end
  `endif

  assign sclk_active = 1'b1;
  assign ss_active = 1'b0;
  assign io_spi_ss = spi_ss;
  assign io_spi_sclk = spi_sclk;
  assign io_spi_mosi = spi_mosi;
  always @(*) begin
    io_cmd_ready = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_txBegin : begin
      end
      fsm_enumDef_1_dataSend : begin
        if(fsm_dataSend_fsm_wantExit) begin
          io_cmd_ready = 1'b1;
        end
      end
      fsm_enumDef_1_txEnd : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    io_resp_valid = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_txBegin : begin
      end
      fsm_enumDef_1_dataSend : begin
      end
      fsm_enumDef_1_txEnd : begin
        io_resp_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign io_resp_payload = dataIn;
  assign fsm_wantExit = 1'b0;
  always @(*) begin
    fsm_wantStart = 1'b0;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
      end
      fsm_enumDef_1_txBegin : begin
      end
      fsm_enumDef_1_dataSend : begin
      end
      fsm_enumDef_1_txEnd : begin
      end
      default : begin
        fsm_wantStart = 1'b1;
      end
    endcase
  end

  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_dataSend_fsm_wantExit = 1'b0;
    case(fsm_dataSend_fsm_stateReg)
      fsm_dataSend_fsm_enumDef_drive : begin
      end
      fsm_dataSend_fsm_enumDef_clock : begin
      end
      fsm_dataSend_fsm_enumDef_exitState : begin
        if(en) begin
          fsm_dataSend_fsm_wantExit = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    fsm_dataSend_fsm_wantStart = 1'b0;
    if(when_StateMachine_l253) begin
      fsm_dataSend_fsm_wantStart = 1'b1;
    end
  end

  assign fsm_dataSend_fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_stateReg;
    case(fsm_dataSend_fsm_stateReg)
      fsm_dataSend_fsm_enumDef_drive : begin
        if(en) begin
          fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clock;
        end
      end
      fsm_dataSend_fsm_enumDef_clock : begin
        if(en) begin
          if(when_SpiMaster_l90) begin
            fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_exitState;
          end else begin
            fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_drive;
          end
        end
      end
      fsm_dataSend_fsm_enumDef_exitState : begin
        if(en) begin
          fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_BOOT;
        end
      end
      default : begin
      end
    endcase
    if(fsm_dataSend_fsm_wantStart) begin
      fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_drive;
    end
    if(fsm_dataSend_fsm_wantKill) begin
      fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_BOOT;
    end
  end

  assign when_SpiMaster_l90 = (bitCount == 3'b000);
  always @(*) begin
    fsm_stateNext = fsm_stateReg;
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
        if(io_cmd_valid) begin
          fsm_stateNext = fsm_enumDef_1_txBegin;
        end
      end
      fsm_enumDef_1_txBegin : begin
        fsm_stateNext = fsm_enumDef_1_dataSend;
      end
      fsm_enumDef_1_dataSend : begin
        if(fsm_dataSend_fsm_wantExit) begin
          fsm_stateNext = fsm_enumDef_1_txEnd;
        end
      end
      fsm_enumDef_1_txEnd : begin
        if(io_cmd_valid) begin
          fsm_stateNext = fsm_enumDef_1_dataSend;
        end else begin
          fsm_stateNext = fsm_enumDef_1_idle;
        end
      end
      default : begin
      end
    endcase
    if(fsm_wantStart) begin
      fsm_stateNext = fsm_enumDef_1_idle;
    end
    if(fsm_wantKill) begin
      fsm_stateNext = fsm_enumDef_1_BOOT;
    end
  end

  assign when_StateMachine_l253 = ((! (fsm_stateReg == fsm_enumDef_1_dataSend)) && (fsm_stateNext == fsm_enumDef_1_dataSend));
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      spi_ss <= (~ ss_active);
      spi_sclk <= (! sclk_active);
      spi_mosi <= 1'b0;
      fsm_dataSend_fsm_stateReg <= fsm_dataSend_fsm_enumDef_BOOT;
      fsm_stateReg <= fsm_enumDef_1_BOOT;
    end else begin
      fsm_dataSend_fsm_stateReg <= fsm_dataSend_fsm_stateNext;
      case(fsm_dataSend_fsm_stateReg)
        fsm_dataSend_fsm_enumDef_drive : begin
          if(en) begin
            spi_sclk <= (! sclk_active);
            spi_mosi <= _zz_spi_mosi[0];
          end
        end
        fsm_dataSend_fsm_enumDef_clock : begin
          if(en) begin
            spi_sclk <= sclk_active;
          end
        end
        fsm_dataSend_fsm_enumDef_exitState : begin
        end
        default : begin
        end
      endcase
      fsm_stateReg <= fsm_stateNext;
      case(fsm_stateReg)
        fsm_enumDef_1_idle : begin
        end
        fsm_enumDef_1_txBegin : begin
          spi_ss <= ss_active;
        end
        fsm_enumDef_1_dataSend : begin
        end
        fsm_enumDef_1_txEnd : begin
          spi_sclk <= (! sclk_active);
          if(!io_cmd_valid) begin
            spi_ss <= (~ ss_active);
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    spi_miso <= io_spi_miso;
    en <= (! en);
    case(fsm_dataSend_fsm_stateReg)
      fsm_dataSend_fsm_enumDef_drive : begin
      end
      fsm_dataSend_fsm_enumDef_clock : begin
        if(en) begin
          dataIn <= {dataIn[6 : 0],spi_miso};
          if(!when_SpiMaster_l90) begin
            bitCount <= (bitCount - 3'b001);
          end
        end
      end
      fsm_dataSend_fsm_enumDef_exitState : begin
      end
      default : begin
      end
    endcase
    if(when_StateMachine_l253) begin
      bitCount <= 3'b111;
    end
  end


endmodule

module NoiseGenerator (
  input  wire          io_enable,
  output reg           io_oscillator,
  input  wire          clk,
  input  wire          rst_n,
  input  wire          noiseEnableArea_newClockEnable
);

  reg        [11:0]   shiftRegister;

  always @(*) begin
    io_oscillator = 1'b0;
    if(io_enable) begin
      io_oscillator = shiftRegister[11];
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      shiftRegister <= 12'h001;
    end else begin
      if(noiseEnableArea_newClockEnable) begin
        if(io_enable) begin
          shiftRegister <= {shiftRegister[10 : 0],((shiftRegister[11] ^ shiftRegister[10]) ^ shiftRegister[3])};
        end
      end
    end
  end


endmodule

//Oscillator_3 replaced by Oscillator

//Oscillator_2 replaced by Oscillator

//Oscillator_1 replaced by Oscillator

module Oscillator (
  input  wire [11:0]   io_increment,
  output wire          io_oscillator,
  input  wire          clk,
  input  wire          rst_n,
  input  wire          enableArea_newClockEnable
);

  reg        [12:0]   counter;
  reg                 toggle;
  wire                when_Oscillator_l15;
  wire                when_Oscillator_l17;

  assign when_Oscillator_l15 = (counter == 13'h0);
  assign when_Oscillator_l17 = (io_increment != 12'h0);
  assign io_oscillator = toggle;
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      counter <= 13'h0;
    end else begin
      if(enableArea_newClockEnable) begin
        if(when_Oscillator_l15) begin
          counter <= {io_increment,1'b0};
        end else begin
          counter <= (counter - 13'h0001);
        end
      end
    end
  end

  always @(posedge clk) begin
    if(enableArea_newClockEnable) begin
      if(when_Oscillator_l15) begin
        if(when_Oscillator_l17) begin
          toggle <= (! toggle);
        end
      end
    end
  end


endmodule
