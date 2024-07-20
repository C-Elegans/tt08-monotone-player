// Generator : SpinalHDL v1.10.2a    git head : a348a60b7e8b6a455c72e1536ec3d74a2ea16935
// Component : tt_um_elegans_design
// Git hash  : 6a0cf1447db5f6a983bd36f5c5624ec702700aa6

`timescale 1ns/1ps

module tt_um_elegans_design (
  input  wire [7:0]    ui_in,
  output reg  [7:0]    uo_out,
  input  wire [7:0]    uio_in,
  output wire [7:0]    uio_out,
  output wire [7:0]    uio_oe,
  input  wire          ena,
  input  wire          clk,
  input  wire          rst_n
);

  wire                top_1_io_spi_miso;
  wire                top_1_io_spi_sclk;
  wire                top_1_io_spi_mosi;
  wire       [0:0]    top_1_io_spi_ss;
  wire                top_1_io_oscillator;

  Top top_1 (
    .io_spi_ss     (top_1_io_spi_ss    ), //o
    .io_spi_sclk   (top_1_io_spi_sclk  ), //o
    .io_spi_mosi   (top_1_io_spi_mosi  ), //o
    .io_spi_miso   (top_1_io_spi_miso  ), //i
    .io_oscillator (top_1_io_oscillator), //o
    .clk           (clk                ), //i
    .rst_n         (rst_n              )  //i
  );
  assign uio_oe = 8'h0;
  assign uio_out = 8'h0;
  always @(*) begin
    uo_out = 8'h0;
    uo_out[0] = top_1_io_spi_ss[0];
    uo_out[1] = top_1_io_spi_sclk;
    uo_out[2] = top_1_io_spi_mosi;
    uo_out[7] = top_1_io_oscillator;
  end

  assign top_1_io_spi_miso = ui_in[0];

endmodule

module Top (
  output wire [0:0]    io_spi_ss,
  output wire          io_spi_sclk,
  output wire          io_spi_mosi,
  input  wire          io_spi_miso,
  output wire          io_oscillator,
  input  wire          clk,
  input  wire          rst_n
);

  wire                oscillatorGroup_1_io_oscillator;
  wire                spiRom_1_io_spi_sclk;
  wire                spiRom_1_io_spi_mosi;
  wire       [0:0]    spiRom_1_io_spi_ss;
  wire                spiRom_1_io_readReq_ready;
  wire                spiRom_1_io_readResp_valid;
  wire       [7:0]    spiRom_1_io_readResp_payload;
  wire                oscillatorControl_1_io_readReq_valid;
  wire       [15:0]   oscillatorControl_1_io_readReq_payload;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_0;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_1;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_2;
  wire       [11:0]   oscillatorControl_1_io_oscillatorIncrements_3;

  OscillatorGroup oscillatorGroup_1 (
    .io_increments_0 (oscillatorControl_1_io_oscillatorIncrements_0[11:0]), //i
    .io_increments_1 (oscillatorControl_1_io_oscillatorIncrements_1[11:0]), //i
    .io_increments_2 (oscillatorControl_1_io_oscillatorIncrements_2[11:0]), //i
    .io_increments_3 (oscillatorControl_1_io_oscillatorIncrements_3[11:0]), //i
    .io_oscillator   (oscillatorGroup_1_io_oscillator                    ), //o
    .clk             (clk                                                ), //i
    .rst_n           (rst_n                                              )  //i
  );
  SpiRom spiRom_1 (
    .io_spi_ss           (spiRom_1_io_spi_ss                          ), //o
    .io_spi_sclk         (spiRom_1_io_spi_sclk                        ), //o
    .io_spi_mosi         (spiRom_1_io_spi_mosi                        ), //o
    .io_spi_miso         (io_spi_miso                                 ), //i
    .io_readReq_valid    (oscillatorControl_1_io_readReq_valid        ), //i
    .io_readReq_ready    (spiRom_1_io_readReq_ready                   ), //o
    .io_readReq_payload  (oscillatorControl_1_io_readReq_payload[15:0]), //i
    .io_readResp_valid   (spiRom_1_io_readResp_valid                  ), //o
    .io_readResp_payload (spiRom_1_io_readResp_payload[7:0]           ), //o
    .clk                 (clk                                         ), //i
    .rst_n               (rst_n                                       )  //i
  );
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
    .clk                       (clk                                                ), //i
    .rst_n                     (rst_n                                              )  //i
  );
  assign io_spi_ss = spiRom_1_io_spi_ss;
  assign io_spi_sclk = spiRom_1_io_spi_sclk;
  assign io_spi_mosi = spiRom_1_io_spi_mosi;
  assign io_oscillator = oscillatorGroup_1_io_oscillator;

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
  input  wire          clk,
  input  wire          rst_n
);
  localparam controlFsm_enumDef_BOOT = 3'd0;
  localparam controlFsm_enumDef_fetchCmd = 3'd1;
  localparam controlFsm_enumDef_decodeCmd = 3'd2;
  localparam controlFsm_enumDef_decodeCmd_waitFrameEnd = 3'd3;
  localparam controlFsm_enumDef_setOscillatorRead = 3'd4;
  localparam controlFsm_enumDef_setOscillatorData = 3'd5;

  wire       [13:0]   _zz_counter_valueNext;
  wire       [0:0]    _zz_counter_valueNext_1;
  reg        [15:0]   pc;
  wire                when_Utils_l578;
  reg                 counter_willIncrement;
  wire                counter_willClear;
  reg        [13:0]   counter_valueNext;
  reg        [13:0]   counter_value;
  wire                counter_willOverflowIfInc;
  wire                counter_willOverflow;
  reg        [11:0]   oscillatorControl_0;
  reg        [11:0]   oscillatorControl_1;
  reg        [11:0]   oscillatorControl_2;
  reg        [11:0]   oscillatorControl_3;
  reg        [1:0]    oscillatorSel;
  reg        [3:0]    oscillatorMsb;
  wire                controlFsm_wantExit;
  reg                 controlFsm_wantStart;
  wire                controlFsm_wantKill;
  reg        [2:0]    controlFsm_stateReg;
  reg        [2:0]    controlFsm_stateNext;
  wire       [3:0]    switch_OscillatorControl_l44;
  wire       [3:0]    _zz_oscillatorMsb;
  wire       [3:0]    _zz_1;
  wire       [11:0]   _zz_oscillatorControl_0;
  `ifndef SYNTHESIS
  reg [175:0] controlFsm_stateReg_string;
  reg [175:0] controlFsm_stateNext_string;
  `endif


  assign _zz_counter_valueNext_1 = counter_willIncrement;
  assign _zz_counter_valueNext = {13'd0, _zz_counter_valueNext_1};
  `ifndef SYNTHESIS
  always @(*) begin
    case(controlFsm_stateReg)
      controlFsm_enumDef_BOOT : controlFsm_stateReg_string = "BOOT                  ";
      controlFsm_enumDef_fetchCmd : controlFsm_stateReg_string = "fetchCmd              ";
      controlFsm_enumDef_decodeCmd : controlFsm_stateReg_string = "decodeCmd             ";
      controlFsm_enumDef_decodeCmd_waitFrameEnd : controlFsm_stateReg_string = "decodeCmd_waitFrameEnd";
      controlFsm_enumDef_setOscillatorRead : controlFsm_stateReg_string = "setOscillatorRead     ";
      controlFsm_enumDef_setOscillatorData : controlFsm_stateReg_string = "setOscillatorData     ";
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
      default : controlFsm_stateNext_string = "??????????????????????";
    endcase
  end
  `endif

  assign when_Utils_l578 = 1'b1;
  always @(*) begin
    counter_willIncrement = 1'b0;
    if(when_Utils_l578) begin
      counter_willIncrement = 1'b1;
    end
  end

  assign counter_willClear = 1'b0;
  assign counter_willOverflowIfInc = (counter_value == 14'h3fff);
  assign counter_willOverflow = (counter_willOverflowIfInc && counter_willIncrement);
  always @(*) begin
    counter_valueNext = (counter_value + _zz_counter_valueNext);
    if(counter_willClear) begin
      counter_valueNext = 14'h0;
    end
  end

  assign io_readReq_payload = pc;
  always @(*) begin
    io_readReq_valid = 1'b0;
    case(controlFsm_stateReg)
      controlFsm_enumDef_fetchCmd : begin
        io_readReq_valid = 1'b1;
      end
      controlFsm_enumDef_decodeCmd : begin
      end
      controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
      end
      controlFsm_enumDef_setOscillatorRead : begin
      end
      controlFsm_enumDef_setOscillatorData : begin
      end
      default : begin
      end
    endcase
  end

  assign io_oscillatorIncrements_0 = oscillatorControl_0;
  assign io_oscillatorIncrements_1 = oscillatorControl_1;
  assign io_oscillatorIncrements_2 = oscillatorControl_2;
  assign io_oscillatorIncrements_3 = oscillatorControl_3;
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
          case(switch_OscillatorControl_l44)
            4'b0000 : begin
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
        if(counter_willOverflow) begin
          controlFsm_stateNext = controlFsm_enumDef_fetchCmd;
        end
      end
      controlFsm_enumDef_setOscillatorRead : begin
      end
      controlFsm_enumDef_setOscillatorData : begin
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

  assign switch_OscillatorControl_l44 = io_readResp_payload[7 : 4];
  assign _zz_oscillatorMsb = io_readResp_payload[3 : 0];
  assign _zz_1 = ({3'd0,1'b1} <<< oscillatorSel);
  assign _zz_oscillatorControl_0 = {oscillatorMsb,io_readResp_payload};
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      pc <= 16'h0;
      counter_value <= 14'h0;
      controlFsm_stateReg <= controlFsm_enumDef_BOOT;
    end else begin
      counter_value <= counter_valueNext;
      controlFsm_stateReg <= controlFsm_stateNext;
      case(controlFsm_stateReg)
        controlFsm_enumDef_fetchCmd : begin
          if(io_readReq_ready) begin
            pc <= (pc + 16'h0001);
          end
        end
        controlFsm_enumDef_decodeCmd : begin
        end
        controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
        end
        controlFsm_enumDef_setOscillatorRead : begin
        end
        controlFsm_enumDef_setOscillatorData : begin
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
          case(switch_OscillatorControl_l44)
            4'b1100 : begin
              oscillatorSel <= 2'b00;
              oscillatorMsb <= _zz_oscillatorMsb;
            end
            4'b1101 : begin
              oscillatorSel <= 2'b01;
              oscillatorMsb <= _zz_oscillatorMsb;
            end
            4'b1110 : begin
              oscillatorSel <= 2'b10;
              oscillatorMsb <= _zz_oscillatorMsb;
            end
            4'b1111 : begin
              oscillatorSel <= 2'b11;
              oscillatorMsb <= _zz_oscillatorMsb;
            end
            default : begin
            end
          endcase
        end
      end
      controlFsm_enumDef_decodeCmd_waitFrameEnd : begin
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
      default : begin
      end
    endcase
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
          fsm_stateNext = fsm_enumDef_idle;
        end
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
  output wire          io_oscillator,
  input  wire          clk,
  input  wire          rst_n
);

  wire                oscillator_4_io_oscillator;
  wire                oscillator_5_io_oscillator;
  wire                oscillator_6_io_oscillator;
  wire                oscillator_7_io_oscillator;
  wire       [3:0]    oscillatorOutputs;

  Oscillator oscillator_4 (
    .io_increment  (io_increments_0[11:0]     ), //i
    .io_oscillator (oscillator_4_io_oscillator), //o
    .clk           (clk                       ), //i
    .rst_n         (rst_n                     )  //i
  );
  Oscillator oscillator_5 (
    .io_increment  (io_increments_1[11:0]     ), //i
    .io_oscillator (oscillator_5_io_oscillator), //o
    .clk           (clk                       ), //i
    .rst_n         (rst_n                     )  //i
  );
  Oscillator oscillator_6 (
    .io_increment  (io_increments_2[11:0]     ), //i
    .io_oscillator (oscillator_6_io_oscillator), //o
    .clk           (clk                       ), //i
    .rst_n         (rst_n                     )  //i
  );
  Oscillator oscillator_7 (
    .io_increment  (io_increments_3[11:0]     ), //i
    .io_oscillator (oscillator_7_io_oscillator), //o
    .clk           (clk                       ), //i
    .rst_n         (rst_n                     )  //i
  );
  assign io_oscillator = ((oscillator_4_io_oscillator ^ oscillator_5_io_oscillator) ^ (oscillator_6_io_oscillator ^ oscillator_7_io_oscillator));

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
  localparam fsm_dataSend_fsm_enumDef_BOOT = 5'd0;
  localparam fsm_dataSend_fsm_enumDef_clockB7 = 5'd1;
  localparam fsm_dataSend_fsm_enumDef_driveB7 = 5'd2;
  localparam fsm_dataSend_fsm_enumDef_clockB6 = 5'd3;
  localparam fsm_dataSend_fsm_enumDef_driveB6 = 5'd4;
  localparam fsm_dataSend_fsm_enumDef_clockB5 = 5'd5;
  localparam fsm_dataSend_fsm_enumDef_driveB5 = 5'd6;
  localparam fsm_dataSend_fsm_enumDef_clockB4 = 5'd7;
  localparam fsm_dataSend_fsm_enumDef_driveB4 = 5'd8;
  localparam fsm_dataSend_fsm_enumDef_clockB3 = 5'd9;
  localparam fsm_dataSend_fsm_enumDef_driveB3 = 5'd10;
  localparam fsm_dataSend_fsm_enumDef_clockB2 = 5'd11;
  localparam fsm_dataSend_fsm_enumDef_driveB2 = 5'd12;
  localparam fsm_dataSend_fsm_enumDef_clockB1 = 5'd13;
  localparam fsm_dataSend_fsm_enumDef_driveB1 = 5'd14;
  localparam fsm_dataSend_fsm_enumDef_clockB0 = 5'd15;
  localparam fsm_dataSend_fsm_enumDef_driveB0 = 5'd16;
  localparam fsm_enumDef_1_BOOT = 3'd0;
  localparam fsm_enumDef_1_idle = 3'd1;
  localparam fsm_enumDef_1_txBegin = 3'd2;
  localparam fsm_enumDef_1_dataSend = 3'd3;
  localparam fsm_enumDef_1_txEnd = 3'd4;

  wire                sclk_active;
  wire       [0:0]    ss_active;
  reg        [7:0]    dataOut;
  reg        [7:0]    dataIn;
  reg        [0:0]    spi_ss;
  reg                 spi_sclk;
  reg                 spi_mosi;
  reg                 spi_miso;
  wire                fsm_wantExit;
  reg                 fsm_wantStart;
  wire                fsm_wantKill;
  reg                 fsm_dataSend_fsm_wantExit;
  reg                 fsm_dataSend_fsm_wantStart;
  wire                fsm_dataSend_fsm_wantKill;
  reg        [4:0]    fsm_dataSend_fsm_stateReg;
  reg        [4:0]    fsm_dataSend_fsm_stateNext;
  reg        [2:0]    fsm_stateReg;
  reg        [2:0]    fsm_stateNext;
  wire                when_StateMachine_l253;
  `ifndef SYNTHESIS
  reg [55:0] fsm_dataSend_fsm_stateReg_string;
  reg [55:0] fsm_dataSend_fsm_stateNext_string;
  reg [63:0] fsm_stateReg_string;
  reg [63:0] fsm_stateNext_string;
  `endif


  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_dataSend_fsm_stateReg)
      fsm_dataSend_fsm_enumDef_BOOT : fsm_dataSend_fsm_stateReg_string = "BOOT   ";
      fsm_dataSend_fsm_enumDef_clockB7 : fsm_dataSend_fsm_stateReg_string = "clockB7";
      fsm_dataSend_fsm_enumDef_driveB7 : fsm_dataSend_fsm_stateReg_string = "driveB7";
      fsm_dataSend_fsm_enumDef_clockB6 : fsm_dataSend_fsm_stateReg_string = "clockB6";
      fsm_dataSend_fsm_enumDef_driveB6 : fsm_dataSend_fsm_stateReg_string = "driveB6";
      fsm_dataSend_fsm_enumDef_clockB5 : fsm_dataSend_fsm_stateReg_string = "clockB5";
      fsm_dataSend_fsm_enumDef_driveB5 : fsm_dataSend_fsm_stateReg_string = "driveB5";
      fsm_dataSend_fsm_enumDef_clockB4 : fsm_dataSend_fsm_stateReg_string = "clockB4";
      fsm_dataSend_fsm_enumDef_driveB4 : fsm_dataSend_fsm_stateReg_string = "driveB4";
      fsm_dataSend_fsm_enumDef_clockB3 : fsm_dataSend_fsm_stateReg_string = "clockB3";
      fsm_dataSend_fsm_enumDef_driveB3 : fsm_dataSend_fsm_stateReg_string = "driveB3";
      fsm_dataSend_fsm_enumDef_clockB2 : fsm_dataSend_fsm_stateReg_string = "clockB2";
      fsm_dataSend_fsm_enumDef_driveB2 : fsm_dataSend_fsm_stateReg_string = "driveB2";
      fsm_dataSend_fsm_enumDef_clockB1 : fsm_dataSend_fsm_stateReg_string = "clockB1";
      fsm_dataSend_fsm_enumDef_driveB1 : fsm_dataSend_fsm_stateReg_string = "driveB1";
      fsm_dataSend_fsm_enumDef_clockB0 : fsm_dataSend_fsm_stateReg_string = "clockB0";
      fsm_dataSend_fsm_enumDef_driveB0 : fsm_dataSend_fsm_stateReg_string = "driveB0";
      default : fsm_dataSend_fsm_stateReg_string = "???????";
    endcase
  end
  always @(*) begin
    case(fsm_dataSend_fsm_stateNext)
      fsm_dataSend_fsm_enumDef_BOOT : fsm_dataSend_fsm_stateNext_string = "BOOT   ";
      fsm_dataSend_fsm_enumDef_clockB7 : fsm_dataSend_fsm_stateNext_string = "clockB7";
      fsm_dataSend_fsm_enumDef_driveB7 : fsm_dataSend_fsm_stateNext_string = "driveB7";
      fsm_dataSend_fsm_enumDef_clockB6 : fsm_dataSend_fsm_stateNext_string = "clockB6";
      fsm_dataSend_fsm_enumDef_driveB6 : fsm_dataSend_fsm_stateNext_string = "driveB6";
      fsm_dataSend_fsm_enumDef_clockB5 : fsm_dataSend_fsm_stateNext_string = "clockB5";
      fsm_dataSend_fsm_enumDef_driveB5 : fsm_dataSend_fsm_stateNext_string = "driveB5";
      fsm_dataSend_fsm_enumDef_clockB4 : fsm_dataSend_fsm_stateNext_string = "clockB4";
      fsm_dataSend_fsm_enumDef_driveB4 : fsm_dataSend_fsm_stateNext_string = "driveB4";
      fsm_dataSend_fsm_enumDef_clockB3 : fsm_dataSend_fsm_stateNext_string = "clockB3";
      fsm_dataSend_fsm_enumDef_driveB3 : fsm_dataSend_fsm_stateNext_string = "driveB3";
      fsm_dataSend_fsm_enumDef_clockB2 : fsm_dataSend_fsm_stateNext_string = "clockB2";
      fsm_dataSend_fsm_enumDef_driveB2 : fsm_dataSend_fsm_stateNext_string = "driveB2";
      fsm_dataSend_fsm_enumDef_clockB1 : fsm_dataSend_fsm_stateNext_string = "clockB1";
      fsm_dataSend_fsm_enumDef_driveB1 : fsm_dataSend_fsm_stateNext_string = "driveB1";
      fsm_dataSend_fsm_enumDef_clockB0 : fsm_dataSend_fsm_stateNext_string = "clockB0";
      fsm_dataSend_fsm_enumDef_driveB0 : fsm_dataSend_fsm_stateNext_string = "driveB0";
      default : fsm_dataSend_fsm_stateNext_string = "???????";
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
        io_cmd_ready = 1'b1;
      end
      fsm_enumDef_1_txBegin : begin
      end
      fsm_enumDef_1_dataSend : begin
      end
      fsm_enumDef_1_txEnd : begin
        if(io_cmd_valid) begin
          io_cmd_ready = 1'b1;
        end
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
        if(fsm_dataSend_fsm_wantExit) begin
          io_resp_valid = 1'b1;
        end
      end
      fsm_enumDef_1_txEnd : begin
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
      fsm_dataSend_fsm_enumDef_clockB7 : begin
        fsm_dataSend_fsm_wantExit = 1'b1;
      end
      fsm_dataSend_fsm_enumDef_driveB7 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB6 : begin
      end
      fsm_dataSend_fsm_enumDef_driveB6 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB5 : begin
      end
      fsm_dataSend_fsm_enumDef_driveB5 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB4 : begin
      end
      fsm_dataSend_fsm_enumDef_driveB4 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB3 : begin
      end
      fsm_dataSend_fsm_enumDef_driveB3 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB2 : begin
      end
      fsm_dataSend_fsm_enumDef_driveB2 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB1 : begin
      end
      fsm_dataSend_fsm_enumDef_driveB1 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB0 : begin
      end
      fsm_dataSend_fsm_enumDef_driveB0 : begin
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
      fsm_dataSend_fsm_enumDef_clockB7 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_BOOT;
      end
      fsm_dataSend_fsm_enumDef_driveB7 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB7;
      end
      fsm_dataSend_fsm_enumDef_clockB6 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB7;
      end
      fsm_dataSend_fsm_enumDef_driveB6 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB6;
      end
      fsm_dataSend_fsm_enumDef_clockB5 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB6;
      end
      fsm_dataSend_fsm_enumDef_driveB5 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB5;
      end
      fsm_dataSend_fsm_enumDef_clockB4 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB5;
      end
      fsm_dataSend_fsm_enumDef_driveB4 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB4;
      end
      fsm_dataSend_fsm_enumDef_clockB3 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB4;
      end
      fsm_dataSend_fsm_enumDef_driveB3 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB3;
      end
      fsm_dataSend_fsm_enumDef_clockB2 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB3;
      end
      fsm_dataSend_fsm_enumDef_driveB2 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB2;
      end
      fsm_dataSend_fsm_enumDef_clockB1 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB2;
      end
      fsm_dataSend_fsm_enumDef_driveB1 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB1;
      end
      fsm_dataSend_fsm_enumDef_clockB0 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB1;
      end
      fsm_dataSend_fsm_enumDef_driveB0 : begin
        fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_clockB0;
      end
      default : begin
      end
    endcase
    if(fsm_dataSend_fsm_wantStart) begin
      fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_driveB0;
    end
    if(fsm_dataSend_fsm_wantKill) begin
      fsm_dataSend_fsm_stateNext = fsm_dataSend_fsm_enumDef_BOOT;
    end
  end

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
        fsm_dataSend_fsm_enumDef_clockB7 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB7 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
        end
        fsm_dataSend_fsm_enumDef_clockB6 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB6 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
        end
        fsm_dataSend_fsm_enumDef_clockB5 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB5 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
        end
        fsm_dataSend_fsm_enumDef_clockB4 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB4 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
        end
        fsm_dataSend_fsm_enumDef_clockB3 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB3 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
        end
        fsm_dataSend_fsm_enumDef_clockB2 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB2 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
        end
        fsm_dataSend_fsm_enumDef_clockB1 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB1 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
        end
        fsm_dataSend_fsm_enumDef_clockB0 : begin
          spi_sclk <= sclk_active;
        end
        fsm_dataSend_fsm_enumDef_driveB0 : begin
          spi_sclk <= (! sclk_active);
          spi_mosi <= dataOut[7];
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
    case(fsm_dataSend_fsm_stateReg)
      fsm_dataSend_fsm_enumDef_clockB7 : begin
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB7 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB6 : begin
        dataOut <= (dataOut <<< 1);
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB6 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB5 : begin
        dataOut <= (dataOut <<< 1);
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB5 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB4 : begin
        dataOut <= (dataOut <<< 1);
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB4 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB3 : begin
        dataOut <= (dataOut <<< 1);
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB3 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB2 : begin
        dataOut <= (dataOut <<< 1);
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB2 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB1 : begin
        dataOut <= (dataOut <<< 1);
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB1 : begin
      end
      fsm_dataSend_fsm_enumDef_clockB0 : begin
        dataOut <= (dataOut <<< 1);
        dataIn <= {dataIn[6 : 0],spi_miso};
      end
      fsm_dataSend_fsm_enumDef_driveB0 : begin
      end
      default : begin
      end
    endcase
    case(fsm_stateReg)
      fsm_enumDef_1_idle : begin
        if(io_cmd_valid) begin
          dataOut <= io_cmd_payload;
        end
      end
      fsm_enumDef_1_txBegin : begin
      end
      fsm_enumDef_1_dataSend : begin
      end
      fsm_enumDef_1_txEnd : begin
        if(io_cmd_valid) begin
          dataOut <= io_cmd_payload;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

//Oscillator_3 replaced by Oscillator

//Oscillator_2 replaced by Oscillator

//Oscillator_1 replaced by Oscillator

module Oscillator (
  input  wire [11:0]   io_increment,
  output wire          io_oscillator,
  input  wire          clk,
  input  wire          rst_n
);

  reg        [11:0]   counter;

  assign io_oscillator = counter[11];
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      counter <= 12'h0;
    end else begin
      counter <= (counter + io_increment);
    end
  end


endmodule