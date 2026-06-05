// Generator : SpinalHDL dev    git head : 84ef7b5b6278854e0e80738536f72c64fa14b730
// Component : AxiLite4Plic
// Git hash  : 84ef7b5b6278854e0e80738536f72c64fa14b730

`timescale 1ns/1ps

module AxiLite4Plic (
  input  wire          io_bus_aw_valid,
  output wire          io_bus_aw_ready,
  input  wire [21:0]   io_bus_aw_payload_addr,
  input  wire [2:0]    io_bus_aw_payload_prot,
  input  wire          io_bus_w_valid,
  output wire          io_bus_w_ready,
  input  wire [31:0]   io_bus_w_payload_data,
  input  wire [3:0]    io_bus_w_payload_strb,
  output wire          io_bus_b_valid,
  input  wire          io_bus_b_ready,
  output wire [1:0]    io_bus_b_payload_resp,
  input  wire          io_bus_ar_valid,
  output wire          io_bus_ar_ready,
  input  wire [21:0]   io_bus_ar_payload_addr,
  input  wire [2:0]    io_bus_ar_payload_prot,
  output wire          io_bus_r_valid,
  input  wire          io_bus_r_ready,
  output wire [31:0]   io_bus_r_payload_data,
  output wire [1:0]    io_bus_r_payload_resp,
  input  wire [31:0]   io_sources,
  output wire [1:0]    io_targets,
  input  wire          clk,
  input  wire          reset
);

  wire       [5:0]    _zz_targets_0_bestRequest_id_89;
  wire       [5:0]    _zz_targets_0_bestRequest_id_90;
  wire       [5:0]    _zz_targets_0_bestRequest_id_91;
  wire       [5:0]    _zz_targets_0_bestRequest_id_92;
  wire       [5:0]    _zz_targets_0_bestRequest_id_93;
  wire       [5:0]    _zz_targets_0_bestRequest_id_94;
  wire       [5:0]    _zz_targets_0_bestRequest_id_95;
  wire       [5:0]    _zz_targets_0_bestRequest_id_96;
  wire       [5:0]    _zz_targets_0_bestRequest_id_97;
  wire       [5:0]    _zz_targets_0_bestRequest_id_98;
  wire       [5:0]    _zz_targets_0_bestRequest_id_99;
  wire       [5:0]    _zz_targets_0_bestRequest_id_100;
  wire       [5:0]    _zz_targets_0_bestRequest_id_101;
  wire       [5:0]    _zz_targets_0_bestRequest_id_102;
  wire       [5:0]    _zz_targets_0_bestRequest_id_103;
  wire       [5:0]    _zz_targets_0_bestRequest_id_104;
  wire       [5:0]    _zz_targets_1_bestRequest_id_89;
  wire       [5:0]    _zz_targets_1_bestRequest_id_90;
  wire       [5:0]    _zz_targets_1_bestRequest_id_91;
  wire       [5:0]    _zz_targets_1_bestRequest_id_92;
  wire       [5:0]    _zz_targets_1_bestRequest_id_93;
  wire       [5:0]    _zz_targets_1_bestRequest_id_94;
  wire       [5:0]    _zz_targets_1_bestRequest_id_95;
  wire       [5:0]    _zz_targets_1_bestRequest_id_96;
  wire       [5:0]    _zz_targets_1_bestRequest_id_97;
  wire       [5:0]    _zz_targets_1_bestRequest_id_98;
  wire       [5:0]    _zz_targets_1_bestRequest_id_99;
  wire       [5:0]    _zz_targets_1_bestRequest_id_100;
  wire       [5:0]    _zz_targets_1_bestRequest_id_101;
  wire       [5:0]    _zz_targets_1_bestRequest_id_102;
  wire       [5:0]    _zz_targets_1_bestRequest_id_103;
  wire       [5:0]    _zz_targets_1_bestRequest_id_104;
  wire                _zz_gateways_0_ip;
  wire                _zz_gateways_1_ip;
  wire                _zz_gateways_2_ip;
  wire                _zz_gateways_3_ip;
  wire                _zz_gateways_4_ip;
  wire                _zz_gateways_5_ip;
  wire                _zz_gateways_6_ip;
  wire                _zz_gateways_7_ip;
  wire                _zz_gateways_8_ip;
  wire                _zz_gateways_9_ip;
  wire                _zz_gateways_10_ip;
  wire                _zz_gateways_11_ip;
  wire                _zz_gateways_12_ip;
  wire                _zz_gateways_13_ip;
  wire                _zz_gateways_14_ip;
  wire                _zz_gateways_15_ip;
  wire                _zz_gateways_16_ip;
  wire                _zz_gateways_17_ip;
  wire                _zz_gateways_18_ip;
  wire                _zz_gateways_19_ip;
  wire                _zz_gateways_20_ip;
  wire                _zz_gateways_21_ip;
  wire                _zz_gateways_22_ip;
  wire                _zz_gateways_23_ip;
  wire                _zz_gateways_24_ip;
  wire                _zz_gateways_25_ip;
  wire                _zz_gateways_26_ip;
  wire                _zz_gateways_27_ip;
  wire                _zz_gateways_28_ip;
  wire                _zz_gateways_29_ip;
  wire                _zz_gateways_30_ip;
  wire                _zz_gateways_31_ip;
  wire       [1:0]    gateways_0_priority;
  reg                 gateways_0_ip;
  reg                 gateways_0_waitCompletion;
  wire                when_PlicGateway_l21;
  wire       [1:0]    gateways_1_priority;
  reg                 gateways_1_ip;
  reg                 gateways_1_waitCompletion;
  wire                when_PlicGateway_l21_1;
  wire       [1:0]    gateways_2_priority;
  reg                 gateways_2_ip;
  reg                 gateways_2_waitCompletion;
  wire                when_PlicGateway_l21_2;
  wire       [1:0]    gateways_3_priority;
  reg                 gateways_3_ip;
  reg                 gateways_3_waitCompletion;
  wire                when_PlicGateway_l21_3;
  wire       [1:0]    gateways_4_priority;
  reg                 gateways_4_ip;
  reg                 gateways_4_waitCompletion;
  wire                when_PlicGateway_l21_4;
  wire       [1:0]    gateways_5_priority;
  reg                 gateways_5_ip;
  reg                 gateways_5_waitCompletion;
  wire                when_PlicGateway_l21_5;
  wire       [1:0]    gateways_6_priority;
  reg                 gateways_6_ip;
  reg                 gateways_6_waitCompletion;
  wire                when_PlicGateway_l21_6;
  wire       [1:0]    gateways_7_priority;
  reg                 gateways_7_ip;
  reg                 gateways_7_waitCompletion;
  wire                when_PlicGateway_l21_7;
  wire       [1:0]    gateways_8_priority;
  reg                 gateways_8_ip;
  reg                 gateways_8_waitCompletion;
  wire                when_PlicGateway_l21_8;
  wire       [1:0]    gateways_9_priority;
  reg                 gateways_9_ip;
  reg                 gateways_9_waitCompletion;
  wire                when_PlicGateway_l21_9;
  wire       [1:0]    gateways_10_priority;
  reg                 gateways_10_ip;
  reg                 gateways_10_waitCompletion;
  wire                when_PlicGateway_l21_10;
  wire       [1:0]    gateways_11_priority;
  reg                 gateways_11_ip;
  reg                 gateways_11_waitCompletion;
  wire                when_PlicGateway_l21_11;
  wire       [1:0]    gateways_12_priority;
  reg                 gateways_12_ip;
  reg                 gateways_12_waitCompletion;
  wire                when_PlicGateway_l21_12;
  wire       [1:0]    gateways_13_priority;
  reg                 gateways_13_ip;
  reg                 gateways_13_waitCompletion;
  wire                when_PlicGateway_l21_13;
  wire       [1:0]    gateways_14_priority;
  reg                 gateways_14_ip;
  reg                 gateways_14_waitCompletion;
  wire                when_PlicGateway_l21_14;
  wire       [1:0]    gateways_15_priority;
  reg                 gateways_15_ip;
  reg                 gateways_15_waitCompletion;
  wire                when_PlicGateway_l21_15;
  wire       [1:0]    gateways_16_priority;
  reg                 gateways_16_ip;
  reg                 gateways_16_waitCompletion;
  wire                when_PlicGateway_l21_16;
  wire       [1:0]    gateways_17_priority;
  reg                 gateways_17_ip;
  reg                 gateways_17_waitCompletion;
  wire                when_PlicGateway_l21_17;
  wire       [1:0]    gateways_18_priority;
  reg                 gateways_18_ip;
  reg                 gateways_18_waitCompletion;
  wire                when_PlicGateway_l21_18;
  wire       [1:0]    gateways_19_priority;
  reg                 gateways_19_ip;
  reg                 gateways_19_waitCompletion;
  wire                when_PlicGateway_l21_19;
  wire       [1:0]    gateways_20_priority;
  reg                 gateways_20_ip;
  reg                 gateways_20_waitCompletion;
  wire                when_PlicGateway_l21_20;
  wire       [1:0]    gateways_21_priority;
  reg                 gateways_21_ip;
  reg                 gateways_21_waitCompletion;
  wire                when_PlicGateway_l21_21;
  wire       [1:0]    gateways_22_priority;
  reg                 gateways_22_ip;
  reg                 gateways_22_waitCompletion;
  wire                when_PlicGateway_l21_22;
  wire       [1:0]    gateways_23_priority;
  reg                 gateways_23_ip;
  reg                 gateways_23_waitCompletion;
  wire                when_PlicGateway_l21_23;
  wire       [1:0]    gateways_24_priority;
  reg                 gateways_24_ip;
  reg                 gateways_24_waitCompletion;
  wire                when_PlicGateway_l21_24;
  wire       [1:0]    gateways_25_priority;
  reg                 gateways_25_ip;
  reg                 gateways_25_waitCompletion;
  wire                when_PlicGateway_l21_25;
  wire       [1:0]    gateways_26_priority;
  reg                 gateways_26_ip;
  reg                 gateways_26_waitCompletion;
  wire                when_PlicGateway_l21_26;
  wire       [1:0]    gateways_27_priority;
  reg                 gateways_27_ip;
  reg                 gateways_27_waitCompletion;
  wire                when_PlicGateway_l21_27;
  wire       [1:0]    gateways_28_priority;
  reg                 gateways_28_ip;
  reg                 gateways_28_waitCompletion;
  wire                when_PlicGateway_l21_28;
  wire       [1:0]    gateways_29_priority;
  reg                 gateways_29_ip;
  reg                 gateways_29_waitCompletion;
  wire                when_PlicGateway_l21_29;
  wire       [1:0]    gateways_30_priority;
  reg                 gateways_30_ip;
  reg                 gateways_30_waitCompletion;
  wire                when_PlicGateway_l21_30;
  wire       [1:0]    gateways_31_priority;
  reg                 gateways_31_ip;
  reg                 gateways_31_waitCompletion;
  wire                when_PlicGateway_l21_31;
  wire                targets_0_ie_0;
  wire                targets_0_ie_1;
  wire                targets_0_ie_2;
  wire                targets_0_ie_3;
  wire                targets_0_ie_4;
  wire                targets_0_ie_5;
  wire                targets_0_ie_6;
  wire                targets_0_ie_7;
  wire                targets_0_ie_8;
  wire                targets_0_ie_9;
  wire                targets_0_ie_10;
  wire                targets_0_ie_11;
  wire                targets_0_ie_12;
  wire                targets_0_ie_13;
  wire                targets_0_ie_14;
  wire                targets_0_ie_15;
  wire                targets_0_ie_16;
  wire                targets_0_ie_17;
  wire                targets_0_ie_18;
  wire                targets_0_ie_19;
  wire                targets_0_ie_20;
  wire                targets_0_ie_21;
  wire                targets_0_ie_22;
  wire                targets_0_ie_23;
  wire                targets_0_ie_24;
  wire                targets_0_ie_25;
  wire                targets_0_ie_26;
  wire                targets_0_ie_27;
  wire                targets_0_ie_28;
  wire                targets_0_ie_29;
  wire                targets_0_ie_30;
  wire                targets_0_ie_31;
  wire       [1:0]    targets_0_threshold;
  wire       [1:0]    targets_0_requests_0_priority;
  wire       [5:0]    targets_0_requests_0_id;
  wire                targets_0_requests_0_valid;
  wire       [1:0]    targets_0_requests_1_priority;
  wire       [5:0]    targets_0_requests_1_id;
  wire                targets_0_requests_1_valid;
  wire       [1:0]    targets_0_requests_2_priority;
  wire       [5:0]    targets_0_requests_2_id;
  wire                targets_0_requests_2_valid;
  wire       [1:0]    targets_0_requests_3_priority;
  wire       [5:0]    targets_0_requests_3_id;
  wire                targets_0_requests_3_valid;
  wire       [1:0]    targets_0_requests_4_priority;
  wire       [5:0]    targets_0_requests_4_id;
  wire                targets_0_requests_4_valid;
  wire       [1:0]    targets_0_requests_5_priority;
  wire       [5:0]    targets_0_requests_5_id;
  wire                targets_0_requests_5_valid;
  wire       [1:0]    targets_0_requests_6_priority;
  wire       [5:0]    targets_0_requests_6_id;
  wire                targets_0_requests_6_valid;
  wire       [1:0]    targets_0_requests_7_priority;
  wire       [5:0]    targets_0_requests_7_id;
  wire                targets_0_requests_7_valid;
  wire       [1:0]    targets_0_requests_8_priority;
  wire       [5:0]    targets_0_requests_8_id;
  wire                targets_0_requests_8_valid;
  wire       [1:0]    targets_0_requests_9_priority;
  wire       [5:0]    targets_0_requests_9_id;
  wire                targets_0_requests_9_valid;
  wire       [1:0]    targets_0_requests_10_priority;
  wire       [5:0]    targets_0_requests_10_id;
  wire                targets_0_requests_10_valid;
  wire       [1:0]    targets_0_requests_11_priority;
  wire       [5:0]    targets_0_requests_11_id;
  wire                targets_0_requests_11_valid;
  wire       [1:0]    targets_0_requests_12_priority;
  wire       [5:0]    targets_0_requests_12_id;
  wire                targets_0_requests_12_valid;
  wire       [1:0]    targets_0_requests_13_priority;
  wire       [5:0]    targets_0_requests_13_id;
  wire                targets_0_requests_13_valid;
  wire       [1:0]    targets_0_requests_14_priority;
  wire       [5:0]    targets_0_requests_14_id;
  wire                targets_0_requests_14_valid;
  wire       [1:0]    targets_0_requests_15_priority;
  wire       [5:0]    targets_0_requests_15_id;
  wire                targets_0_requests_15_valid;
  wire       [1:0]    targets_0_requests_16_priority;
  wire       [5:0]    targets_0_requests_16_id;
  wire                targets_0_requests_16_valid;
  wire       [1:0]    targets_0_requests_17_priority;
  wire       [5:0]    targets_0_requests_17_id;
  wire                targets_0_requests_17_valid;
  wire       [1:0]    targets_0_requests_18_priority;
  wire       [5:0]    targets_0_requests_18_id;
  wire                targets_0_requests_18_valid;
  wire       [1:0]    targets_0_requests_19_priority;
  wire       [5:0]    targets_0_requests_19_id;
  wire                targets_0_requests_19_valid;
  wire       [1:0]    targets_0_requests_20_priority;
  wire       [5:0]    targets_0_requests_20_id;
  wire                targets_0_requests_20_valid;
  wire       [1:0]    targets_0_requests_21_priority;
  wire       [5:0]    targets_0_requests_21_id;
  wire                targets_0_requests_21_valid;
  wire       [1:0]    targets_0_requests_22_priority;
  wire       [5:0]    targets_0_requests_22_id;
  wire                targets_0_requests_22_valid;
  wire       [1:0]    targets_0_requests_23_priority;
  wire       [5:0]    targets_0_requests_23_id;
  wire                targets_0_requests_23_valid;
  wire       [1:0]    targets_0_requests_24_priority;
  wire       [5:0]    targets_0_requests_24_id;
  wire                targets_0_requests_24_valid;
  wire       [1:0]    targets_0_requests_25_priority;
  wire       [5:0]    targets_0_requests_25_id;
  wire                targets_0_requests_25_valid;
  wire       [1:0]    targets_0_requests_26_priority;
  wire       [5:0]    targets_0_requests_26_id;
  wire                targets_0_requests_26_valid;
  wire       [1:0]    targets_0_requests_27_priority;
  wire       [5:0]    targets_0_requests_27_id;
  wire                targets_0_requests_27_valid;
  wire       [1:0]    targets_0_requests_28_priority;
  wire       [5:0]    targets_0_requests_28_id;
  wire                targets_0_requests_28_valid;
  wire       [1:0]    targets_0_requests_29_priority;
  wire       [5:0]    targets_0_requests_29_id;
  wire                targets_0_requests_29_valid;
  wire       [1:0]    targets_0_requests_30_priority;
  wire       [5:0]    targets_0_requests_30_id;
  wire                targets_0_requests_30_valid;
  wire       [1:0]    targets_0_requests_31_priority;
  wire       [5:0]    targets_0_requests_31_id;
  wire                targets_0_requests_31_valid;
  wire       [1:0]    targets_0_requests_32_priority;
  wire       [5:0]    targets_0_requests_32_id;
  wire                targets_0_requests_32_valid;
  wire                _zz_targets_0_bestRequest_id;
  wire       [1:0]    _zz_targets_0_bestRequest_id_1;
  wire                _zz_targets_0_bestRequest_id_2;
  wire                _zz_targets_0_bestRequest_id_3;
  wire       [1:0]    _zz_targets_0_bestRequest_id_4;
  wire                _zz_targets_0_bestRequest_id_5;
  wire                _zz_targets_0_bestRequest_id_6;
  wire       [1:0]    _zz_targets_0_bestRequest_id_7;
  wire                _zz_targets_0_bestRequest_id_8;
  wire                _zz_targets_0_bestRequest_id_9;
  wire       [1:0]    _zz_targets_0_bestRequest_id_10;
  wire                _zz_targets_0_bestRequest_id_11;
  wire                _zz_targets_0_bestRequest_id_12;
  wire       [1:0]    _zz_targets_0_bestRequest_id_13;
  wire                _zz_targets_0_bestRequest_id_14;
  wire                _zz_targets_0_bestRequest_id_15;
  wire       [1:0]    _zz_targets_0_bestRequest_id_16;
  wire                _zz_targets_0_bestRequest_id_17;
  wire                _zz_targets_0_bestRequest_id_18;
  wire       [1:0]    _zz_targets_0_bestRequest_id_19;
  wire                _zz_targets_0_bestRequest_id_20;
  wire                _zz_targets_0_bestRequest_id_21;
  wire       [1:0]    _zz_targets_0_bestRequest_id_22;
  wire                _zz_targets_0_bestRequest_id_23;
  wire                _zz_targets_0_bestRequest_id_24;
  wire       [1:0]    _zz_targets_0_bestRequest_id_25;
  wire                _zz_targets_0_bestRequest_id_26;
  wire                _zz_targets_0_bestRequest_id_27;
  wire       [1:0]    _zz_targets_0_bestRequest_id_28;
  wire                _zz_targets_0_bestRequest_id_29;
  wire                _zz_targets_0_bestRequest_id_30;
  wire       [1:0]    _zz_targets_0_bestRequest_id_31;
  wire                _zz_targets_0_bestRequest_id_32;
  wire                _zz_targets_0_bestRequest_id_33;
  wire       [1:0]    _zz_targets_0_bestRequest_id_34;
  wire                _zz_targets_0_bestRequest_id_35;
  wire                _zz_targets_0_bestRequest_id_36;
  wire       [1:0]    _zz_targets_0_bestRequest_id_37;
  wire                _zz_targets_0_bestRequest_id_38;
  wire                _zz_targets_0_bestRequest_id_39;
  wire       [1:0]    _zz_targets_0_bestRequest_id_40;
  wire                _zz_targets_0_bestRequest_id_41;
  wire                _zz_targets_0_bestRequest_id_42;
  wire       [1:0]    _zz_targets_0_bestRequest_id_43;
  wire                _zz_targets_0_bestRequest_id_44;
  wire                _zz_targets_0_bestRequest_id_45;
  wire       [1:0]    _zz_targets_0_bestRequest_id_46;
  wire                _zz_targets_0_bestRequest_id_47;
  wire                _zz_targets_0_bestRequest_id_48;
  wire       [1:0]    _zz_targets_0_bestRequest_id_49;
  wire                _zz_targets_0_bestRequest_id_50;
  wire                _zz_targets_0_bestRequest_id_51;
  wire       [1:0]    _zz_targets_0_bestRequest_id_52;
  wire                _zz_targets_0_bestRequest_id_53;
  wire                _zz_targets_0_bestRequest_id_54;
  wire       [1:0]    _zz_targets_0_bestRequest_id_55;
  wire                _zz_targets_0_bestRequest_id_56;
  wire                _zz_targets_0_bestRequest_id_57;
  wire       [1:0]    _zz_targets_0_bestRequest_id_58;
  wire                _zz_targets_0_bestRequest_id_59;
  wire                _zz_targets_0_bestRequest_id_60;
  wire       [1:0]    _zz_targets_0_bestRequest_id_61;
  wire                _zz_targets_0_bestRequest_id_62;
  wire                _zz_targets_0_bestRequest_id_63;
  wire       [1:0]    _zz_targets_0_bestRequest_id_64;
  wire                _zz_targets_0_bestRequest_id_65;
  wire                _zz_targets_0_bestRequest_id_66;
  wire       [1:0]    _zz_targets_0_bestRequest_id_67;
  wire                _zz_targets_0_bestRequest_id_68;
  wire                _zz_targets_0_bestRequest_id_69;
  wire       [1:0]    _zz_targets_0_bestRequest_id_70;
  wire                _zz_targets_0_bestRequest_id_71;
  wire                _zz_targets_0_bestRequest_id_72;
  wire       [1:0]    _zz_targets_0_bestRequest_id_73;
  wire                _zz_targets_0_bestRequest_id_74;
  wire                _zz_targets_0_bestRequest_id_75;
  wire       [1:0]    _zz_targets_0_bestRequest_id_76;
  wire                _zz_targets_0_bestRequest_id_77;
  wire                _zz_targets_0_bestRequest_id_78;
  wire       [1:0]    _zz_targets_0_bestRequest_id_79;
  wire                _zz_targets_0_bestRequest_id_80;
  wire                _zz_targets_0_bestRequest_id_81;
  wire       [1:0]    _zz_targets_0_bestRequest_id_82;
  wire                _zz_targets_0_bestRequest_id_83;
  wire                _zz_targets_0_bestRequest_id_84;
  wire       [1:0]    _zz_targets_0_bestRequest_priority;
  wire                _zz_targets_0_bestRequest_id_85;
  wire                _zz_targets_0_bestRequest_id_86;
  wire       [1:0]    _zz_targets_0_bestRequest_priority_1;
  wire                _zz_targets_0_bestRequest_id_87;
  wire                _zz_targets_0_bestRequest_id_88;
  wire       [1:0]    _zz_targets_0_bestRequest_priority_2;
  wire                _zz_targets_0_bestRequest_valid;
  wire                _zz_targets_0_bestRequest_priority_3;
  reg        [1:0]    targets_0_bestRequest_priority;
  reg        [5:0]    targets_0_bestRequest_id;
  reg                 targets_0_bestRequest_valid;
  wire                targets_0_iep;
  wire       [5:0]    targets_0_claim;
  wire                targets_1_ie_0;
  wire                targets_1_ie_1;
  wire                targets_1_ie_2;
  wire                targets_1_ie_3;
  wire                targets_1_ie_4;
  wire                targets_1_ie_5;
  wire                targets_1_ie_6;
  wire                targets_1_ie_7;
  wire                targets_1_ie_8;
  wire                targets_1_ie_9;
  wire                targets_1_ie_10;
  wire                targets_1_ie_11;
  wire                targets_1_ie_12;
  wire                targets_1_ie_13;
  wire                targets_1_ie_14;
  wire                targets_1_ie_15;
  wire                targets_1_ie_16;
  wire                targets_1_ie_17;
  wire                targets_1_ie_18;
  wire                targets_1_ie_19;
  wire                targets_1_ie_20;
  wire                targets_1_ie_21;
  wire                targets_1_ie_22;
  wire                targets_1_ie_23;
  wire                targets_1_ie_24;
  wire                targets_1_ie_25;
  wire                targets_1_ie_26;
  wire                targets_1_ie_27;
  wire                targets_1_ie_28;
  wire                targets_1_ie_29;
  wire                targets_1_ie_30;
  wire                targets_1_ie_31;
  wire       [1:0]    targets_1_threshold;
  wire       [1:0]    targets_1_requests_0_priority;
  wire       [5:0]    targets_1_requests_0_id;
  wire                targets_1_requests_0_valid;
  wire       [1:0]    targets_1_requests_1_priority;
  wire       [5:0]    targets_1_requests_1_id;
  wire                targets_1_requests_1_valid;
  wire       [1:0]    targets_1_requests_2_priority;
  wire       [5:0]    targets_1_requests_2_id;
  wire                targets_1_requests_2_valid;
  wire       [1:0]    targets_1_requests_3_priority;
  wire       [5:0]    targets_1_requests_3_id;
  wire                targets_1_requests_3_valid;
  wire       [1:0]    targets_1_requests_4_priority;
  wire       [5:0]    targets_1_requests_4_id;
  wire                targets_1_requests_4_valid;
  wire       [1:0]    targets_1_requests_5_priority;
  wire       [5:0]    targets_1_requests_5_id;
  wire                targets_1_requests_5_valid;
  wire       [1:0]    targets_1_requests_6_priority;
  wire       [5:0]    targets_1_requests_6_id;
  wire                targets_1_requests_6_valid;
  wire       [1:0]    targets_1_requests_7_priority;
  wire       [5:0]    targets_1_requests_7_id;
  wire                targets_1_requests_7_valid;
  wire       [1:0]    targets_1_requests_8_priority;
  wire       [5:0]    targets_1_requests_8_id;
  wire                targets_1_requests_8_valid;
  wire       [1:0]    targets_1_requests_9_priority;
  wire       [5:0]    targets_1_requests_9_id;
  wire                targets_1_requests_9_valid;
  wire       [1:0]    targets_1_requests_10_priority;
  wire       [5:0]    targets_1_requests_10_id;
  wire                targets_1_requests_10_valid;
  wire       [1:0]    targets_1_requests_11_priority;
  wire       [5:0]    targets_1_requests_11_id;
  wire                targets_1_requests_11_valid;
  wire       [1:0]    targets_1_requests_12_priority;
  wire       [5:0]    targets_1_requests_12_id;
  wire                targets_1_requests_12_valid;
  wire       [1:0]    targets_1_requests_13_priority;
  wire       [5:0]    targets_1_requests_13_id;
  wire                targets_1_requests_13_valid;
  wire       [1:0]    targets_1_requests_14_priority;
  wire       [5:0]    targets_1_requests_14_id;
  wire                targets_1_requests_14_valid;
  wire       [1:0]    targets_1_requests_15_priority;
  wire       [5:0]    targets_1_requests_15_id;
  wire                targets_1_requests_15_valid;
  wire       [1:0]    targets_1_requests_16_priority;
  wire       [5:0]    targets_1_requests_16_id;
  wire                targets_1_requests_16_valid;
  wire       [1:0]    targets_1_requests_17_priority;
  wire       [5:0]    targets_1_requests_17_id;
  wire                targets_1_requests_17_valid;
  wire       [1:0]    targets_1_requests_18_priority;
  wire       [5:0]    targets_1_requests_18_id;
  wire                targets_1_requests_18_valid;
  wire       [1:0]    targets_1_requests_19_priority;
  wire       [5:0]    targets_1_requests_19_id;
  wire                targets_1_requests_19_valid;
  wire       [1:0]    targets_1_requests_20_priority;
  wire       [5:0]    targets_1_requests_20_id;
  wire                targets_1_requests_20_valid;
  wire       [1:0]    targets_1_requests_21_priority;
  wire       [5:0]    targets_1_requests_21_id;
  wire                targets_1_requests_21_valid;
  wire       [1:0]    targets_1_requests_22_priority;
  wire       [5:0]    targets_1_requests_22_id;
  wire                targets_1_requests_22_valid;
  wire       [1:0]    targets_1_requests_23_priority;
  wire       [5:0]    targets_1_requests_23_id;
  wire                targets_1_requests_23_valid;
  wire       [1:0]    targets_1_requests_24_priority;
  wire       [5:0]    targets_1_requests_24_id;
  wire                targets_1_requests_24_valid;
  wire       [1:0]    targets_1_requests_25_priority;
  wire       [5:0]    targets_1_requests_25_id;
  wire                targets_1_requests_25_valid;
  wire       [1:0]    targets_1_requests_26_priority;
  wire       [5:0]    targets_1_requests_26_id;
  wire                targets_1_requests_26_valid;
  wire       [1:0]    targets_1_requests_27_priority;
  wire       [5:0]    targets_1_requests_27_id;
  wire                targets_1_requests_27_valid;
  wire       [1:0]    targets_1_requests_28_priority;
  wire       [5:0]    targets_1_requests_28_id;
  wire                targets_1_requests_28_valid;
  wire       [1:0]    targets_1_requests_29_priority;
  wire       [5:0]    targets_1_requests_29_id;
  wire                targets_1_requests_29_valid;
  wire       [1:0]    targets_1_requests_30_priority;
  wire       [5:0]    targets_1_requests_30_id;
  wire                targets_1_requests_30_valid;
  wire       [1:0]    targets_1_requests_31_priority;
  wire       [5:0]    targets_1_requests_31_id;
  wire                targets_1_requests_31_valid;
  wire       [1:0]    targets_1_requests_32_priority;
  wire       [5:0]    targets_1_requests_32_id;
  wire                targets_1_requests_32_valid;
  wire                _zz_targets_1_bestRequest_id;
  wire       [1:0]    _zz_targets_1_bestRequest_id_1;
  wire                _zz_targets_1_bestRequest_id_2;
  wire                _zz_targets_1_bestRequest_id_3;
  wire       [1:0]    _zz_targets_1_bestRequest_id_4;
  wire                _zz_targets_1_bestRequest_id_5;
  wire                _zz_targets_1_bestRequest_id_6;
  wire       [1:0]    _zz_targets_1_bestRequest_id_7;
  wire                _zz_targets_1_bestRequest_id_8;
  wire                _zz_targets_1_bestRequest_id_9;
  wire       [1:0]    _zz_targets_1_bestRequest_id_10;
  wire                _zz_targets_1_bestRequest_id_11;
  wire                _zz_targets_1_bestRequest_id_12;
  wire       [1:0]    _zz_targets_1_bestRequest_id_13;
  wire                _zz_targets_1_bestRequest_id_14;
  wire                _zz_targets_1_bestRequest_id_15;
  wire       [1:0]    _zz_targets_1_bestRequest_id_16;
  wire                _zz_targets_1_bestRequest_id_17;
  wire                _zz_targets_1_bestRequest_id_18;
  wire       [1:0]    _zz_targets_1_bestRequest_id_19;
  wire                _zz_targets_1_bestRequest_id_20;
  wire                _zz_targets_1_bestRequest_id_21;
  wire       [1:0]    _zz_targets_1_bestRequest_id_22;
  wire                _zz_targets_1_bestRequest_id_23;
  wire                _zz_targets_1_bestRequest_id_24;
  wire       [1:0]    _zz_targets_1_bestRequest_id_25;
  wire                _zz_targets_1_bestRequest_id_26;
  wire                _zz_targets_1_bestRequest_id_27;
  wire       [1:0]    _zz_targets_1_bestRequest_id_28;
  wire                _zz_targets_1_bestRequest_id_29;
  wire                _zz_targets_1_bestRequest_id_30;
  wire       [1:0]    _zz_targets_1_bestRequest_id_31;
  wire                _zz_targets_1_bestRequest_id_32;
  wire                _zz_targets_1_bestRequest_id_33;
  wire       [1:0]    _zz_targets_1_bestRequest_id_34;
  wire                _zz_targets_1_bestRequest_id_35;
  wire                _zz_targets_1_bestRequest_id_36;
  wire       [1:0]    _zz_targets_1_bestRequest_id_37;
  wire                _zz_targets_1_bestRequest_id_38;
  wire                _zz_targets_1_bestRequest_id_39;
  wire       [1:0]    _zz_targets_1_bestRequest_id_40;
  wire                _zz_targets_1_bestRequest_id_41;
  wire                _zz_targets_1_bestRequest_id_42;
  wire       [1:0]    _zz_targets_1_bestRequest_id_43;
  wire                _zz_targets_1_bestRequest_id_44;
  wire                _zz_targets_1_bestRequest_id_45;
  wire       [1:0]    _zz_targets_1_bestRequest_id_46;
  wire                _zz_targets_1_bestRequest_id_47;
  wire                _zz_targets_1_bestRequest_id_48;
  wire       [1:0]    _zz_targets_1_bestRequest_id_49;
  wire                _zz_targets_1_bestRequest_id_50;
  wire                _zz_targets_1_bestRequest_id_51;
  wire       [1:0]    _zz_targets_1_bestRequest_id_52;
  wire                _zz_targets_1_bestRequest_id_53;
  wire                _zz_targets_1_bestRequest_id_54;
  wire       [1:0]    _zz_targets_1_bestRequest_id_55;
  wire                _zz_targets_1_bestRequest_id_56;
  wire                _zz_targets_1_bestRequest_id_57;
  wire       [1:0]    _zz_targets_1_bestRequest_id_58;
  wire                _zz_targets_1_bestRequest_id_59;
  wire                _zz_targets_1_bestRequest_id_60;
  wire       [1:0]    _zz_targets_1_bestRequest_id_61;
  wire                _zz_targets_1_bestRequest_id_62;
  wire                _zz_targets_1_bestRequest_id_63;
  wire       [1:0]    _zz_targets_1_bestRequest_id_64;
  wire                _zz_targets_1_bestRequest_id_65;
  wire                _zz_targets_1_bestRequest_id_66;
  wire       [1:0]    _zz_targets_1_bestRequest_id_67;
  wire                _zz_targets_1_bestRequest_id_68;
  wire                _zz_targets_1_bestRequest_id_69;
  wire       [1:0]    _zz_targets_1_bestRequest_id_70;
  wire                _zz_targets_1_bestRequest_id_71;
  wire                _zz_targets_1_bestRequest_id_72;
  wire       [1:0]    _zz_targets_1_bestRequest_id_73;
  wire                _zz_targets_1_bestRequest_id_74;
  wire                _zz_targets_1_bestRequest_id_75;
  wire       [1:0]    _zz_targets_1_bestRequest_id_76;
  wire                _zz_targets_1_bestRequest_id_77;
  wire                _zz_targets_1_bestRequest_id_78;
  wire       [1:0]    _zz_targets_1_bestRequest_id_79;
  wire                _zz_targets_1_bestRequest_id_80;
  wire                _zz_targets_1_bestRequest_id_81;
  wire       [1:0]    _zz_targets_1_bestRequest_id_82;
  wire                _zz_targets_1_bestRequest_id_83;
  wire                _zz_targets_1_bestRequest_id_84;
  wire       [1:0]    _zz_targets_1_bestRequest_priority;
  wire                _zz_targets_1_bestRequest_id_85;
  wire                _zz_targets_1_bestRequest_id_86;
  wire       [1:0]    _zz_targets_1_bestRequest_priority_1;
  wire                _zz_targets_1_bestRequest_id_87;
  wire                _zz_targets_1_bestRequest_id_88;
  wire       [1:0]    _zz_targets_1_bestRequest_priority_2;
  wire                _zz_targets_1_bestRequest_valid;
  wire                _zz_targets_1_bestRequest_priority_3;
  reg        [1:0]    targets_1_bestRequest_priority;
  reg        [5:0]    targets_1_bestRequest_id;
  reg                 targets_1_bestRequest_valid;
  wire                targets_1_iep;
  wire       [5:0]    targets_1_claim;
  wire                bus_readErrorFlag;
  wire                bus_writeErrorFlag;
  reg                 bus_readHaltRequest;
  wire                bus_writeHaltRequest;
  wire                bus_writeJoinEvent_valid;
  wire                bus_writeJoinEvent_ready;
  wire                bus_writeOccur;
  reg        [1:0]    bus_writeRsp_resp;
  wire                bus_writeJoinEvent_translated_valid;
  wire                bus_writeJoinEvent_translated_ready;
  wire       [1:0]    bus_writeJoinEvent_translated_payload_resp;
  wire                _zz_bus_writeJoinEvent_translated_ready;
  wire                bus_writeJoinEvent_translated_haltWhen_valid;
  wire                bus_writeJoinEvent_translated_haltWhen_ready;
  wire       [1:0]    bus_writeJoinEvent_translated_haltWhen_payload_resp;
  wire                bus_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  wire                bus_writeJoinEvent_translated_haltWhen_halfPipe_ready;
  wire       [1:0]    bus_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  reg                 bus_writeJoinEvent_translated_haltWhen_rValid;
  wire                bus_writeJoinEvent_translated_haltWhen_halfPipe_fire;
  reg        [1:0]    bus_writeJoinEvent_translated_haltWhen_rData_resp;
  wire                bus_readDataStage_valid;
  wire                bus_readDataStage_ready;
  wire       [21:0]   bus_readDataStage_payload_addr;
  wire       [2:0]    bus_readDataStage_payload_prot;
  reg                 io_bus_ar_rValid;
  wire                bus_readDataStage_fire;
  reg        [21:0]   io_bus_ar_rData_addr;
  reg        [2:0]    io_bus_ar_rData_prot;
  reg        [31:0]   bus_readRsp_data;
  reg        [1:0]    bus_readRsp_resp;
  wire                _zz_bus_readDataStage_ready;
  wire                bus_readDataStage_haltWhen_valid;
  wire                bus_readDataStage_haltWhen_ready;
  wire       [21:0]   bus_readDataStage_haltWhen_payload_addr;
  wire       [2:0]    bus_readDataStage_haltWhen_payload_prot;
  wire                bus_readDataStage_haltWhen_translated_valid;
  wire                bus_readDataStage_haltWhen_translated_ready;
  wire       [31:0]   bus_readDataStage_haltWhen_translated_payload_data;
  wire       [1:0]    bus_readDataStage_haltWhen_translated_payload_resp;
  wire       [21:0]   bus_readAddressMasked;
  wire       [21:0]   bus_writeAddressMasked;
  wire                bus_readOccur;
  reg        [1:0]    gateways_0_priority_driver;
  reg        [1:0]    gateways_1_priority_driver;
  reg        [1:0]    gateways_2_priority_driver;
  reg        [1:0]    gateways_3_priority_driver;
  reg        [1:0]    gateways_4_priority_driver;
  reg        [1:0]    gateways_5_priority_driver;
  reg        [1:0]    gateways_6_priority_driver;
  reg        [1:0]    gateways_7_priority_driver;
  reg        [1:0]    gateways_8_priority_driver;
  reg        [1:0]    gateways_9_priority_driver;
  reg        [1:0]    gateways_10_priority_driver;
  reg        [1:0]    gateways_11_priority_driver;
  reg        [1:0]    gateways_12_priority_driver;
  reg        [1:0]    gateways_13_priority_driver;
  reg        [1:0]    gateways_14_priority_driver;
  reg        [1:0]    gateways_15_priority_driver;
  reg        [1:0]    gateways_16_priority_driver;
  reg        [1:0]    gateways_17_priority_driver;
  reg        [1:0]    gateways_18_priority_driver;
  reg        [1:0]    gateways_19_priority_driver;
  reg        [1:0]    gateways_20_priority_driver;
  reg        [1:0]    gateways_21_priority_driver;
  reg        [1:0]    gateways_22_priority_driver;
  reg        [1:0]    gateways_23_priority_driver;
  reg        [1:0]    gateways_24_priority_driver;
  reg        [1:0]    gateways_25_priority_driver;
  reg        [1:0]    gateways_26_priority_driver;
  reg        [1:0]    gateways_27_priority_driver;
  reg        [1:0]    gateways_28_priority_driver;
  reg        [1:0]    gateways_29_priority_driver;
  reg        [1:0]    gateways_30_priority_driver;
  reg        [1:0]    gateways_31_priority_driver;
  reg                 mapping_claim_valid;
  reg        [5:0]    mapping_claim_payload;
  reg                 mapping_completion_valid;
  reg        [5:0]    mapping_completion_payload;
  reg                 mapping_coherencyStall_willIncrement;
  wire                mapping_coherencyStall_willClear;
  reg        [0:0]    mapping_coherencyStall_valueNext;
  reg        [0:0]    mapping_coherencyStall_value;
  wire                mapping_coherencyStall_willOverflowIfInc;
  wire                mapping_coherencyStall_willOverflow;
  wire                when_PlicMapper_l122;
  reg        [1:0]    targets_0_threshold_driver;
  reg                 mapping_targetMapping_0_targetCompletion_valid;
  wire       [5:0]    mapping_targetMapping_0_targetCompletion_payload;
  reg                 targets_0_ie_0_driver;
  reg                 targets_0_ie_1_driver;
  reg                 targets_0_ie_2_driver;
  reg                 targets_0_ie_3_driver;
  reg                 targets_0_ie_4_driver;
  reg                 targets_0_ie_5_driver;
  reg                 targets_0_ie_6_driver;
  reg                 targets_0_ie_7_driver;
  reg                 targets_0_ie_8_driver;
  reg                 targets_0_ie_9_driver;
  reg                 targets_0_ie_10_driver;
  reg                 targets_0_ie_11_driver;
  reg                 targets_0_ie_12_driver;
  reg                 targets_0_ie_13_driver;
  reg                 targets_0_ie_14_driver;
  reg                 targets_0_ie_15_driver;
  reg                 targets_0_ie_16_driver;
  reg                 targets_0_ie_17_driver;
  reg                 targets_0_ie_18_driver;
  reg                 targets_0_ie_19_driver;
  reg                 targets_0_ie_20_driver;
  reg                 targets_0_ie_21_driver;
  reg                 targets_0_ie_22_driver;
  reg                 targets_0_ie_23_driver;
  reg                 targets_0_ie_24_driver;
  reg                 targets_0_ie_25_driver;
  reg                 targets_0_ie_26_driver;
  reg                 targets_0_ie_27_driver;
  reg                 targets_0_ie_28_driver;
  reg                 targets_0_ie_29_driver;
  reg                 targets_0_ie_30_driver;
  reg                 targets_0_ie_31_driver;
  reg        [1:0]    targets_1_threshold_driver;
  reg                 mapping_targetMapping_1_targetCompletion_valid;
  wire       [5:0]    mapping_targetMapping_1_targetCompletion_payload;
  reg                 targets_1_ie_0_driver;
  reg                 targets_1_ie_1_driver;
  reg                 targets_1_ie_2_driver;
  reg                 targets_1_ie_3_driver;
  reg                 targets_1_ie_4_driver;
  reg                 targets_1_ie_5_driver;
  reg                 targets_1_ie_6_driver;
  reg                 targets_1_ie_7_driver;
  reg                 targets_1_ie_8_driver;
  reg                 targets_1_ie_9_driver;
  reg                 targets_1_ie_10_driver;
  reg                 targets_1_ie_11_driver;
  reg                 targets_1_ie_12_driver;
  reg                 targets_1_ie_13_driver;
  reg                 targets_1_ie_14_driver;
  reg                 targets_1_ie_15_driver;
  reg                 targets_1_ie_16_driver;
  reg                 targets_1_ie_17_driver;
  reg                 targets_1_ie_18_driver;
  reg                 targets_1_ie_19_driver;
  reg                 targets_1_ie_20_driver;
  reg                 targets_1_ie_21_driver;
  reg                 targets_1_ie_22_driver;
  reg                 targets_1_ie_23_driver;
  reg                 targets_1_ie_24_driver;
  reg                 targets_1_ie_25_driver;
  reg                 targets_1_ie_26_driver;
  reg                 targets_1_ie_27_driver;
  reg                 targets_1_ie_28_driver;
  reg                 targets_1_ie_29_driver;
  reg                 targets_1_ie_30_driver;
  reg                 targets_1_ie_31_driver;
  wire                when_AxiLite4SlaveFactory_l68;
  wire                when_AxiLite4SlaveFactory_l86;

  assign _zz_targets_0_bestRequest_id_89 = (_zz_targets_0_bestRequest_id ? targets_0_requests_0_id : targets_0_requests_1_id);
  assign _zz_targets_0_bestRequest_id_90 = (_zz_targets_0_bestRequest_id_3 ? targets_0_requests_2_id : targets_0_requests_3_id);
  assign _zz_targets_0_bestRequest_id_91 = (_zz_targets_0_bestRequest_id_6 ? targets_0_requests_4_id : targets_0_requests_5_id);
  assign _zz_targets_0_bestRequest_id_92 = (_zz_targets_0_bestRequest_id_9 ? targets_0_requests_6_id : targets_0_requests_7_id);
  assign _zz_targets_0_bestRequest_id_93 = (_zz_targets_0_bestRequest_id_12 ? targets_0_requests_8_id : targets_0_requests_9_id);
  assign _zz_targets_0_bestRequest_id_94 = (_zz_targets_0_bestRequest_id_15 ? targets_0_requests_10_id : targets_0_requests_11_id);
  assign _zz_targets_0_bestRequest_id_95 = (_zz_targets_0_bestRequest_id_18 ? targets_0_requests_12_id : targets_0_requests_13_id);
  assign _zz_targets_0_bestRequest_id_96 = (_zz_targets_0_bestRequest_id_21 ? targets_0_requests_14_id : targets_0_requests_15_id);
  assign _zz_targets_0_bestRequest_id_97 = (_zz_targets_0_bestRequest_id_24 ? targets_0_requests_16_id : targets_0_requests_17_id);
  assign _zz_targets_0_bestRequest_id_98 = (_zz_targets_0_bestRequest_id_27 ? targets_0_requests_18_id : targets_0_requests_19_id);
  assign _zz_targets_0_bestRequest_id_99 = (_zz_targets_0_bestRequest_id_30 ? targets_0_requests_20_id : targets_0_requests_21_id);
  assign _zz_targets_0_bestRequest_id_100 = (_zz_targets_0_bestRequest_id_33 ? targets_0_requests_22_id : targets_0_requests_23_id);
  assign _zz_targets_0_bestRequest_id_101 = (_zz_targets_0_bestRequest_id_36 ? targets_0_requests_24_id : targets_0_requests_25_id);
  assign _zz_targets_0_bestRequest_id_102 = (_zz_targets_0_bestRequest_id_39 ? targets_0_requests_26_id : targets_0_requests_27_id);
  assign _zz_targets_0_bestRequest_id_103 = (_zz_targets_0_bestRequest_id_42 ? targets_0_requests_28_id : targets_0_requests_29_id);
  assign _zz_targets_0_bestRequest_id_104 = (_zz_targets_0_bestRequest_id_45 ? targets_0_requests_30_id : targets_0_requests_31_id);
  assign _zz_targets_1_bestRequest_id_89 = (_zz_targets_1_bestRequest_id ? targets_1_requests_0_id : targets_1_requests_1_id);
  assign _zz_targets_1_bestRequest_id_90 = (_zz_targets_1_bestRequest_id_3 ? targets_1_requests_2_id : targets_1_requests_3_id);
  assign _zz_targets_1_bestRequest_id_91 = (_zz_targets_1_bestRequest_id_6 ? targets_1_requests_4_id : targets_1_requests_5_id);
  assign _zz_targets_1_bestRequest_id_92 = (_zz_targets_1_bestRequest_id_9 ? targets_1_requests_6_id : targets_1_requests_7_id);
  assign _zz_targets_1_bestRequest_id_93 = (_zz_targets_1_bestRequest_id_12 ? targets_1_requests_8_id : targets_1_requests_9_id);
  assign _zz_targets_1_bestRequest_id_94 = (_zz_targets_1_bestRequest_id_15 ? targets_1_requests_10_id : targets_1_requests_11_id);
  assign _zz_targets_1_bestRequest_id_95 = (_zz_targets_1_bestRequest_id_18 ? targets_1_requests_12_id : targets_1_requests_13_id);
  assign _zz_targets_1_bestRequest_id_96 = (_zz_targets_1_bestRequest_id_21 ? targets_1_requests_14_id : targets_1_requests_15_id);
  assign _zz_targets_1_bestRequest_id_97 = (_zz_targets_1_bestRequest_id_24 ? targets_1_requests_16_id : targets_1_requests_17_id);
  assign _zz_targets_1_bestRequest_id_98 = (_zz_targets_1_bestRequest_id_27 ? targets_1_requests_18_id : targets_1_requests_19_id);
  assign _zz_targets_1_bestRequest_id_99 = (_zz_targets_1_bestRequest_id_30 ? targets_1_requests_20_id : targets_1_requests_21_id);
  assign _zz_targets_1_bestRequest_id_100 = (_zz_targets_1_bestRequest_id_33 ? targets_1_requests_22_id : targets_1_requests_23_id);
  assign _zz_targets_1_bestRequest_id_101 = (_zz_targets_1_bestRequest_id_36 ? targets_1_requests_24_id : targets_1_requests_25_id);
  assign _zz_targets_1_bestRequest_id_102 = (_zz_targets_1_bestRequest_id_39 ? targets_1_requests_26_id : targets_1_requests_27_id);
  assign _zz_targets_1_bestRequest_id_103 = (_zz_targets_1_bestRequest_id_42 ? targets_1_requests_28_id : targets_1_requests_29_id);
  assign _zz_targets_1_bestRequest_id_104 = (_zz_targets_1_bestRequest_id_45 ? targets_1_requests_30_id : targets_1_requests_31_id);
  assign _zz_gateways_0_ip = io_sources[0];
  assign _zz_gateways_1_ip = io_sources[1];
  assign _zz_gateways_2_ip = io_sources[2];
  assign _zz_gateways_3_ip = io_sources[3];
  assign _zz_gateways_4_ip = io_sources[4];
  assign _zz_gateways_5_ip = io_sources[5];
  assign _zz_gateways_6_ip = io_sources[6];
  assign _zz_gateways_7_ip = io_sources[7];
  assign _zz_gateways_8_ip = io_sources[8];
  assign _zz_gateways_9_ip = io_sources[9];
  assign _zz_gateways_10_ip = io_sources[10];
  assign _zz_gateways_11_ip = io_sources[11];
  assign _zz_gateways_12_ip = io_sources[12];
  assign _zz_gateways_13_ip = io_sources[13];
  assign _zz_gateways_14_ip = io_sources[14];
  assign _zz_gateways_15_ip = io_sources[15];
  assign _zz_gateways_16_ip = io_sources[16];
  assign _zz_gateways_17_ip = io_sources[17];
  assign _zz_gateways_18_ip = io_sources[18];
  assign _zz_gateways_19_ip = io_sources[19];
  assign _zz_gateways_20_ip = io_sources[20];
  assign _zz_gateways_21_ip = io_sources[21];
  assign _zz_gateways_22_ip = io_sources[22];
  assign _zz_gateways_23_ip = io_sources[23];
  assign _zz_gateways_24_ip = io_sources[24];
  assign _zz_gateways_25_ip = io_sources[25];
  assign _zz_gateways_26_ip = io_sources[26];
  assign _zz_gateways_27_ip = io_sources[27];
  assign _zz_gateways_28_ip = io_sources[28];
  assign _zz_gateways_29_ip = io_sources[29];
  assign _zz_gateways_30_ip = io_sources[30];
  assign _zz_gateways_31_ip = io_sources[31];
  assign when_PlicGateway_l21 = (! gateways_0_waitCompletion);
  assign when_PlicGateway_l21_1 = (! gateways_1_waitCompletion);
  assign when_PlicGateway_l21_2 = (! gateways_2_waitCompletion);
  assign when_PlicGateway_l21_3 = (! gateways_3_waitCompletion);
  assign when_PlicGateway_l21_4 = (! gateways_4_waitCompletion);
  assign when_PlicGateway_l21_5 = (! gateways_5_waitCompletion);
  assign when_PlicGateway_l21_6 = (! gateways_6_waitCompletion);
  assign when_PlicGateway_l21_7 = (! gateways_7_waitCompletion);
  assign when_PlicGateway_l21_8 = (! gateways_8_waitCompletion);
  assign when_PlicGateway_l21_9 = (! gateways_9_waitCompletion);
  assign when_PlicGateway_l21_10 = (! gateways_10_waitCompletion);
  assign when_PlicGateway_l21_11 = (! gateways_11_waitCompletion);
  assign when_PlicGateway_l21_12 = (! gateways_12_waitCompletion);
  assign when_PlicGateway_l21_13 = (! gateways_13_waitCompletion);
  assign when_PlicGateway_l21_14 = (! gateways_14_waitCompletion);
  assign when_PlicGateway_l21_15 = (! gateways_15_waitCompletion);
  assign when_PlicGateway_l21_16 = (! gateways_16_waitCompletion);
  assign when_PlicGateway_l21_17 = (! gateways_17_waitCompletion);
  assign when_PlicGateway_l21_18 = (! gateways_18_waitCompletion);
  assign when_PlicGateway_l21_19 = (! gateways_19_waitCompletion);
  assign when_PlicGateway_l21_20 = (! gateways_20_waitCompletion);
  assign when_PlicGateway_l21_21 = (! gateways_21_waitCompletion);
  assign when_PlicGateway_l21_22 = (! gateways_22_waitCompletion);
  assign when_PlicGateway_l21_23 = (! gateways_23_waitCompletion);
  assign when_PlicGateway_l21_24 = (! gateways_24_waitCompletion);
  assign when_PlicGateway_l21_25 = (! gateways_25_waitCompletion);
  assign when_PlicGateway_l21_26 = (! gateways_26_waitCompletion);
  assign when_PlicGateway_l21_27 = (! gateways_27_waitCompletion);
  assign when_PlicGateway_l21_28 = (! gateways_28_waitCompletion);
  assign when_PlicGateway_l21_29 = (! gateways_29_waitCompletion);
  assign when_PlicGateway_l21_30 = (! gateways_30_waitCompletion);
  assign when_PlicGateway_l21_31 = (! gateways_31_waitCompletion);
  assign targets_0_requests_0_priority = 2'b00;
  assign targets_0_requests_0_id = 6'h0;
  assign targets_0_requests_0_valid = 1'b1;
  assign targets_0_requests_1_priority = gateways_0_priority;
  assign targets_0_requests_1_id = 6'h01;
  assign targets_0_requests_1_valid = (gateways_0_ip && targets_0_ie_0);
  assign targets_0_requests_2_priority = gateways_1_priority;
  assign targets_0_requests_2_id = 6'h02;
  assign targets_0_requests_2_valid = (gateways_1_ip && targets_0_ie_1);
  assign targets_0_requests_3_priority = gateways_2_priority;
  assign targets_0_requests_3_id = 6'h03;
  assign targets_0_requests_3_valid = (gateways_2_ip && targets_0_ie_2);
  assign targets_0_requests_4_priority = gateways_3_priority;
  assign targets_0_requests_4_id = 6'h04;
  assign targets_0_requests_4_valid = (gateways_3_ip && targets_0_ie_3);
  assign targets_0_requests_5_priority = gateways_4_priority;
  assign targets_0_requests_5_id = 6'h05;
  assign targets_0_requests_5_valid = (gateways_4_ip && targets_0_ie_4);
  assign targets_0_requests_6_priority = gateways_5_priority;
  assign targets_0_requests_6_id = 6'h06;
  assign targets_0_requests_6_valid = (gateways_5_ip && targets_0_ie_5);
  assign targets_0_requests_7_priority = gateways_6_priority;
  assign targets_0_requests_7_id = 6'h07;
  assign targets_0_requests_7_valid = (gateways_6_ip && targets_0_ie_6);
  assign targets_0_requests_8_priority = gateways_7_priority;
  assign targets_0_requests_8_id = 6'h08;
  assign targets_0_requests_8_valid = (gateways_7_ip && targets_0_ie_7);
  assign targets_0_requests_9_priority = gateways_8_priority;
  assign targets_0_requests_9_id = 6'h09;
  assign targets_0_requests_9_valid = (gateways_8_ip && targets_0_ie_8);
  assign targets_0_requests_10_priority = gateways_9_priority;
  assign targets_0_requests_10_id = 6'h0a;
  assign targets_0_requests_10_valid = (gateways_9_ip && targets_0_ie_9);
  assign targets_0_requests_11_priority = gateways_10_priority;
  assign targets_0_requests_11_id = 6'h0b;
  assign targets_0_requests_11_valid = (gateways_10_ip && targets_0_ie_10);
  assign targets_0_requests_12_priority = gateways_11_priority;
  assign targets_0_requests_12_id = 6'h0c;
  assign targets_0_requests_12_valid = (gateways_11_ip && targets_0_ie_11);
  assign targets_0_requests_13_priority = gateways_12_priority;
  assign targets_0_requests_13_id = 6'h0d;
  assign targets_0_requests_13_valid = (gateways_12_ip && targets_0_ie_12);
  assign targets_0_requests_14_priority = gateways_13_priority;
  assign targets_0_requests_14_id = 6'h0e;
  assign targets_0_requests_14_valid = (gateways_13_ip && targets_0_ie_13);
  assign targets_0_requests_15_priority = gateways_14_priority;
  assign targets_0_requests_15_id = 6'h0f;
  assign targets_0_requests_15_valid = (gateways_14_ip && targets_0_ie_14);
  assign targets_0_requests_16_priority = gateways_15_priority;
  assign targets_0_requests_16_id = 6'h10;
  assign targets_0_requests_16_valid = (gateways_15_ip && targets_0_ie_15);
  assign targets_0_requests_17_priority = gateways_16_priority;
  assign targets_0_requests_17_id = 6'h11;
  assign targets_0_requests_17_valid = (gateways_16_ip && targets_0_ie_16);
  assign targets_0_requests_18_priority = gateways_17_priority;
  assign targets_0_requests_18_id = 6'h12;
  assign targets_0_requests_18_valid = (gateways_17_ip && targets_0_ie_17);
  assign targets_0_requests_19_priority = gateways_18_priority;
  assign targets_0_requests_19_id = 6'h13;
  assign targets_0_requests_19_valid = (gateways_18_ip && targets_0_ie_18);
  assign targets_0_requests_20_priority = gateways_19_priority;
  assign targets_0_requests_20_id = 6'h14;
  assign targets_0_requests_20_valid = (gateways_19_ip && targets_0_ie_19);
  assign targets_0_requests_21_priority = gateways_20_priority;
  assign targets_0_requests_21_id = 6'h15;
  assign targets_0_requests_21_valid = (gateways_20_ip && targets_0_ie_20);
  assign targets_0_requests_22_priority = gateways_21_priority;
  assign targets_0_requests_22_id = 6'h16;
  assign targets_0_requests_22_valid = (gateways_21_ip && targets_0_ie_21);
  assign targets_0_requests_23_priority = gateways_22_priority;
  assign targets_0_requests_23_id = 6'h17;
  assign targets_0_requests_23_valid = (gateways_22_ip && targets_0_ie_22);
  assign targets_0_requests_24_priority = gateways_23_priority;
  assign targets_0_requests_24_id = 6'h18;
  assign targets_0_requests_24_valid = (gateways_23_ip && targets_0_ie_23);
  assign targets_0_requests_25_priority = gateways_24_priority;
  assign targets_0_requests_25_id = 6'h19;
  assign targets_0_requests_25_valid = (gateways_24_ip && targets_0_ie_24);
  assign targets_0_requests_26_priority = gateways_25_priority;
  assign targets_0_requests_26_id = 6'h1a;
  assign targets_0_requests_26_valid = (gateways_25_ip && targets_0_ie_25);
  assign targets_0_requests_27_priority = gateways_26_priority;
  assign targets_0_requests_27_id = 6'h1b;
  assign targets_0_requests_27_valid = (gateways_26_ip && targets_0_ie_26);
  assign targets_0_requests_28_priority = gateways_27_priority;
  assign targets_0_requests_28_id = 6'h1c;
  assign targets_0_requests_28_valid = (gateways_27_ip && targets_0_ie_27);
  assign targets_0_requests_29_priority = gateways_28_priority;
  assign targets_0_requests_29_id = 6'h1d;
  assign targets_0_requests_29_valid = (gateways_28_ip && targets_0_ie_28);
  assign targets_0_requests_30_priority = gateways_29_priority;
  assign targets_0_requests_30_id = 6'h1e;
  assign targets_0_requests_30_valid = (gateways_29_ip && targets_0_ie_29);
  assign targets_0_requests_31_priority = gateways_30_priority;
  assign targets_0_requests_31_id = 6'h1f;
  assign targets_0_requests_31_valid = (gateways_30_ip && targets_0_ie_30);
  assign targets_0_requests_32_priority = gateways_31_priority;
  assign targets_0_requests_32_id = 6'h20;
  assign targets_0_requests_32_valid = (gateways_31_ip && targets_0_ie_31);
  assign _zz_targets_0_bestRequest_id = ((! targets_0_requests_1_valid) || (targets_0_requests_0_valid && (targets_0_requests_1_priority <= targets_0_requests_0_priority)));
  assign _zz_targets_0_bestRequest_id_1 = (_zz_targets_0_bestRequest_id ? targets_0_requests_0_priority : targets_0_requests_1_priority);
  assign _zz_targets_0_bestRequest_id_2 = (_zz_targets_0_bestRequest_id ? targets_0_requests_0_valid : targets_0_requests_1_valid);
  assign _zz_targets_0_bestRequest_id_3 = ((! targets_0_requests_3_valid) || (targets_0_requests_2_valid && (targets_0_requests_3_priority <= targets_0_requests_2_priority)));
  assign _zz_targets_0_bestRequest_id_4 = (_zz_targets_0_bestRequest_id_3 ? targets_0_requests_2_priority : targets_0_requests_3_priority);
  assign _zz_targets_0_bestRequest_id_5 = (_zz_targets_0_bestRequest_id_3 ? targets_0_requests_2_valid : targets_0_requests_3_valid);
  assign _zz_targets_0_bestRequest_id_6 = ((! targets_0_requests_5_valid) || (targets_0_requests_4_valid && (targets_0_requests_5_priority <= targets_0_requests_4_priority)));
  assign _zz_targets_0_bestRequest_id_7 = (_zz_targets_0_bestRequest_id_6 ? targets_0_requests_4_priority : targets_0_requests_5_priority);
  assign _zz_targets_0_bestRequest_id_8 = (_zz_targets_0_bestRequest_id_6 ? targets_0_requests_4_valid : targets_0_requests_5_valid);
  assign _zz_targets_0_bestRequest_id_9 = ((! targets_0_requests_7_valid) || (targets_0_requests_6_valid && (targets_0_requests_7_priority <= targets_0_requests_6_priority)));
  assign _zz_targets_0_bestRequest_id_10 = (_zz_targets_0_bestRequest_id_9 ? targets_0_requests_6_priority : targets_0_requests_7_priority);
  assign _zz_targets_0_bestRequest_id_11 = (_zz_targets_0_bestRequest_id_9 ? targets_0_requests_6_valid : targets_0_requests_7_valid);
  assign _zz_targets_0_bestRequest_id_12 = ((! targets_0_requests_9_valid) || (targets_0_requests_8_valid && (targets_0_requests_9_priority <= targets_0_requests_8_priority)));
  assign _zz_targets_0_bestRequest_id_13 = (_zz_targets_0_bestRequest_id_12 ? targets_0_requests_8_priority : targets_0_requests_9_priority);
  assign _zz_targets_0_bestRequest_id_14 = (_zz_targets_0_bestRequest_id_12 ? targets_0_requests_8_valid : targets_0_requests_9_valid);
  assign _zz_targets_0_bestRequest_id_15 = ((! targets_0_requests_11_valid) || (targets_0_requests_10_valid && (targets_0_requests_11_priority <= targets_0_requests_10_priority)));
  assign _zz_targets_0_bestRequest_id_16 = (_zz_targets_0_bestRequest_id_15 ? targets_0_requests_10_priority : targets_0_requests_11_priority);
  assign _zz_targets_0_bestRequest_id_17 = (_zz_targets_0_bestRequest_id_15 ? targets_0_requests_10_valid : targets_0_requests_11_valid);
  assign _zz_targets_0_bestRequest_id_18 = ((! targets_0_requests_13_valid) || (targets_0_requests_12_valid && (targets_0_requests_13_priority <= targets_0_requests_12_priority)));
  assign _zz_targets_0_bestRequest_id_19 = (_zz_targets_0_bestRequest_id_18 ? targets_0_requests_12_priority : targets_0_requests_13_priority);
  assign _zz_targets_0_bestRequest_id_20 = (_zz_targets_0_bestRequest_id_18 ? targets_0_requests_12_valid : targets_0_requests_13_valid);
  assign _zz_targets_0_bestRequest_id_21 = ((! targets_0_requests_15_valid) || (targets_0_requests_14_valid && (targets_0_requests_15_priority <= targets_0_requests_14_priority)));
  assign _zz_targets_0_bestRequest_id_22 = (_zz_targets_0_bestRequest_id_21 ? targets_0_requests_14_priority : targets_0_requests_15_priority);
  assign _zz_targets_0_bestRequest_id_23 = (_zz_targets_0_bestRequest_id_21 ? targets_0_requests_14_valid : targets_0_requests_15_valid);
  assign _zz_targets_0_bestRequest_id_24 = ((! targets_0_requests_17_valid) || (targets_0_requests_16_valid && (targets_0_requests_17_priority <= targets_0_requests_16_priority)));
  assign _zz_targets_0_bestRequest_id_25 = (_zz_targets_0_bestRequest_id_24 ? targets_0_requests_16_priority : targets_0_requests_17_priority);
  assign _zz_targets_0_bestRequest_id_26 = (_zz_targets_0_bestRequest_id_24 ? targets_0_requests_16_valid : targets_0_requests_17_valid);
  assign _zz_targets_0_bestRequest_id_27 = ((! targets_0_requests_19_valid) || (targets_0_requests_18_valid && (targets_0_requests_19_priority <= targets_0_requests_18_priority)));
  assign _zz_targets_0_bestRequest_id_28 = (_zz_targets_0_bestRequest_id_27 ? targets_0_requests_18_priority : targets_0_requests_19_priority);
  assign _zz_targets_0_bestRequest_id_29 = (_zz_targets_0_bestRequest_id_27 ? targets_0_requests_18_valid : targets_0_requests_19_valid);
  assign _zz_targets_0_bestRequest_id_30 = ((! targets_0_requests_21_valid) || (targets_0_requests_20_valid && (targets_0_requests_21_priority <= targets_0_requests_20_priority)));
  assign _zz_targets_0_bestRequest_id_31 = (_zz_targets_0_bestRequest_id_30 ? targets_0_requests_20_priority : targets_0_requests_21_priority);
  assign _zz_targets_0_bestRequest_id_32 = (_zz_targets_0_bestRequest_id_30 ? targets_0_requests_20_valid : targets_0_requests_21_valid);
  assign _zz_targets_0_bestRequest_id_33 = ((! targets_0_requests_23_valid) || (targets_0_requests_22_valid && (targets_0_requests_23_priority <= targets_0_requests_22_priority)));
  assign _zz_targets_0_bestRequest_id_34 = (_zz_targets_0_bestRequest_id_33 ? targets_0_requests_22_priority : targets_0_requests_23_priority);
  assign _zz_targets_0_bestRequest_id_35 = (_zz_targets_0_bestRequest_id_33 ? targets_0_requests_22_valid : targets_0_requests_23_valid);
  assign _zz_targets_0_bestRequest_id_36 = ((! targets_0_requests_25_valid) || (targets_0_requests_24_valid && (targets_0_requests_25_priority <= targets_0_requests_24_priority)));
  assign _zz_targets_0_bestRequest_id_37 = (_zz_targets_0_bestRequest_id_36 ? targets_0_requests_24_priority : targets_0_requests_25_priority);
  assign _zz_targets_0_bestRequest_id_38 = (_zz_targets_0_bestRequest_id_36 ? targets_0_requests_24_valid : targets_0_requests_25_valid);
  assign _zz_targets_0_bestRequest_id_39 = ((! targets_0_requests_27_valid) || (targets_0_requests_26_valid && (targets_0_requests_27_priority <= targets_0_requests_26_priority)));
  assign _zz_targets_0_bestRequest_id_40 = (_zz_targets_0_bestRequest_id_39 ? targets_0_requests_26_priority : targets_0_requests_27_priority);
  assign _zz_targets_0_bestRequest_id_41 = (_zz_targets_0_bestRequest_id_39 ? targets_0_requests_26_valid : targets_0_requests_27_valid);
  assign _zz_targets_0_bestRequest_id_42 = ((! targets_0_requests_29_valid) || (targets_0_requests_28_valid && (targets_0_requests_29_priority <= targets_0_requests_28_priority)));
  assign _zz_targets_0_bestRequest_id_43 = (_zz_targets_0_bestRequest_id_42 ? targets_0_requests_28_priority : targets_0_requests_29_priority);
  assign _zz_targets_0_bestRequest_id_44 = (_zz_targets_0_bestRequest_id_42 ? targets_0_requests_28_valid : targets_0_requests_29_valid);
  assign _zz_targets_0_bestRequest_id_45 = ((! targets_0_requests_31_valid) || (targets_0_requests_30_valid && (targets_0_requests_31_priority <= targets_0_requests_30_priority)));
  assign _zz_targets_0_bestRequest_id_46 = (_zz_targets_0_bestRequest_id_45 ? targets_0_requests_30_priority : targets_0_requests_31_priority);
  assign _zz_targets_0_bestRequest_id_47 = (_zz_targets_0_bestRequest_id_45 ? targets_0_requests_30_valid : targets_0_requests_31_valid);
  assign _zz_targets_0_bestRequest_id_48 = ((! _zz_targets_0_bestRequest_id_5) || (_zz_targets_0_bestRequest_id_2 && (_zz_targets_0_bestRequest_id_4 <= _zz_targets_0_bestRequest_id_1)));
  assign _zz_targets_0_bestRequest_id_49 = (_zz_targets_0_bestRequest_id_48 ? _zz_targets_0_bestRequest_id_1 : _zz_targets_0_bestRequest_id_4);
  assign _zz_targets_0_bestRequest_id_50 = (_zz_targets_0_bestRequest_id_48 ? _zz_targets_0_bestRequest_id_2 : _zz_targets_0_bestRequest_id_5);
  assign _zz_targets_0_bestRequest_id_51 = ((! _zz_targets_0_bestRequest_id_11) || (_zz_targets_0_bestRequest_id_8 && (_zz_targets_0_bestRequest_id_10 <= _zz_targets_0_bestRequest_id_7)));
  assign _zz_targets_0_bestRequest_id_52 = (_zz_targets_0_bestRequest_id_51 ? _zz_targets_0_bestRequest_id_7 : _zz_targets_0_bestRequest_id_10);
  assign _zz_targets_0_bestRequest_id_53 = (_zz_targets_0_bestRequest_id_51 ? _zz_targets_0_bestRequest_id_8 : _zz_targets_0_bestRequest_id_11);
  assign _zz_targets_0_bestRequest_id_54 = ((! _zz_targets_0_bestRequest_id_17) || (_zz_targets_0_bestRequest_id_14 && (_zz_targets_0_bestRequest_id_16 <= _zz_targets_0_bestRequest_id_13)));
  assign _zz_targets_0_bestRequest_id_55 = (_zz_targets_0_bestRequest_id_54 ? _zz_targets_0_bestRequest_id_13 : _zz_targets_0_bestRequest_id_16);
  assign _zz_targets_0_bestRequest_id_56 = (_zz_targets_0_bestRequest_id_54 ? _zz_targets_0_bestRequest_id_14 : _zz_targets_0_bestRequest_id_17);
  assign _zz_targets_0_bestRequest_id_57 = ((! _zz_targets_0_bestRequest_id_23) || (_zz_targets_0_bestRequest_id_20 && (_zz_targets_0_bestRequest_id_22 <= _zz_targets_0_bestRequest_id_19)));
  assign _zz_targets_0_bestRequest_id_58 = (_zz_targets_0_bestRequest_id_57 ? _zz_targets_0_bestRequest_id_19 : _zz_targets_0_bestRequest_id_22);
  assign _zz_targets_0_bestRequest_id_59 = (_zz_targets_0_bestRequest_id_57 ? _zz_targets_0_bestRequest_id_20 : _zz_targets_0_bestRequest_id_23);
  assign _zz_targets_0_bestRequest_id_60 = ((! _zz_targets_0_bestRequest_id_29) || (_zz_targets_0_bestRequest_id_26 && (_zz_targets_0_bestRequest_id_28 <= _zz_targets_0_bestRequest_id_25)));
  assign _zz_targets_0_bestRequest_id_61 = (_zz_targets_0_bestRequest_id_60 ? _zz_targets_0_bestRequest_id_25 : _zz_targets_0_bestRequest_id_28);
  assign _zz_targets_0_bestRequest_id_62 = (_zz_targets_0_bestRequest_id_60 ? _zz_targets_0_bestRequest_id_26 : _zz_targets_0_bestRequest_id_29);
  assign _zz_targets_0_bestRequest_id_63 = ((! _zz_targets_0_bestRequest_id_35) || (_zz_targets_0_bestRequest_id_32 && (_zz_targets_0_bestRequest_id_34 <= _zz_targets_0_bestRequest_id_31)));
  assign _zz_targets_0_bestRequest_id_64 = (_zz_targets_0_bestRequest_id_63 ? _zz_targets_0_bestRequest_id_31 : _zz_targets_0_bestRequest_id_34);
  assign _zz_targets_0_bestRequest_id_65 = (_zz_targets_0_bestRequest_id_63 ? _zz_targets_0_bestRequest_id_32 : _zz_targets_0_bestRequest_id_35);
  assign _zz_targets_0_bestRequest_id_66 = ((! _zz_targets_0_bestRequest_id_41) || (_zz_targets_0_bestRequest_id_38 && (_zz_targets_0_bestRequest_id_40 <= _zz_targets_0_bestRequest_id_37)));
  assign _zz_targets_0_bestRequest_id_67 = (_zz_targets_0_bestRequest_id_66 ? _zz_targets_0_bestRequest_id_37 : _zz_targets_0_bestRequest_id_40);
  assign _zz_targets_0_bestRequest_id_68 = (_zz_targets_0_bestRequest_id_66 ? _zz_targets_0_bestRequest_id_38 : _zz_targets_0_bestRequest_id_41);
  assign _zz_targets_0_bestRequest_id_69 = ((! _zz_targets_0_bestRequest_id_47) || (_zz_targets_0_bestRequest_id_44 && (_zz_targets_0_bestRequest_id_46 <= _zz_targets_0_bestRequest_id_43)));
  assign _zz_targets_0_bestRequest_id_70 = (_zz_targets_0_bestRequest_id_69 ? _zz_targets_0_bestRequest_id_43 : _zz_targets_0_bestRequest_id_46);
  assign _zz_targets_0_bestRequest_id_71 = (_zz_targets_0_bestRequest_id_69 ? _zz_targets_0_bestRequest_id_44 : _zz_targets_0_bestRequest_id_47);
  assign _zz_targets_0_bestRequest_id_72 = ((! _zz_targets_0_bestRequest_id_53) || (_zz_targets_0_bestRequest_id_50 && (_zz_targets_0_bestRequest_id_52 <= _zz_targets_0_bestRequest_id_49)));
  assign _zz_targets_0_bestRequest_id_73 = (_zz_targets_0_bestRequest_id_72 ? _zz_targets_0_bestRequest_id_49 : _zz_targets_0_bestRequest_id_52);
  assign _zz_targets_0_bestRequest_id_74 = (_zz_targets_0_bestRequest_id_72 ? _zz_targets_0_bestRequest_id_50 : _zz_targets_0_bestRequest_id_53);
  assign _zz_targets_0_bestRequest_id_75 = ((! _zz_targets_0_bestRequest_id_59) || (_zz_targets_0_bestRequest_id_56 && (_zz_targets_0_bestRequest_id_58 <= _zz_targets_0_bestRequest_id_55)));
  assign _zz_targets_0_bestRequest_id_76 = (_zz_targets_0_bestRequest_id_75 ? _zz_targets_0_bestRequest_id_55 : _zz_targets_0_bestRequest_id_58);
  assign _zz_targets_0_bestRequest_id_77 = (_zz_targets_0_bestRequest_id_75 ? _zz_targets_0_bestRequest_id_56 : _zz_targets_0_bestRequest_id_59);
  assign _zz_targets_0_bestRequest_id_78 = ((! _zz_targets_0_bestRequest_id_65) || (_zz_targets_0_bestRequest_id_62 && (_zz_targets_0_bestRequest_id_64 <= _zz_targets_0_bestRequest_id_61)));
  assign _zz_targets_0_bestRequest_id_79 = (_zz_targets_0_bestRequest_id_78 ? _zz_targets_0_bestRequest_id_61 : _zz_targets_0_bestRequest_id_64);
  assign _zz_targets_0_bestRequest_id_80 = (_zz_targets_0_bestRequest_id_78 ? _zz_targets_0_bestRequest_id_62 : _zz_targets_0_bestRequest_id_65);
  assign _zz_targets_0_bestRequest_id_81 = ((! _zz_targets_0_bestRequest_id_71) || (_zz_targets_0_bestRequest_id_68 && (_zz_targets_0_bestRequest_id_70 <= _zz_targets_0_bestRequest_id_67)));
  assign _zz_targets_0_bestRequest_id_82 = (_zz_targets_0_bestRequest_id_81 ? _zz_targets_0_bestRequest_id_67 : _zz_targets_0_bestRequest_id_70);
  assign _zz_targets_0_bestRequest_id_83 = (_zz_targets_0_bestRequest_id_81 ? _zz_targets_0_bestRequest_id_68 : _zz_targets_0_bestRequest_id_71);
  assign _zz_targets_0_bestRequest_id_84 = ((! _zz_targets_0_bestRequest_id_77) || (_zz_targets_0_bestRequest_id_74 && (_zz_targets_0_bestRequest_id_76 <= _zz_targets_0_bestRequest_id_73)));
  assign _zz_targets_0_bestRequest_priority = (_zz_targets_0_bestRequest_id_84 ? _zz_targets_0_bestRequest_id_73 : _zz_targets_0_bestRequest_id_76);
  assign _zz_targets_0_bestRequest_id_85 = (_zz_targets_0_bestRequest_id_84 ? _zz_targets_0_bestRequest_id_74 : _zz_targets_0_bestRequest_id_77);
  assign _zz_targets_0_bestRequest_id_86 = ((! _zz_targets_0_bestRequest_id_83) || (_zz_targets_0_bestRequest_id_80 && (_zz_targets_0_bestRequest_id_82 <= _zz_targets_0_bestRequest_id_79)));
  assign _zz_targets_0_bestRequest_priority_1 = (_zz_targets_0_bestRequest_id_86 ? _zz_targets_0_bestRequest_id_79 : _zz_targets_0_bestRequest_id_82);
  assign _zz_targets_0_bestRequest_id_87 = (_zz_targets_0_bestRequest_id_86 ? _zz_targets_0_bestRequest_id_80 : _zz_targets_0_bestRequest_id_83);
  assign _zz_targets_0_bestRequest_id_88 = ((! _zz_targets_0_bestRequest_id_87) || (_zz_targets_0_bestRequest_id_85 && (_zz_targets_0_bestRequest_priority_1 <= _zz_targets_0_bestRequest_priority)));
  assign _zz_targets_0_bestRequest_priority_2 = (_zz_targets_0_bestRequest_id_88 ? _zz_targets_0_bestRequest_priority : _zz_targets_0_bestRequest_priority_1);
  assign _zz_targets_0_bestRequest_valid = (_zz_targets_0_bestRequest_id_88 ? _zz_targets_0_bestRequest_id_85 : _zz_targets_0_bestRequest_id_87);
  assign _zz_targets_0_bestRequest_priority_3 = ((! targets_0_requests_32_valid) || (_zz_targets_0_bestRequest_valid && (targets_0_requests_32_priority <= _zz_targets_0_bestRequest_priority_2)));
  assign targets_0_iep = (targets_0_threshold < targets_0_bestRequest_priority);
  assign targets_0_claim = (targets_0_iep ? targets_0_bestRequest_id : 6'h0);
  assign targets_1_requests_0_priority = 2'b00;
  assign targets_1_requests_0_id = 6'h0;
  assign targets_1_requests_0_valid = 1'b1;
  assign targets_1_requests_1_priority = gateways_0_priority;
  assign targets_1_requests_1_id = 6'h01;
  assign targets_1_requests_1_valid = (gateways_0_ip && targets_1_ie_0);
  assign targets_1_requests_2_priority = gateways_1_priority;
  assign targets_1_requests_2_id = 6'h02;
  assign targets_1_requests_2_valid = (gateways_1_ip && targets_1_ie_1);
  assign targets_1_requests_3_priority = gateways_2_priority;
  assign targets_1_requests_3_id = 6'h03;
  assign targets_1_requests_3_valid = (gateways_2_ip && targets_1_ie_2);
  assign targets_1_requests_4_priority = gateways_3_priority;
  assign targets_1_requests_4_id = 6'h04;
  assign targets_1_requests_4_valid = (gateways_3_ip && targets_1_ie_3);
  assign targets_1_requests_5_priority = gateways_4_priority;
  assign targets_1_requests_5_id = 6'h05;
  assign targets_1_requests_5_valid = (gateways_4_ip && targets_1_ie_4);
  assign targets_1_requests_6_priority = gateways_5_priority;
  assign targets_1_requests_6_id = 6'h06;
  assign targets_1_requests_6_valid = (gateways_5_ip && targets_1_ie_5);
  assign targets_1_requests_7_priority = gateways_6_priority;
  assign targets_1_requests_7_id = 6'h07;
  assign targets_1_requests_7_valid = (gateways_6_ip && targets_1_ie_6);
  assign targets_1_requests_8_priority = gateways_7_priority;
  assign targets_1_requests_8_id = 6'h08;
  assign targets_1_requests_8_valid = (gateways_7_ip && targets_1_ie_7);
  assign targets_1_requests_9_priority = gateways_8_priority;
  assign targets_1_requests_9_id = 6'h09;
  assign targets_1_requests_9_valid = (gateways_8_ip && targets_1_ie_8);
  assign targets_1_requests_10_priority = gateways_9_priority;
  assign targets_1_requests_10_id = 6'h0a;
  assign targets_1_requests_10_valid = (gateways_9_ip && targets_1_ie_9);
  assign targets_1_requests_11_priority = gateways_10_priority;
  assign targets_1_requests_11_id = 6'h0b;
  assign targets_1_requests_11_valid = (gateways_10_ip && targets_1_ie_10);
  assign targets_1_requests_12_priority = gateways_11_priority;
  assign targets_1_requests_12_id = 6'h0c;
  assign targets_1_requests_12_valid = (gateways_11_ip && targets_1_ie_11);
  assign targets_1_requests_13_priority = gateways_12_priority;
  assign targets_1_requests_13_id = 6'h0d;
  assign targets_1_requests_13_valid = (gateways_12_ip && targets_1_ie_12);
  assign targets_1_requests_14_priority = gateways_13_priority;
  assign targets_1_requests_14_id = 6'h0e;
  assign targets_1_requests_14_valid = (gateways_13_ip && targets_1_ie_13);
  assign targets_1_requests_15_priority = gateways_14_priority;
  assign targets_1_requests_15_id = 6'h0f;
  assign targets_1_requests_15_valid = (gateways_14_ip && targets_1_ie_14);
  assign targets_1_requests_16_priority = gateways_15_priority;
  assign targets_1_requests_16_id = 6'h10;
  assign targets_1_requests_16_valid = (gateways_15_ip && targets_1_ie_15);
  assign targets_1_requests_17_priority = gateways_16_priority;
  assign targets_1_requests_17_id = 6'h11;
  assign targets_1_requests_17_valid = (gateways_16_ip && targets_1_ie_16);
  assign targets_1_requests_18_priority = gateways_17_priority;
  assign targets_1_requests_18_id = 6'h12;
  assign targets_1_requests_18_valid = (gateways_17_ip && targets_1_ie_17);
  assign targets_1_requests_19_priority = gateways_18_priority;
  assign targets_1_requests_19_id = 6'h13;
  assign targets_1_requests_19_valid = (gateways_18_ip && targets_1_ie_18);
  assign targets_1_requests_20_priority = gateways_19_priority;
  assign targets_1_requests_20_id = 6'h14;
  assign targets_1_requests_20_valid = (gateways_19_ip && targets_1_ie_19);
  assign targets_1_requests_21_priority = gateways_20_priority;
  assign targets_1_requests_21_id = 6'h15;
  assign targets_1_requests_21_valid = (gateways_20_ip && targets_1_ie_20);
  assign targets_1_requests_22_priority = gateways_21_priority;
  assign targets_1_requests_22_id = 6'h16;
  assign targets_1_requests_22_valid = (gateways_21_ip && targets_1_ie_21);
  assign targets_1_requests_23_priority = gateways_22_priority;
  assign targets_1_requests_23_id = 6'h17;
  assign targets_1_requests_23_valid = (gateways_22_ip && targets_1_ie_22);
  assign targets_1_requests_24_priority = gateways_23_priority;
  assign targets_1_requests_24_id = 6'h18;
  assign targets_1_requests_24_valid = (gateways_23_ip && targets_1_ie_23);
  assign targets_1_requests_25_priority = gateways_24_priority;
  assign targets_1_requests_25_id = 6'h19;
  assign targets_1_requests_25_valid = (gateways_24_ip && targets_1_ie_24);
  assign targets_1_requests_26_priority = gateways_25_priority;
  assign targets_1_requests_26_id = 6'h1a;
  assign targets_1_requests_26_valid = (gateways_25_ip && targets_1_ie_25);
  assign targets_1_requests_27_priority = gateways_26_priority;
  assign targets_1_requests_27_id = 6'h1b;
  assign targets_1_requests_27_valid = (gateways_26_ip && targets_1_ie_26);
  assign targets_1_requests_28_priority = gateways_27_priority;
  assign targets_1_requests_28_id = 6'h1c;
  assign targets_1_requests_28_valid = (gateways_27_ip && targets_1_ie_27);
  assign targets_1_requests_29_priority = gateways_28_priority;
  assign targets_1_requests_29_id = 6'h1d;
  assign targets_1_requests_29_valid = (gateways_28_ip && targets_1_ie_28);
  assign targets_1_requests_30_priority = gateways_29_priority;
  assign targets_1_requests_30_id = 6'h1e;
  assign targets_1_requests_30_valid = (gateways_29_ip && targets_1_ie_29);
  assign targets_1_requests_31_priority = gateways_30_priority;
  assign targets_1_requests_31_id = 6'h1f;
  assign targets_1_requests_31_valid = (gateways_30_ip && targets_1_ie_30);
  assign targets_1_requests_32_priority = gateways_31_priority;
  assign targets_1_requests_32_id = 6'h20;
  assign targets_1_requests_32_valid = (gateways_31_ip && targets_1_ie_31);
  assign _zz_targets_1_bestRequest_id = ((! targets_1_requests_1_valid) || (targets_1_requests_0_valid && (targets_1_requests_1_priority <= targets_1_requests_0_priority)));
  assign _zz_targets_1_bestRequest_id_1 = (_zz_targets_1_bestRequest_id ? targets_1_requests_0_priority : targets_1_requests_1_priority);
  assign _zz_targets_1_bestRequest_id_2 = (_zz_targets_1_bestRequest_id ? targets_1_requests_0_valid : targets_1_requests_1_valid);
  assign _zz_targets_1_bestRequest_id_3 = ((! targets_1_requests_3_valid) || (targets_1_requests_2_valid && (targets_1_requests_3_priority <= targets_1_requests_2_priority)));
  assign _zz_targets_1_bestRequest_id_4 = (_zz_targets_1_bestRequest_id_3 ? targets_1_requests_2_priority : targets_1_requests_3_priority);
  assign _zz_targets_1_bestRequest_id_5 = (_zz_targets_1_bestRequest_id_3 ? targets_1_requests_2_valid : targets_1_requests_3_valid);
  assign _zz_targets_1_bestRequest_id_6 = ((! targets_1_requests_5_valid) || (targets_1_requests_4_valid && (targets_1_requests_5_priority <= targets_1_requests_4_priority)));
  assign _zz_targets_1_bestRequest_id_7 = (_zz_targets_1_bestRequest_id_6 ? targets_1_requests_4_priority : targets_1_requests_5_priority);
  assign _zz_targets_1_bestRequest_id_8 = (_zz_targets_1_bestRequest_id_6 ? targets_1_requests_4_valid : targets_1_requests_5_valid);
  assign _zz_targets_1_bestRequest_id_9 = ((! targets_1_requests_7_valid) || (targets_1_requests_6_valid && (targets_1_requests_7_priority <= targets_1_requests_6_priority)));
  assign _zz_targets_1_bestRequest_id_10 = (_zz_targets_1_bestRequest_id_9 ? targets_1_requests_6_priority : targets_1_requests_7_priority);
  assign _zz_targets_1_bestRequest_id_11 = (_zz_targets_1_bestRequest_id_9 ? targets_1_requests_6_valid : targets_1_requests_7_valid);
  assign _zz_targets_1_bestRequest_id_12 = ((! targets_1_requests_9_valid) || (targets_1_requests_8_valid && (targets_1_requests_9_priority <= targets_1_requests_8_priority)));
  assign _zz_targets_1_bestRequest_id_13 = (_zz_targets_1_bestRequest_id_12 ? targets_1_requests_8_priority : targets_1_requests_9_priority);
  assign _zz_targets_1_bestRequest_id_14 = (_zz_targets_1_bestRequest_id_12 ? targets_1_requests_8_valid : targets_1_requests_9_valid);
  assign _zz_targets_1_bestRequest_id_15 = ((! targets_1_requests_11_valid) || (targets_1_requests_10_valid && (targets_1_requests_11_priority <= targets_1_requests_10_priority)));
  assign _zz_targets_1_bestRequest_id_16 = (_zz_targets_1_bestRequest_id_15 ? targets_1_requests_10_priority : targets_1_requests_11_priority);
  assign _zz_targets_1_bestRequest_id_17 = (_zz_targets_1_bestRequest_id_15 ? targets_1_requests_10_valid : targets_1_requests_11_valid);
  assign _zz_targets_1_bestRequest_id_18 = ((! targets_1_requests_13_valid) || (targets_1_requests_12_valid && (targets_1_requests_13_priority <= targets_1_requests_12_priority)));
  assign _zz_targets_1_bestRequest_id_19 = (_zz_targets_1_bestRequest_id_18 ? targets_1_requests_12_priority : targets_1_requests_13_priority);
  assign _zz_targets_1_bestRequest_id_20 = (_zz_targets_1_bestRequest_id_18 ? targets_1_requests_12_valid : targets_1_requests_13_valid);
  assign _zz_targets_1_bestRequest_id_21 = ((! targets_1_requests_15_valid) || (targets_1_requests_14_valid && (targets_1_requests_15_priority <= targets_1_requests_14_priority)));
  assign _zz_targets_1_bestRequest_id_22 = (_zz_targets_1_bestRequest_id_21 ? targets_1_requests_14_priority : targets_1_requests_15_priority);
  assign _zz_targets_1_bestRequest_id_23 = (_zz_targets_1_bestRequest_id_21 ? targets_1_requests_14_valid : targets_1_requests_15_valid);
  assign _zz_targets_1_bestRequest_id_24 = ((! targets_1_requests_17_valid) || (targets_1_requests_16_valid && (targets_1_requests_17_priority <= targets_1_requests_16_priority)));
  assign _zz_targets_1_bestRequest_id_25 = (_zz_targets_1_bestRequest_id_24 ? targets_1_requests_16_priority : targets_1_requests_17_priority);
  assign _zz_targets_1_bestRequest_id_26 = (_zz_targets_1_bestRequest_id_24 ? targets_1_requests_16_valid : targets_1_requests_17_valid);
  assign _zz_targets_1_bestRequest_id_27 = ((! targets_1_requests_19_valid) || (targets_1_requests_18_valid && (targets_1_requests_19_priority <= targets_1_requests_18_priority)));
  assign _zz_targets_1_bestRequest_id_28 = (_zz_targets_1_bestRequest_id_27 ? targets_1_requests_18_priority : targets_1_requests_19_priority);
  assign _zz_targets_1_bestRequest_id_29 = (_zz_targets_1_bestRequest_id_27 ? targets_1_requests_18_valid : targets_1_requests_19_valid);
  assign _zz_targets_1_bestRequest_id_30 = ((! targets_1_requests_21_valid) || (targets_1_requests_20_valid && (targets_1_requests_21_priority <= targets_1_requests_20_priority)));
  assign _zz_targets_1_bestRequest_id_31 = (_zz_targets_1_bestRequest_id_30 ? targets_1_requests_20_priority : targets_1_requests_21_priority);
  assign _zz_targets_1_bestRequest_id_32 = (_zz_targets_1_bestRequest_id_30 ? targets_1_requests_20_valid : targets_1_requests_21_valid);
  assign _zz_targets_1_bestRequest_id_33 = ((! targets_1_requests_23_valid) || (targets_1_requests_22_valid && (targets_1_requests_23_priority <= targets_1_requests_22_priority)));
  assign _zz_targets_1_bestRequest_id_34 = (_zz_targets_1_bestRequest_id_33 ? targets_1_requests_22_priority : targets_1_requests_23_priority);
  assign _zz_targets_1_bestRequest_id_35 = (_zz_targets_1_bestRequest_id_33 ? targets_1_requests_22_valid : targets_1_requests_23_valid);
  assign _zz_targets_1_bestRequest_id_36 = ((! targets_1_requests_25_valid) || (targets_1_requests_24_valid && (targets_1_requests_25_priority <= targets_1_requests_24_priority)));
  assign _zz_targets_1_bestRequest_id_37 = (_zz_targets_1_bestRequest_id_36 ? targets_1_requests_24_priority : targets_1_requests_25_priority);
  assign _zz_targets_1_bestRequest_id_38 = (_zz_targets_1_bestRequest_id_36 ? targets_1_requests_24_valid : targets_1_requests_25_valid);
  assign _zz_targets_1_bestRequest_id_39 = ((! targets_1_requests_27_valid) || (targets_1_requests_26_valid && (targets_1_requests_27_priority <= targets_1_requests_26_priority)));
  assign _zz_targets_1_bestRequest_id_40 = (_zz_targets_1_bestRequest_id_39 ? targets_1_requests_26_priority : targets_1_requests_27_priority);
  assign _zz_targets_1_bestRequest_id_41 = (_zz_targets_1_bestRequest_id_39 ? targets_1_requests_26_valid : targets_1_requests_27_valid);
  assign _zz_targets_1_bestRequest_id_42 = ((! targets_1_requests_29_valid) || (targets_1_requests_28_valid && (targets_1_requests_29_priority <= targets_1_requests_28_priority)));
  assign _zz_targets_1_bestRequest_id_43 = (_zz_targets_1_bestRequest_id_42 ? targets_1_requests_28_priority : targets_1_requests_29_priority);
  assign _zz_targets_1_bestRequest_id_44 = (_zz_targets_1_bestRequest_id_42 ? targets_1_requests_28_valid : targets_1_requests_29_valid);
  assign _zz_targets_1_bestRequest_id_45 = ((! targets_1_requests_31_valid) || (targets_1_requests_30_valid && (targets_1_requests_31_priority <= targets_1_requests_30_priority)));
  assign _zz_targets_1_bestRequest_id_46 = (_zz_targets_1_bestRequest_id_45 ? targets_1_requests_30_priority : targets_1_requests_31_priority);
  assign _zz_targets_1_bestRequest_id_47 = (_zz_targets_1_bestRequest_id_45 ? targets_1_requests_30_valid : targets_1_requests_31_valid);
  assign _zz_targets_1_bestRequest_id_48 = ((! _zz_targets_1_bestRequest_id_5) || (_zz_targets_1_bestRequest_id_2 && (_zz_targets_1_bestRequest_id_4 <= _zz_targets_1_bestRequest_id_1)));
  assign _zz_targets_1_bestRequest_id_49 = (_zz_targets_1_bestRequest_id_48 ? _zz_targets_1_bestRequest_id_1 : _zz_targets_1_bestRequest_id_4);
  assign _zz_targets_1_bestRequest_id_50 = (_zz_targets_1_bestRequest_id_48 ? _zz_targets_1_bestRequest_id_2 : _zz_targets_1_bestRequest_id_5);
  assign _zz_targets_1_bestRequest_id_51 = ((! _zz_targets_1_bestRequest_id_11) || (_zz_targets_1_bestRequest_id_8 && (_zz_targets_1_bestRequest_id_10 <= _zz_targets_1_bestRequest_id_7)));
  assign _zz_targets_1_bestRequest_id_52 = (_zz_targets_1_bestRequest_id_51 ? _zz_targets_1_bestRequest_id_7 : _zz_targets_1_bestRequest_id_10);
  assign _zz_targets_1_bestRequest_id_53 = (_zz_targets_1_bestRequest_id_51 ? _zz_targets_1_bestRequest_id_8 : _zz_targets_1_bestRequest_id_11);
  assign _zz_targets_1_bestRequest_id_54 = ((! _zz_targets_1_bestRequest_id_17) || (_zz_targets_1_bestRequest_id_14 && (_zz_targets_1_bestRequest_id_16 <= _zz_targets_1_bestRequest_id_13)));
  assign _zz_targets_1_bestRequest_id_55 = (_zz_targets_1_bestRequest_id_54 ? _zz_targets_1_bestRequest_id_13 : _zz_targets_1_bestRequest_id_16);
  assign _zz_targets_1_bestRequest_id_56 = (_zz_targets_1_bestRequest_id_54 ? _zz_targets_1_bestRequest_id_14 : _zz_targets_1_bestRequest_id_17);
  assign _zz_targets_1_bestRequest_id_57 = ((! _zz_targets_1_bestRequest_id_23) || (_zz_targets_1_bestRequest_id_20 && (_zz_targets_1_bestRequest_id_22 <= _zz_targets_1_bestRequest_id_19)));
  assign _zz_targets_1_bestRequest_id_58 = (_zz_targets_1_bestRequest_id_57 ? _zz_targets_1_bestRequest_id_19 : _zz_targets_1_bestRequest_id_22);
  assign _zz_targets_1_bestRequest_id_59 = (_zz_targets_1_bestRequest_id_57 ? _zz_targets_1_bestRequest_id_20 : _zz_targets_1_bestRequest_id_23);
  assign _zz_targets_1_bestRequest_id_60 = ((! _zz_targets_1_bestRequest_id_29) || (_zz_targets_1_bestRequest_id_26 && (_zz_targets_1_bestRequest_id_28 <= _zz_targets_1_bestRequest_id_25)));
  assign _zz_targets_1_bestRequest_id_61 = (_zz_targets_1_bestRequest_id_60 ? _zz_targets_1_bestRequest_id_25 : _zz_targets_1_bestRequest_id_28);
  assign _zz_targets_1_bestRequest_id_62 = (_zz_targets_1_bestRequest_id_60 ? _zz_targets_1_bestRequest_id_26 : _zz_targets_1_bestRequest_id_29);
  assign _zz_targets_1_bestRequest_id_63 = ((! _zz_targets_1_bestRequest_id_35) || (_zz_targets_1_bestRequest_id_32 && (_zz_targets_1_bestRequest_id_34 <= _zz_targets_1_bestRequest_id_31)));
  assign _zz_targets_1_bestRequest_id_64 = (_zz_targets_1_bestRequest_id_63 ? _zz_targets_1_bestRequest_id_31 : _zz_targets_1_bestRequest_id_34);
  assign _zz_targets_1_bestRequest_id_65 = (_zz_targets_1_bestRequest_id_63 ? _zz_targets_1_bestRequest_id_32 : _zz_targets_1_bestRequest_id_35);
  assign _zz_targets_1_bestRequest_id_66 = ((! _zz_targets_1_bestRequest_id_41) || (_zz_targets_1_bestRequest_id_38 && (_zz_targets_1_bestRequest_id_40 <= _zz_targets_1_bestRequest_id_37)));
  assign _zz_targets_1_bestRequest_id_67 = (_zz_targets_1_bestRequest_id_66 ? _zz_targets_1_bestRequest_id_37 : _zz_targets_1_bestRequest_id_40);
  assign _zz_targets_1_bestRequest_id_68 = (_zz_targets_1_bestRequest_id_66 ? _zz_targets_1_bestRequest_id_38 : _zz_targets_1_bestRequest_id_41);
  assign _zz_targets_1_bestRequest_id_69 = ((! _zz_targets_1_bestRequest_id_47) || (_zz_targets_1_bestRequest_id_44 && (_zz_targets_1_bestRequest_id_46 <= _zz_targets_1_bestRequest_id_43)));
  assign _zz_targets_1_bestRequest_id_70 = (_zz_targets_1_bestRequest_id_69 ? _zz_targets_1_bestRequest_id_43 : _zz_targets_1_bestRequest_id_46);
  assign _zz_targets_1_bestRequest_id_71 = (_zz_targets_1_bestRequest_id_69 ? _zz_targets_1_bestRequest_id_44 : _zz_targets_1_bestRequest_id_47);
  assign _zz_targets_1_bestRequest_id_72 = ((! _zz_targets_1_bestRequest_id_53) || (_zz_targets_1_bestRequest_id_50 && (_zz_targets_1_bestRequest_id_52 <= _zz_targets_1_bestRequest_id_49)));
  assign _zz_targets_1_bestRequest_id_73 = (_zz_targets_1_bestRequest_id_72 ? _zz_targets_1_bestRequest_id_49 : _zz_targets_1_bestRequest_id_52);
  assign _zz_targets_1_bestRequest_id_74 = (_zz_targets_1_bestRequest_id_72 ? _zz_targets_1_bestRequest_id_50 : _zz_targets_1_bestRequest_id_53);
  assign _zz_targets_1_bestRequest_id_75 = ((! _zz_targets_1_bestRequest_id_59) || (_zz_targets_1_bestRequest_id_56 && (_zz_targets_1_bestRequest_id_58 <= _zz_targets_1_bestRequest_id_55)));
  assign _zz_targets_1_bestRequest_id_76 = (_zz_targets_1_bestRequest_id_75 ? _zz_targets_1_bestRequest_id_55 : _zz_targets_1_bestRequest_id_58);
  assign _zz_targets_1_bestRequest_id_77 = (_zz_targets_1_bestRequest_id_75 ? _zz_targets_1_bestRequest_id_56 : _zz_targets_1_bestRequest_id_59);
  assign _zz_targets_1_bestRequest_id_78 = ((! _zz_targets_1_bestRequest_id_65) || (_zz_targets_1_bestRequest_id_62 && (_zz_targets_1_bestRequest_id_64 <= _zz_targets_1_bestRequest_id_61)));
  assign _zz_targets_1_bestRequest_id_79 = (_zz_targets_1_bestRequest_id_78 ? _zz_targets_1_bestRequest_id_61 : _zz_targets_1_bestRequest_id_64);
  assign _zz_targets_1_bestRequest_id_80 = (_zz_targets_1_bestRequest_id_78 ? _zz_targets_1_bestRequest_id_62 : _zz_targets_1_bestRequest_id_65);
  assign _zz_targets_1_bestRequest_id_81 = ((! _zz_targets_1_bestRequest_id_71) || (_zz_targets_1_bestRequest_id_68 && (_zz_targets_1_bestRequest_id_70 <= _zz_targets_1_bestRequest_id_67)));
  assign _zz_targets_1_bestRequest_id_82 = (_zz_targets_1_bestRequest_id_81 ? _zz_targets_1_bestRequest_id_67 : _zz_targets_1_bestRequest_id_70);
  assign _zz_targets_1_bestRequest_id_83 = (_zz_targets_1_bestRequest_id_81 ? _zz_targets_1_bestRequest_id_68 : _zz_targets_1_bestRequest_id_71);
  assign _zz_targets_1_bestRequest_id_84 = ((! _zz_targets_1_bestRequest_id_77) || (_zz_targets_1_bestRequest_id_74 && (_zz_targets_1_bestRequest_id_76 <= _zz_targets_1_bestRequest_id_73)));
  assign _zz_targets_1_bestRequest_priority = (_zz_targets_1_bestRequest_id_84 ? _zz_targets_1_bestRequest_id_73 : _zz_targets_1_bestRequest_id_76);
  assign _zz_targets_1_bestRequest_id_85 = (_zz_targets_1_bestRequest_id_84 ? _zz_targets_1_bestRequest_id_74 : _zz_targets_1_bestRequest_id_77);
  assign _zz_targets_1_bestRequest_id_86 = ((! _zz_targets_1_bestRequest_id_83) || (_zz_targets_1_bestRequest_id_80 && (_zz_targets_1_bestRequest_id_82 <= _zz_targets_1_bestRequest_id_79)));
  assign _zz_targets_1_bestRequest_priority_1 = (_zz_targets_1_bestRequest_id_86 ? _zz_targets_1_bestRequest_id_79 : _zz_targets_1_bestRequest_id_82);
  assign _zz_targets_1_bestRequest_id_87 = (_zz_targets_1_bestRequest_id_86 ? _zz_targets_1_bestRequest_id_80 : _zz_targets_1_bestRequest_id_83);
  assign _zz_targets_1_bestRequest_id_88 = ((! _zz_targets_1_bestRequest_id_87) || (_zz_targets_1_bestRequest_id_85 && (_zz_targets_1_bestRequest_priority_1 <= _zz_targets_1_bestRequest_priority)));
  assign _zz_targets_1_bestRequest_priority_2 = (_zz_targets_1_bestRequest_id_88 ? _zz_targets_1_bestRequest_priority : _zz_targets_1_bestRequest_priority_1);
  assign _zz_targets_1_bestRequest_valid = (_zz_targets_1_bestRequest_id_88 ? _zz_targets_1_bestRequest_id_85 : _zz_targets_1_bestRequest_id_87);
  assign _zz_targets_1_bestRequest_priority_3 = ((! targets_1_requests_32_valid) || (_zz_targets_1_bestRequest_valid && (targets_1_requests_32_priority <= _zz_targets_1_bestRequest_priority_2)));
  assign targets_1_iep = (targets_1_threshold < targets_1_bestRequest_priority);
  assign targets_1_claim = (targets_1_iep ? targets_1_bestRequest_id : 6'h0);
  assign io_targets = {targets_1_iep,targets_0_iep};
  assign bus_readErrorFlag = 1'b0;
  assign bus_writeErrorFlag = 1'b0;
  always @(*) begin
    bus_readHaltRequest = 1'b0;
    if(when_PlicMapper_l122) begin
      bus_readHaltRequest = 1'b1;
    end
  end

  assign bus_writeHaltRequest = 1'b0;
  assign bus_writeOccur = (bus_writeJoinEvent_valid && bus_writeJoinEvent_ready);
  assign bus_writeJoinEvent_valid = (io_bus_aw_valid && io_bus_w_valid);
  assign io_bus_aw_ready = bus_writeOccur;
  assign io_bus_w_ready = bus_writeOccur;
  assign bus_writeJoinEvent_translated_valid = bus_writeJoinEvent_valid;
  assign bus_writeJoinEvent_ready = bus_writeJoinEvent_translated_ready;
  assign bus_writeJoinEvent_translated_payload_resp = bus_writeRsp_resp;
  assign _zz_bus_writeJoinEvent_translated_ready = (! bus_writeHaltRequest);
  assign bus_writeJoinEvent_translated_haltWhen_valid = (bus_writeJoinEvent_translated_valid && _zz_bus_writeJoinEvent_translated_ready);
  assign bus_writeJoinEvent_translated_ready = (bus_writeJoinEvent_translated_haltWhen_ready && _zz_bus_writeJoinEvent_translated_ready);
  assign bus_writeJoinEvent_translated_haltWhen_payload_resp = bus_writeJoinEvent_translated_payload_resp;
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_fire = (bus_writeJoinEvent_translated_haltWhen_halfPipe_valid && bus_writeJoinEvent_translated_haltWhen_halfPipe_ready);
  assign bus_writeJoinEvent_translated_haltWhen_ready = (! bus_writeJoinEvent_translated_haltWhen_rValid);
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_valid = bus_writeJoinEvent_translated_haltWhen_rValid;
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp = bus_writeJoinEvent_translated_haltWhen_rData_resp;
  assign io_bus_b_valid = bus_writeJoinEvent_translated_haltWhen_halfPipe_valid;
  assign bus_writeJoinEvent_translated_haltWhen_halfPipe_ready = io_bus_b_ready;
  assign io_bus_b_payload_resp = bus_writeJoinEvent_translated_haltWhen_halfPipe_payload_resp;
  assign bus_readDataStage_fire = (bus_readDataStage_valid && bus_readDataStage_ready);
  assign io_bus_ar_ready = (! io_bus_ar_rValid);
  assign bus_readDataStage_valid = io_bus_ar_rValid;
  assign bus_readDataStage_payload_addr = io_bus_ar_rData_addr;
  assign bus_readDataStage_payload_prot = io_bus_ar_rData_prot;
  assign _zz_bus_readDataStage_ready = (! bus_readHaltRequest);
  assign bus_readDataStage_haltWhen_valid = (bus_readDataStage_valid && _zz_bus_readDataStage_ready);
  assign bus_readDataStage_ready = (bus_readDataStage_haltWhen_ready && _zz_bus_readDataStage_ready);
  assign bus_readDataStage_haltWhen_payload_addr = bus_readDataStage_payload_addr;
  assign bus_readDataStage_haltWhen_payload_prot = bus_readDataStage_payload_prot;
  assign bus_readDataStage_haltWhen_translated_valid = bus_readDataStage_haltWhen_valid;
  assign bus_readDataStage_haltWhen_ready = bus_readDataStage_haltWhen_translated_ready;
  assign bus_readDataStage_haltWhen_translated_payload_data = bus_readRsp_data;
  assign bus_readDataStage_haltWhen_translated_payload_resp = bus_readRsp_resp;
  assign io_bus_r_valid = bus_readDataStage_haltWhen_translated_valid;
  assign bus_readDataStage_haltWhen_translated_ready = io_bus_r_ready;
  assign io_bus_r_payload_data = bus_readDataStage_haltWhen_translated_payload_data;
  assign io_bus_r_payload_resp = bus_readDataStage_haltWhen_translated_payload_resp;
  always @(*) begin
    if(bus_writeErrorFlag) begin
      bus_writeRsp_resp = 2'b10;
    end else begin
      bus_writeRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    if(bus_readErrorFlag) begin
      bus_readRsp_resp = 2'b10;
    end else begin
      bus_readRsp_resp = 2'b00;
    end
  end

  always @(*) begin
    bus_readRsp_data = 32'h0;
    case(bus_readAddressMasked)
      22'h000004 : begin
        bus_readRsp_data[1 : 0] = gateways_0_priority;
      end
      22'h001000 : begin
        bus_readRsp_data[1 : 1] = gateways_0_ip;
        bus_readRsp_data[2 : 2] = gateways_1_ip;
        bus_readRsp_data[3 : 3] = gateways_2_ip;
        bus_readRsp_data[4 : 4] = gateways_3_ip;
        bus_readRsp_data[5 : 5] = gateways_4_ip;
        bus_readRsp_data[6 : 6] = gateways_5_ip;
        bus_readRsp_data[7 : 7] = gateways_6_ip;
        bus_readRsp_data[8 : 8] = gateways_7_ip;
        bus_readRsp_data[9 : 9] = gateways_8_ip;
        bus_readRsp_data[10 : 10] = gateways_9_ip;
        bus_readRsp_data[11 : 11] = gateways_10_ip;
        bus_readRsp_data[12 : 12] = gateways_11_ip;
        bus_readRsp_data[13 : 13] = gateways_12_ip;
        bus_readRsp_data[14 : 14] = gateways_13_ip;
        bus_readRsp_data[15 : 15] = gateways_14_ip;
        bus_readRsp_data[16 : 16] = gateways_15_ip;
        bus_readRsp_data[17 : 17] = gateways_16_ip;
        bus_readRsp_data[18 : 18] = gateways_17_ip;
        bus_readRsp_data[19 : 19] = gateways_18_ip;
        bus_readRsp_data[20 : 20] = gateways_19_ip;
        bus_readRsp_data[21 : 21] = gateways_20_ip;
        bus_readRsp_data[22 : 22] = gateways_21_ip;
        bus_readRsp_data[23 : 23] = gateways_22_ip;
        bus_readRsp_data[24 : 24] = gateways_23_ip;
        bus_readRsp_data[25 : 25] = gateways_24_ip;
        bus_readRsp_data[26 : 26] = gateways_25_ip;
        bus_readRsp_data[27 : 27] = gateways_26_ip;
        bus_readRsp_data[28 : 28] = gateways_27_ip;
        bus_readRsp_data[29 : 29] = gateways_28_ip;
        bus_readRsp_data[30 : 30] = gateways_29_ip;
        bus_readRsp_data[31 : 31] = gateways_30_ip;
      end
      22'h000008 : begin
        bus_readRsp_data[1 : 0] = gateways_1_priority;
      end
      22'h00000c : begin
        bus_readRsp_data[1 : 0] = gateways_2_priority;
      end
      22'h000010 : begin
        bus_readRsp_data[1 : 0] = gateways_3_priority;
      end
      22'h000014 : begin
        bus_readRsp_data[1 : 0] = gateways_4_priority;
      end
      22'h000018 : begin
        bus_readRsp_data[1 : 0] = gateways_5_priority;
      end
      22'h00001c : begin
        bus_readRsp_data[1 : 0] = gateways_6_priority;
      end
      22'h000020 : begin
        bus_readRsp_data[1 : 0] = gateways_7_priority;
      end
      22'h000024 : begin
        bus_readRsp_data[1 : 0] = gateways_8_priority;
      end
      22'h000028 : begin
        bus_readRsp_data[1 : 0] = gateways_9_priority;
      end
      22'h00002c : begin
        bus_readRsp_data[1 : 0] = gateways_10_priority;
      end
      22'h000030 : begin
        bus_readRsp_data[1 : 0] = gateways_11_priority;
      end
      22'h000034 : begin
        bus_readRsp_data[1 : 0] = gateways_12_priority;
      end
      22'h000038 : begin
        bus_readRsp_data[1 : 0] = gateways_13_priority;
      end
      22'h00003c : begin
        bus_readRsp_data[1 : 0] = gateways_14_priority;
      end
      22'h000040 : begin
        bus_readRsp_data[1 : 0] = gateways_15_priority;
      end
      22'h000044 : begin
        bus_readRsp_data[1 : 0] = gateways_16_priority;
      end
      22'h000048 : begin
        bus_readRsp_data[1 : 0] = gateways_17_priority;
      end
      22'h00004c : begin
        bus_readRsp_data[1 : 0] = gateways_18_priority;
      end
      22'h000050 : begin
        bus_readRsp_data[1 : 0] = gateways_19_priority;
      end
      22'h000054 : begin
        bus_readRsp_data[1 : 0] = gateways_20_priority;
      end
      22'h000058 : begin
        bus_readRsp_data[1 : 0] = gateways_21_priority;
      end
      22'h00005c : begin
        bus_readRsp_data[1 : 0] = gateways_22_priority;
      end
      22'h000060 : begin
        bus_readRsp_data[1 : 0] = gateways_23_priority;
      end
      22'h000064 : begin
        bus_readRsp_data[1 : 0] = gateways_24_priority;
      end
      22'h000068 : begin
        bus_readRsp_data[1 : 0] = gateways_25_priority;
      end
      22'h00006c : begin
        bus_readRsp_data[1 : 0] = gateways_26_priority;
      end
      22'h000070 : begin
        bus_readRsp_data[1 : 0] = gateways_27_priority;
      end
      22'h000074 : begin
        bus_readRsp_data[1 : 0] = gateways_28_priority;
      end
      22'h000078 : begin
        bus_readRsp_data[1 : 0] = gateways_29_priority;
      end
      22'h00007c : begin
        bus_readRsp_data[1 : 0] = gateways_30_priority;
      end
      22'h000080 : begin
        bus_readRsp_data[1 : 0] = gateways_31_priority;
      end
      22'h001004 : begin
        bus_readRsp_data[0 : 0] = gateways_31_ip;
      end
      22'h200000 : begin
        bus_readRsp_data[1 : 0] = targets_0_threshold;
      end
      22'h200004 : begin
        bus_readRsp_data[5 : 0] = targets_0_claim;
      end
      22'h002000 : begin
        bus_readRsp_data[1 : 1] = targets_0_ie_0;
        bus_readRsp_data[2 : 2] = targets_0_ie_1;
        bus_readRsp_data[3 : 3] = targets_0_ie_2;
        bus_readRsp_data[4 : 4] = targets_0_ie_3;
        bus_readRsp_data[5 : 5] = targets_0_ie_4;
        bus_readRsp_data[6 : 6] = targets_0_ie_5;
        bus_readRsp_data[7 : 7] = targets_0_ie_6;
        bus_readRsp_data[8 : 8] = targets_0_ie_7;
        bus_readRsp_data[9 : 9] = targets_0_ie_8;
        bus_readRsp_data[10 : 10] = targets_0_ie_9;
        bus_readRsp_data[11 : 11] = targets_0_ie_10;
        bus_readRsp_data[12 : 12] = targets_0_ie_11;
        bus_readRsp_data[13 : 13] = targets_0_ie_12;
        bus_readRsp_data[14 : 14] = targets_0_ie_13;
        bus_readRsp_data[15 : 15] = targets_0_ie_14;
        bus_readRsp_data[16 : 16] = targets_0_ie_15;
        bus_readRsp_data[17 : 17] = targets_0_ie_16;
        bus_readRsp_data[18 : 18] = targets_0_ie_17;
        bus_readRsp_data[19 : 19] = targets_0_ie_18;
        bus_readRsp_data[20 : 20] = targets_0_ie_19;
        bus_readRsp_data[21 : 21] = targets_0_ie_20;
        bus_readRsp_data[22 : 22] = targets_0_ie_21;
        bus_readRsp_data[23 : 23] = targets_0_ie_22;
        bus_readRsp_data[24 : 24] = targets_0_ie_23;
        bus_readRsp_data[25 : 25] = targets_0_ie_24;
        bus_readRsp_data[26 : 26] = targets_0_ie_25;
        bus_readRsp_data[27 : 27] = targets_0_ie_26;
        bus_readRsp_data[28 : 28] = targets_0_ie_27;
        bus_readRsp_data[29 : 29] = targets_0_ie_28;
        bus_readRsp_data[30 : 30] = targets_0_ie_29;
        bus_readRsp_data[31 : 31] = targets_0_ie_30;
      end
      22'h002004 : begin
        bus_readRsp_data[0 : 0] = targets_0_ie_31;
      end
      22'h201000 : begin
        bus_readRsp_data[1 : 0] = targets_1_threshold;
      end
      22'h201004 : begin
        bus_readRsp_data[5 : 0] = targets_1_claim;
      end
      22'h002080 : begin
        bus_readRsp_data[1 : 1] = targets_1_ie_0;
        bus_readRsp_data[2 : 2] = targets_1_ie_1;
        bus_readRsp_data[3 : 3] = targets_1_ie_2;
        bus_readRsp_data[4 : 4] = targets_1_ie_3;
        bus_readRsp_data[5 : 5] = targets_1_ie_4;
        bus_readRsp_data[6 : 6] = targets_1_ie_5;
        bus_readRsp_data[7 : 7] = targets_1_ie_6;
        bus_readRsp_data[8 : 8] = targets_1_ie_7;
        bus_readRsp_data[9 : 9] = targets_1_ie_8;
        bus_readRsp_data[10 : 10] = targets_1_ie_9;
        bus_readRsp_data[11 : 11] = targets_1_ie_10;
        bus_readRsp_data[12 : 12] = targets_1_ie_11;
        bus_readRsp_data[13 : 13] = targets_1_ie_12;
        bus_readRsp_data[14 : 14] = targets_1_ie_13;
        bus_readRsp_data[15 : 15] = targets_1_ie_14;
        bus_readRsp_data[16 : 16] = targets_1_ie_15;
        bus_readRsp_data[17 : 17] = targets_1_ie_16;
        bus_readRsp_data[18 : 18] = targets_1_ie_17;
        bus_readRsp_data[19 : 19] = targets_1_ie_18;
        bus_readRsp_data[20 : 20] = targets_1_ie_19;
        bus_readRsp_data[21 : 21] = targets_1_ie_20;
        bus_readRsp_data[22 : 22] = targets_1_ie_21;
        bus_readRsp_data[23 : 23] = targets_1_ie_22;
        bus_readRsp_data[24 : 24] = targets_1_ie_23;
        bus_readRsp_data[25 : 25] = targets_1_ie_24;
        bus_readRsp_data[26 : 26] = targets_1_ie_25;
        bus_readRsp_data[27 : 27] = targets_1_ie_26;
        bus_readRsp_data[28 : 28] = targets_1_ie_27;
        bus_readRsp_data[29 : 29] = targets_1_ie_28;
        bus_readRsp_data[30 : 30] = targets_1_ie_29;
        bus_readRsp_data[31 : 31] = targets_1_ie_30;
      end
      22'h002084 : begin
        bus_readRsp_data[0 : 0] = targets_1_ie_31;
      end
      default : begin
      end
    endcase
  end

  assign bus_readAddressMasked = (bus_readDataStage_payload_addr & (~ 22'h000003));
  assign bus_writeAddressMasked = (io_bus_aw_payload_addr & (~ 22'h000003));
  assign bus_readOccur = (io_bus_r_valid && io_bus_r_ready);
  assign gateways_0_priority = gateways_0_priority_driver;
  assign gateways_1_priority = gateways_1_priority_driver;
  assign gateways_2_priority = gateways_2_priority_driver;
  assign gateways_3_priority = gateways_3_priority_driver;
  assign gateways_4_priority = gateways_4_priority_driver;
  assign gateways_5_priority = gateways_5_priority_driver;
  assign gateways_6_priority = gateways_6_priority_driver;
  assign gateways_7_priority = gateways_7_priority_driver;
  assign gateways_8_priority = gateways_8_priority_driver;
  assign gateways_9_priority = gateways_9_priority_driver;
  assign gateways_10_priority = gateways_10_priority_driver;
  assign gateways_11_priority = gateways_11_priority_driver;
  assign gateways_12_priority = gateways_12_priority_driver;
  assign gateways_13_priority = gateways_13_priority_driver;
  assign gateways_14_priority = gateways_14_priority_driver;
  assign gateways_15_priority = gateways_15_priority_driver;
  assign gateways_16_priority = gateways_16_priority_driver;
  assign gateways_17_priority = gateways_17_priority_driver;
  assign gateways_18_priority = gateways_18_priority_driver;
  assign gateways_19_priority = gateways_19_priority_driver;
  assign gateways_20_priority = gateways_20_priority_driver;
  assign gateways_21_priority = gateways_21_priority_driver;
  assign gateways_22_priority = gateways_22_priority_driver;
  assign gateways_23_priority = gateways_23_priority_driver;
  assign gateways_24_priority = gateways_24_priority_driver;
  assign gateways_25_priority = gateways_25_priority_driver;
  assign gateways_26_priority = gateways_26_priority_driver;
  assign gateways_27_priority = gateways_27_priority_driver;
  assign gateways_28_priority = gateways_28_priority_driver;
  assign gateways_29_priority = gateways_29_priority_driver;
  assign gateways_30_priority = gateways_30_priority_driver;
  assign gateways_31_priority = gateways_31_priority_driver;
  always @(*) begin
    mapping_claim_valid = 1'b0;
    case(bus_readAddressMasked)
      22'h200004 : begin
        if(bus_readOccur) begin
          mapping_claim_valid = 1'b1;
        end
      end
      22'h201004 : begin
        if(bus_readOccur) begin
          mapping_claim_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mapping_claim_payload = 6'bxxxxxx;
    case(bus_readAddressMasked)
      22'h200004 : begin
        if(bus_readOccur) begin
          mapping_claim_payload = targets_0_claim;
        end
      end
      22'h201004 : begin
        if(bus_readOccur) begin
          mapping_claim_payload = targets_1_claim;
        end
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mapping_completion_valid = 1'b0;
    if(mapping_targetMapping_0_targetCompletion_valid) begin
      mapping_completion_valid = 1'b1;
    end
    if(mapping_targetMapping_1_targetCompletion_valid) begin
      mapping_completion_valid = 1'b1;
    end
  end

  always @(*) begin
    mapping_completion_payload = 6'bxxxxxx;
    if(mapping_targetMapping_0_targetCompletion_valid) begin
      mapping_completion_payload = mapping_targetMapping_0_targetCompletion_payload;
    end
    if(mapping_targetMapping_1_targetCompletion_valid) begin
      mapping_completion_payload = mapping_targetMapping_1_targetCompletion_payload;
    end
  end

  always @(*) begin
    mapping_coherencyStall_willIncrement = 1'b0;
    if(when_PlicMapper_l122) begin
      mapping_coherencyStall_willIncrement = 1'b1;
    end
    if(when_AxiLite4SlaveFactory_l68) begin
      if(bus_writeJoinEvent_valid) begin
        mapping_coherencyStall_willIncrement = 1'b1;
      end
    end
    if(when_AxiLite4SlaveFactory_l86) begin
      if(bus_readDataStage_valid) begin
        mapping_coherencyStall_willIncrement = 1'b1;
      end
    end
  end

  assign mapping_coherencyStall_willClear = 1'b0;
  assign mapping_coherencyStall_willOverflowIfInc = (mapping_coherencyStall_value == 1'b1);
  assign mapping_coherencyStall_willOverflow = (mapping_coherencyStall_willOverflowIfInc && mapping_coherencyStall_willIncrement);
  always @(*) begin
    mapping_coherencyStall_valueNext = (mapping_coherencyStall_value + mapping_coherencyStall_willIncrement);
    if(mapping_coherencyStall_willClear) begin
      mapping_coherencyStall_valueNext = 1'b0;
    end
  end

  assign when_PlicMapper_l122 = (mapping_coherencyStall_value != 1'b0);
  assign targets_0_threshold = targets_0_threshold_driver;
  always @(*) begin
    mapping_targetMapping_0_targetCompletion_valid = 1'b0;
    case(bus_writeAddressMasked)
      22'h200004 : begin
        if(bus_writeOccur) begin
          mapping_targetMapping_0_targetCompletion_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign targets_0_ie_0 = targets_0_ie_0_driver;
  assign targets_0_ie_1 = targets_0_ie_1_driver;
  assign targets_0_ie_2 = targets_0_ie_2_driver;
  assign targets_0_ie_3 = targets_0_ie_3_driver;
  assign targets_0_ie_4 = targets_0_ie_4_driver;
  assign targets_0_ie_5 = targets_0_ie_5_driver;
  assign targets_0_ie_6 = targets_0_ie_6_driver;
  assign targets_0_ie_7 = targets_0_ie_7_driver;
  assign targets_0_ie_8 = targets_0_ie_8_driver;
  assign targets_0_ie_9 = targets_0_ie_9_driver;
  assign targets_0_ie_10 = targets_0_ie_10_driver;
  assign targets_0_ie_11 = targets_0_ie_11_driver;
  assign targets_0_ie_12 = targets_0_ie_12_driver;
  assign targets_0_ie_13 = targets_0_ie_13_driver;
  assign targets_0_ie_14 = targets_0_ie_14_driver;
  assign targets_0_ie_15 = targets_0_ie_15_driver;
  assign targets_0_ie_16 = targets_0_ie_16_driver;
  assign targets_0_ie_17 = targets_0_ie_17_driver;
  assign targets_0_ie_18 = targets_0_ie_18_driver;
  assign targets_0_ie_19 = targets_0_ie_19_driver;
  assign targets_0_ie_20 = targets_0_ie_20_driver;
  assign targets_0_ie_21 = targets_0_ie_21_driver;
  assign targets_0_ie_22 = targets_0_ie_22_driver;
  assign targets_0_ie_23 = targets_0_ie_23_driver;
  assign targets_0_ie_24 = targets_0_ie_24_driver;
  assign targets_0_ie_25 = targets_0_ie_25_driver;
  assign targets_0_ie_26 = targets_0_ie_26_driver;
  assign targets_0_ie_27 = targets_0_ie_27_driver;
  assign targets_0_ie_28 = targets_0_ie_28_driver;
  assign targets_0_ie_29 = targets_0_ie_29_driver;
  assign targets_0_ie_30 = targets_0_ie_30_driver;
  assign targets_0_ie_31 = targets_0_ie_31_driver;
  assign targets_1_threshold = targets_1_threshold_driver;
  always @(*) begin
    mapping_targetMapping_1_targetCompletion_valid = 1'b0;
    case(bus_writeAddressMasked)
      22'h201004 : begin
        if(bus_writeOccur) begin
          mapping_targetMapping_1_targetCompletion_valid = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign targets_1_ie_0 = targets_1_ie_0_driver;
  assign targets_1_ie_1 = targets_1_ie_1_driver;
  assign targets_1_ie_2 = targets_1_ie_2_driver;
  assign targets_1_ie_3 = targets_1_ie_3_driver;
  assign targets_1_ie_4 = targets_1_ie_4_driver;
  assign targets_1_ie_5 = targets_1_ie_5_driver;
  assign targets_1_ie_6 = targets_1_ie_6_driver;
  assign targets_1_ie_7 = targets_1_ie_7_driver;
  assign targets_1_ie_8 = targets_1_ie_8_driver;
  assign targets_1_ie_9 = targets_1_ie_9_driver;
  assign targets_1_ie_10 = targets_1_ie_10_driver;
  assign targets_1_ie_11 = targets_1_ie_11_driver;
  assign targets_1_ie_12 = targets_1_ie_12_driver;
  assign targets_1_ie_13 = targets_1_ie_13_driver;
  assign targets_1_ie_14 = targets_1_ie_14_driver;
  assign targets_1_ie_15 = targets_1_ie_15_driver;
  assign targets_1_ie_16 = targets_1_ie_16_driver;
  assign targets_1_ie_17 = targets_1_ie_17_driver;
  assign targets_1_ie_18 = targets_1_ie_18_driver;
  assign targets_1_ie_19 = targets_1_ie_19_driver;
  assign targets_1_ie_20 = targets_1_ie_20_driver;
  assign targets_1_ie_21 = targets_1_ie_21_driver;
  assign targets_1_ie_22 = targets_1_ie_22_driver;
  assign targets_1_ie_23 = targets_1_ie_23_driver;
  assign targets_1_ie_24 = targets_1_ie_24_driver;
  assign targets_1_ie_25 = targets_1_ie_25_driver;
  assign targets_1_ie_26 = targets_1_ie_26_driver;
  assign targets_1_ie_27 = targets_1_ie_27_driver;
  assign targets_1_ie_28 = targets_1_ie_28_driver;
  assign targets_1_ie_29 = targets_1_ie_29_driver;
  assign targets_1_ie_30 = targets_1_ie_30_driver;
  assign targets_1_ie_31 = targets_1_ie_31_driver;
  assign mapping_targetMapping_0_targetCompletion_payload = io_bus_w_payload_data[5 : 0];
  assign mapping_targetMapping_1_targetCompletion_payload = io_bus_w_payload_data[5 : 0];
  assign when_AxiLite4SlaveFactory_l68 = 1'b1;
  assign when_AxiLite4SlaveFactory_l86 = 1'b1;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      gateways_0_ip <= 1'b0;
      gateways_0_waitCompletion <= 1'b0;
      gateways_1_ip <= 1'b0;
      gateways_1_waitCompletion <= 1'b0;
      gateways_2_ip <= 1'b0;
      gateways_2_waitCompletion <= 1'b0;
      gateways_3_ip <= 1'b0;
      gateways_3_waitCompletion <= 1'b0;
      gateways_4_ip <= 1'b0;
      gateways_4_waitCompletion <= 1'b0;
      gateways_5_ip <= 1'b0;
      gateways_5_waitCompletion <= 1'b0;
      gateways_6_ip <= 1'b0;
      gateways_6_waitCompletion <= 1'b0;
      gateways_7_ip <= 1'b0;
      gateways_7_waitCompletion <= 1'b0;
      gateways_8_ip <= 1'b0;
      gateways_8_waitCompletion <= 1'b0;
      gateways_9_ip <= 1'b0;
      gateways_9_waitCompletion <= 1'b0;
      gateways_10_ip <= 1'b0;
      gateways_10_waitCompletion <= 1'b0;
      gateways_11_ip <= 1'b0;
      gateways_11_waitCompletion <= 1'b0;
      gateways_12_ip <= 1'b0;
      gateways_12_waitCompletion <= 1'b0;
      gateways_13_ip <= 1'b0;
      gateways_13_waitCompletion <= 1'b0;
      gateways_14_ip <= 1'b0;
      gateways_14_waitCompletion <= 1'b0;
      gateways_15_ip <= 1'b0;
      gateways_15_waitCompletion <= 1'b0;
      gateways_16_ip <= 1'b0;
      gateways_16_waitCompletion <= 1'b0;
      gateways_17_ip <= 1'b0;
      gateways_17_waitCompletion <= 1'b0;
      gateways_18_ip <= 1'b0;
      gateways_18_waitCompletion <= 1'b0;
      gateways_19_ip <= 1'b0;
      gateways_19_waitCompletion <= 1'b0;
      gateways_20_ip <= 1'b0;
      gateways_20_waitCompletion <= 1'b0;
      gateways_21_ip <= 1'b0;
      gateways_21_waitCompletion <= 1'b0;
      gateways_22_ip <= 1'b0;
      gateways_22_waitCompletion <= 1'b0;
      gateways_23_ip <= 1'b0;
      gateways_23_waitCompletion <= 1'b0;
      gateways_24_ip <= 1'b0;
      gateways_24_waitCompletion <= 1'b0;
      gateways_25_ip <= 1'b0;
      gateways_25_waitCompletion <= 1'b0;
      gateways_26_ip <= 1'b0;
      gateways_26_waitCompletion <= 1'b0;
      gateways_27_ip <= 1'b0;
      gateways_27_waitCompletion <= 1'b0;
      gateways_28_ip <= 1'b0;
      gateways_28_waitCompletion <= 1'b0;
      gateways_29_ip <= 1'b0;
      gateways_29_waitCompletion <= 1'b0;
      gateways_30_ip <= 1'b0;
      gateways_30_waitCompletion <= 1'b0;
      gateways_31_ip <= 1'b0;
      gateways_31_waitCompletion <= 1'b0;
      bus_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      io_bus_ar_rValid <= 1'b0;
      gateways_0_priority_driver <= 2'b00;
      gateways_1_priority_driver <= 2'b00;
      gateways_2_priority_driver <= 2'b00;
      gateways_3_priority_driver <= 2'b00;
      gateways_4_priority_driver <= 2'b00;
      gateways_5_priority_driver <= 2'b00;
      gateways_6_priority_driver <= 2'b00;
      gateways_7_priority_driver <= 2'b00;
      gateways_8_priority_driver <= 2'b00;
      gateways_9_priority_driver <= 2'b00;
      gateways_10_priority_driver <= 2'b00;
      gateways_11_priority_driver <= 2'b00;
      gateways_12_priority_driver <= 2'b00;
      gateways_13_priority_driver <= 2'b00;
      gateways_14_priority_driver <= 2'b00;
      gateways_15_priority_driver <= 2'b00;
      gateways_16_priority_driver <= 2'b00;
      gateways_17_priority_driver <= 2'b00;
      gateways_18_priority_driver <= 2'b00;
      gateways_19_priority_driver <= 2'b00;
      gateways_20_priority_driver <= 2'b00;
      gateways_21_priority_driver <= 2'b00;
      gateways_22_priority_driver <= 2'b00;
      gateways_23_priority_driver <= 2'b00;
      gateways_24_priority_driver <= 2'b00;
      gateways_25_priority_driver <= 2'b00;
      gateways_26_priority_driver <= 2'b00;
      gateways_27_priority_driver <= 2'b00;
      gateways_28_priority_driver <= 2'b00;
      gateways_29_priority_driver <= 2'b00;
      gateways_30_priority_driver <= 2'b00;
      gateways_31_priority_driver <= 2'b00;
      mapping_coherencyStall_value <= 1'b0;
      targets_0_threshold_driver <= 2'b00;
      targets_0_ie_0_driver <= 1'b0;
      targets_0_ie_1_driver <= 1'b0;
      targets_0_ie_2_driver <= 1'b0;
      targets_0_ie_3_driver <= 1'b0;
      targets_0_ie_4_driver <= 1'b0;
      targets_0_ie_5_driver <= 1'b0;
      targets_0_ie_6_driver <= 1'b0;
      targets_0_ie_7_driver <= 1'b0;
      targets_0_ie_8_driver <= 1'b0;
      targets_0_ie_9_driver <= 1'b0;
      targets_0_ie_10_driver <= 1'b0;
      targets_0_ie_11_driver <= 1'b0;
      targets_0_ie_12_driver <= 1'b0;
      targets_0_ie_13_driver <= 1'b0;
      targets_0_ie_14_driver <= 1'b0;
      targets_0_ie_15_driver <= 1'b0;
      targets_0_ie_16_driver <= 1'b0;
      targets_0_ie_17_driver <= 1'b0;
      targets_0_ie_18_driver <= 1'b0;
      targets_0_ie_19_driver <= 1'b0;
      targets_0_ie_20_driver <= 1'b0;
      targets_0_ie_21_driver <= 1'b0;
      targets_0_ie_22_driver <= 1'b0;
      targets_0_ie_23_driver <= 1'b0;
      targets_0_ie_24_driver <= 1'b0;
      targets_0_ie_25_driver <= 1'b0;
      targets_0_ie_26_driver <= 1'b0;
      targets_0_ie_27_driver <= 1'b0;
      targets_0_ie_28_driver <= 1'b0;
      targets_0_ie_29_driver <= 1'b0;
      targets_0_ie_30_driver <= 1'b0;
      targets_0_ie_31_driver <= 1'b0;
      targets_1_threshold_driver <= 2'b00;
      targets_1_ie_0_driver <= 1'b0;
      targets_1_ie_1_driver <= 1'b0;
      targets_1_ie_2_driver <= 1'b0;
      targets_1_ie_3_driver <= 1'b0;
      targets_1_ie_4_driver <= 1'b0;
      targets_1_ie_5_driver <= 1'b0;
      targets_1_ie_6_driver <= 1'b0;
      targets_1_ie_7_driver <= 1'b0;
      targets_1_ie_8_driver <= 1'b0;
      targets_1_ie_9_driver <= 1'b0;
      targets_1_ie_10_driver <= 1'b0;
      targets_1_ie_11_driver <= 1'b0;
      targets_1_ie_12_driver <= 1'b0;
      targets_1_ie_13_driver <= 1'b0;
      targets_1_ie_14_driver <= 1'b0;
      targets_1_ie_15_driver <= 1'b0;
      targets_1_ie_16_driver <= 1'b0;
      targets_1_ie_17_driver <= 1'b0;
      targets_1_ie_18_driver <= 1'b0;
      targets_1_ie_19_driver <= 1'b0;
      targets_1_ie_20_driver <= 1'b0;
      targets_1_ie_21_driver <= 1'b0;
      targets_1_ie_22_driver <= 1'b0;
      targets_1_ie_23_driver <= 1'b0;
      targets_1_ie_24_driver <= 1'b0;
      targets_1_ie_25_driver <= 1'b0;
      targets_1_ie_26_driver <= 1'b0;
      targets_1_ie_27_driver <= 1'b0;
      targets_1_ie_28_driver <= 1'b0;
      targets_1_ie_29_driver <= 1'b0;
      targets_1_ie_30_driver <= 1'b0;
      targets_1_ie_31_driver <= 1'b0;
    end else begin
      if(when_PlicGateway_l21) begin
        gateways_0_ip <= _zz_gateways_0_ip;
        gateways_0_waitCompletion <= _zz_gateways_0_ip;
      end
      if(when_PlicGateway_l21_1) begin
        gateways_1_ip <= _zz_gateways_1_ip;
        gateways_1_waitCompletion <= _zz_gateways_1_ip;
      end
      if(when_PlicGateway_l21_2) begin
        gateways_2_ip <= _zz_gateways_2_ip;
        gateways_2_waitCompletion <= _zz_gateways_2_ip;
      end
      if(when_PlicGateway_l21_3) begin
        gateways_3_ip <= _zz_gateways_3_ip;
        gateways_3_waitCompletion <= _zz_gateways_3_ip;
      end
      if(when_PlicGateway_l21_4) begin
        gateways_4_ip <= _zz_gateways_4_ip;
        gateways_4_waitCompletion <= _zz_gateways_4_ip;
      end
      if(when_PlicGateway_l21_5) begin
        gateways_5_ip <= _zz_gateways_5_ip;
        gateways_5_waitCompletion <= _zz_gateways_5_ip;
      end
      if(when_PlicGateway_l21_6) begin
        gateways_6_ip <= _zz_gateways_6_ip;
        gateways_6_waitCompletion <= _zz_gateways_6_ip;
      end
      if(when_PlicGateway_l21_7) begin
        gateways_7_ip <= _zz_gateways_7_ip;
        gateways_7_waitCompletion <= _zz_gateways_7_ip;
      end
      if(when_PlicGateway_l21_8) begin
        gateways_8_ip <= _zz_gateways_8_ip;
        gateways_8_waitCompletion <= _zz_gateways_8_ip;
      end
      if(when_PlicGateway_l21_9) begin
        gateways_9_ip <= _zz_gateways_9_ip;
        gateways_9_waitCompletion <= _zz_gateways_9_ip;
      end
      if(when_PlicGateway_l21_10) begin
        gateways_10_ip <= _zz_gateways_10_ip;
        gateways_10_waitCompletion <= _zz_gateways_10_ip;
      end
      if(when_PlicGateway_l21_11) begin
        gateways_11_ip <= _zz_gateways_11_ip;
        gateways_11_waitCompletion <= _zz_gateways_11_ip;
      end
      if(when_PlicGateway_l21_12) begin
        gateways_12_ip <= _zz_gateways_12_ip;
        gateways_12_waitCompletion <= _zz_gateways_12_ip;
      end
      if(when_PlicGateway_l21_13) begin
        gateways_13_ip <= _zz_gateways_13_ip;
        gateways_13_waitCompletion <= _zz_gateways_13_ip;
      end
      if(when_PlicGateway_l21_14) begin
        gateways_14_ip <= _zz_gateways_14_ip;
        gateways_14_waitCompletion <= _zz_gateways_14_ip;
      end
      if(when_PlicGateway_l21_15) begin
        gateways_15_ip <= _zz_gateways_15_ip;
        gateways_15_waitCompletion <= _zz_gateways_15_ip;
      end
      if(when_PlicGateway_l21_16) begin
        gateways_16_ip <= _zz_gateways_16_ip;
        gateways_16_waitCompletion <= _zz_gateways_16_ip;
      end
      if(when_PlicGateway_l21_17) begin
        gateways_17_ip <= _zz_gateways_17_ip;
        gateways_17_waitCompletion <= _zz_gateways_17_ip;
      end
      if(when_PlicGateway_l21_18) begin
        gateways_18_ip <= _zz_gateways_18_ip;
        gateways_18_waitCompletion <= _zz_gateways_18_ip;
      end
      if(when_PlicGateway_l21_19) begin
        gateways_19_ip <= _zz_gateways_19_ip;
        gateways_19_waitCompletion <= _zz_gateways_19_ip;
      end
      if(when_PlicGateway_l21_20) begin
        gateways_20_ip <= _zz_gateways_20_ip;
        gateways_20_waitCompletion <= _zz_gateways_20_ip;
      end
      if(when_PlicGateway_l21_21) begin
        gateways_21_ip <= _zz_gateways_21_ip;
        gateways_21_waitCompletion <= _zz_gateways_21_ip;
      end
      if(when_PlicGateway_l21_22) begin
        gateways_22_ip <= _zz_gateways_22_ip;
        gateways_22_waitCompletion <= _zz_gateways_22_ip;
      end
      if(when_PlicGateway_l21_23) begin
        gateways_23_ip <= _zz_gateways_23_ip;
        gateways_23_waitCompletion <= _zz_gateways_23_ip;
      end
      if(when_PlicGateway_l21_24) begin
        gateways_24_ip <= _zz_gateways_24_ip;
        gateways_24_waitCompletion <= _zz_gateways_24_ip;
      end
      if(when_PlicGateway_l21_25) begin
        gateways_25_ip <= _zz_gateways_25_ip;
        gateways_25_waitCompletion <= _zz_gateways_25_ip;
      end
      if(when_PlicGateway_l21_26) begin
        gateways_26_ip <= _zz_gateways_26_ip;
        gateways_26_waitCompletion <= _zz_gateways_26_ip;
      end
      if(when_PlicGateway_l21_27) begin
        gateways_27_ip <= _zz_gateways_27_ip;
        gateways_27_waitCompletion <= _zz_gateways_27_ip;
      end
      if(when_PlicGateway_l21_28) begin
        gateways_28_ip <= _zz_gateways_28_ip;
        gateways_28_waitCompletion <= _zz_gateways_28_ip;
      end
      if(when_PlicGateway_l21_29) begin
        gateways_29_ip <= _zz_gateways_29_ip;
        gateways_29_waitCompletion <= _zz_gateways_29_ip;
      end
      if(when_PlicGateway_l21_30) begin
        gateways_30_ip <= _zz_gateways_30_ip;
        gateways_30_waitCompletion <= _zz_gateways_30_ip;
      end
      if(when_PlicGateway_l21_31) begin
        gateways_31_ip <= _zz_gateways_31_ip;
        gateways_31_waitCompletion <= _zz_gateways_31_ip;
      end
      if(bus_writeJoinEvent_translated_haltWhen_valid) begin
        bus_writeJoinEvent_translated_haltWhen_rValid <= 1'b1;
      end
      if(bus_writeJoinEvent_translated_haltWhen_halfPipe_fire) begin
        bus_writeJoinEvent_translated_haltWhen_rValid <= 1'b0;
      end
      if(io_bus_ar_valid) begin
        io_bus_ar_rValid <= 1'b1;
      end
      if(bus_readDataStage_fire) begin
        io_bus_ar_rValid <= 1'b0;
      end
      if(mapping_claim_valid) begin
        case(mapping_claim_payload)
          6'h01 : begin
            gateways_0_ip <= 1'b0;
          end
          6'h02 : begin
            gateways_1_ip <= 1'b0;
          end
          6'h03 : begin
            gateways_2_ip <= 1'b0;
          end
          6'h04 : begin
            gateways_3_ip <= 1'b0;
          end
          6'h05 : begin
            gateways_4_ip <= 1'b0;
          end
          6'h06 : begin
            gateways_5_ip <= 1'b0;
          end
          6'h07 : begin
            gateways_6_ip <= 1'b0;
          end
          6'h08 : begin
            gateways_7_ip <= 1'b0;
          end
          6'h09 : begin
            gateways_8_ip <= 1'b0;
          end
          6'h0a : begin
            gateways_9_ip <= 1'b0;
          end
          6'h0b : begin
            gateways_10_ip <= 1'b0;
          end
          6'h0c : begin
            gateways_11_ip <= 1'b0;
          end
          6'h0d : begin
            gateways_12_ip <= 1'b0;
          end
          6'h0e : begin
            gateways_13_ip <= 1'b0;
          end
          6'h0f : begin
            gateways_14_ip <= 1'b0;
          end
          6'h10 : begin
            gateways_15_ip <= 1'b0;
          end
          6'h11 : begin
            gateways_16_ip <= 1'b0;
          end
          6'h12 : begin
            gateways_17_ip <= 1'b0;
          end
          6'h13 : begin
            gateways_18_ip <= 1'b0;
          end
          6'h14 : begin
            gateways_19_ip <= 1'b0;
          end
          6'h15 : begin
            gateways_20_ip <= 1'b0;
          end
          6'h16 : begin
            gateways_21_ip <= 1'b0;
          end
          6'h17 : begin
            gateways_22_ip <= 1'b0;
          end
          6'h18 : begin
            gateways_23_ip <= 1'b0;
          end
          6'h19 : begin
            gateways_24_ip <= 1'b0;
          end
          6'h1a : begin
            gateways_25_ip <= 1'b0;
          end
          6'h1b : begin
            gateways_26_ip <= 1'b0;
          end
          6'h1c : begin
            gateways_27_ip <= 1'b0;
          end
          6'h1d : begin
            gateways_28_ip <= 1'b0;
          end
          6'h1e : begin
            gateways_29_ip <= 1'b0;
          end
          6'h1f : begin
            gateways_30_ip <= 1'b0;
          end
          6'h20 : begin
            gateways_31_ip <= 1'b0;
          end
          default : begin
          end
        endcase
      end
      if(mapping_completion_valid) begin
        case(mapping_completion_payload)
          6'h01 : begin
            gateways_0_waitCompletion <= 1'b0;
          end
          6'h02 : begin
            gateways_1_waitCompletion <= 1'b0;
          end
          6'h03 : begin
            gateways_2_waitCompletion <= 1'b0;
          end
          6'h04 : begin
            gateways_3_waitCompletion <= 1'b0;
          end
          6'h05 : begin
            gateways_4_waitCompletion <= 1'b0;
          end
          6'h06 : begin
            gateways_5_waitCompletion <= 1'b0;
          end
          6'h07 : begin
            gateways_6_waitCompletion <= 1'b0;
          end
          6'h08 : begin
            gateways_7_waitCompletion <= 1'b0;
          end
          6'h09 : begin
            gateways_8_waitCompletion <= 1'b0;
          end
          6'h0a : begin
            gateways_9_waitCompletion <= 1'b0;
          end
          6'h0b : begin
            gateways_10_waitCompletion <= 1'b0;
          end
          6'h0c : begin
            gateways_11_waitCompletion <= 1'b0;
          end
          6'h0d : begin
            gateways_12_waitCompletion <= 1'b0;
          end
          6'h0e : begin
            gateways_13_waitCompletion <= 1'b0;
          end
          6'h0f : begin
            gateways_14_waitCompletion <= 1'b0;
          end
          6'h10 : begin
            gateways_15_waitCompletion <= 1'b0;
          end
          6'h11 : begin
            gateways_16_waitCompletion <= 1'b0;
          end
          6'h12 : begin
            gateways_17_waitCompletion <= 1'b0;
          end
          6'h13 : begin
            gateways_18_waitCompletion <= 1'b0;
          end
          6'h14 : begin
            gateways_19_waitCompletion <= 1'b0;
          end
          6'h15 : begin
            gateways_20_waitCompletion <= 1'b0;
          end
          6'h16 : begin
            gateways_21_waitCompletion <= 1'b0;
          end
          6'h17 : begin
            gateways_22_waitCompletion <= 1'b0;
          end
          6'h18 : begin
            gateways_23_waitCompletion <= 1'b0;
          end
          6'h19 : begin
            gateways_24_waitCompletion <= 1'b0;
          end
          6'h1a : begin
            gateways_25_waitCompletion <= 1'b0;
          end
          6'h1b : begin
            gateways_26_waitCompletion <= 1'b0;
          end
          6'h1c : begin
            gateways_27_waitCompletion <= 1'b0;
          end
          6'h1d : begin
            gateways_28_waitCompletion <= 1'b0;
          end
          6'h1e : begin
            gateways_29_waitCompletion <= 1'b0;
          end
          6'h1f : begin
            gateways_30_waitCompletion <= 1'b0;
          end
          6'h20 : begin
            gateways_31_waitCompletion <= 1'b0;
          end
          default : begin
          end
        endcase
      end
      mapping_coherencyStall_value <= mapping_coherencyStall_valueNext;
      case(bus_writeAddressMasked)
        22'h000004 : begin
          if(bus_writeOccur) begin
            gateways_0_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000008 : begin
          if(bus_writeOccur) begin
            gateways_1_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00000c : begin
          if(bus_writeOccur) begin
            gateways_2_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000010 : begin
          if(bus_writeOccur) begin
            gateways_3_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000014 : begin
          if(bus_writeOccur) begin
            gateways_4_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000018 : begin
          if(bus_writeOccur) begin
            gateways_5_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00001c : begin
          if(bus_writeOccur) begin
            gateways_6_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000020 : begin
          if(bus_writeOccur) begin
            gateways_7_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000024 : begin
          if(bus_writeOccur) begin
            gateways_8_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000028 : begin
          if(bus_writeOccur) begin
            gateways_9_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00002c : begin
          if(bus_writeOccur) begin
            gateways_10_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000030 : begin
          if(bus_writeOccur) begin
            gateways_11_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000034 : begin
          if(bus_writeOccur) begin
            gateways_12_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000038 : begin
          if(bus_writeOccur) begin
            gateways_13_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00003c : begin
          if(bus_writeOccur) begin
            gateways_14_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000040 : begin
          if(bus_writeOccur) begin
            gateways_15_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000044 : begin
          if(bus_writeOccur) begin
            gateways_16_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000048 : begin
          if(bus_writeOccur) begin
            gateways_17_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00004c : begin
          if(bus_writeOccur) begin
            gateways_18_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000050 : begin
          if(bus_writeOccur) begin
            gateways_19_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000054 : begin
          if(bus_writeOccur) begin
            gateways_20_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000058 : begin
          if(bus_writeOccur) begin
            gateways_21_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00005c : begin
          if(bus_writeOccur) begin
            gateways_22_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000060 : begin
          if(bus_writeOccur) begin
            gateways_23_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000064 : begin
          if(bus_writeOccur) begin
            gateways_24_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000068 : begin
          if(bus_writeOccur) begin
            gateways_25_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00006c : begin
          if(bus_writeOccur) begin
            gateways_26_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000070 : begin
          if(bus_writeOccur) begin
            gateways_27_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000074 : begin
          if(bus_writeOccur) begin
            gateways_28_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000078 : begin
          if(bus_writeOccur) begin
            gateways_29_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h00007c : begin
          if(bus_writeOccur) begin
            gateways_30_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h000080 : begin
          if(bus_writeOccur) begin
            gateways_31_priority_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h200000 : begin
          if(bus_writeOccur) begin
            targets_0_threshold_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h002000 : begin
          if(bus_writeOccur) begin
            targets_0_ie_0_driver <= io_bus_w_payload_data[1];
            targets_0_ie_1_driver <= io_bus_w_payload_data[2];
            targets_0_ie_2_driver <= io_bus_w_payload_data[3];
            targets_0_ie_3_driver <= io_bus_w_payload_data[4];
            targets_0_ie_4_driver <= io_bus_w_payload_data[5];
            targets_0_ie_5_driver <= io_bus_w_payload_data[6];
            targets_0_ie_6_driver <= io_bus_w_payload_data[7];
            targets_0_ie_7_driver <= io_bus_w_payload_data[8];
            targets_0_ie_8_driver <= io_bus_w_payload_data[9];
            targets_0_ie_9_driver <= io_bus_w_payload_data[10];
            targets_0_ie_10_driver <= io_bus_w_payload_data[11];
            targets_0_ie_11_driver <= io_bus_w_payload_data[12];
            targets_0_ie_12_driver <= io_bus_w_payload_data[13];
            targets_0_ie_13_driver <= io_bus_w_payload_data[14];
            targets_0_ie_14_driver <= io_bus_w_payload_data[15];
            targets_0_ie_15_driver <= io_bus_w_payload_data[16];
            targets_0_ie_16_driver <= io_bus_w_payload_data[17];
            targets_0_ie_17_driver <= io_bus_w_payload_data[18];
            targets_0_ie_18_driver <= io_bus_w_payload_data[19];
            targets_0_ie_19_driver <= io_bus_w_payload_data[20];
            targets_0_ie_20_driver <= io_bus_w_payload_data[21];
            targets_0_ie_21_driver <= io_bus_w_payload_data[22];
            targets_0_ie_22_driver <= io_bus_w_payload_data[23];
            targets_0_ie_23_driver <= io_bus_w_payload_data[24];
            targets_0_ie_24_driver <= io_bus_w_payload_data[25];
            targets_0_ie_25_driver <= io_bus_w_payload_data[26];
            targets_0_ie_26_driver <= io_bus_w_payload_data[27];
            targets_0_ie_27_driver <= io_bus_w_payload_data[28];
            targets_0_ie_28_driver <= io_bus_w_payload_data[29];
            targets_0_ie_29_driver <= io_bus_w_payload_data[30];
            targets_0_ie_30_driver <= io_bus_w_payload_data[31];
          end
        end
        22'h002004 : begin
          if(bus_writeOccur) begin
            targets_0_ie_31_driver <= io_bus_w_payload_data[0];
          end
        end
        22'h201000 : begin
          if(bus_writeOccur) begin
            targets_1_threshold_driver <= io_bus_w_payload_data[1 : 0];
          end
        end
        22'h002080 : begin
          if(bus_writeOccur) begin
            targets_1_ie_0_driver <= io_bus_w_payload_data[1];
            targets_1_ie_1_driver <= io_bus_w_payload_data[2];
            targets_1_ie_2_driver <= io_bus_w_payload_data[3];
            targets_1_ie_3_driver <= io_bus_w_payload_data[4];
            targets_1_ie_4_driver <= io_bus_w_payload_data[5];
            targets_1_ie_5_driver <= io_bus_w_payload_data[6];
            targets_1_ie_6_driver <= io_bus_w_payload_data[7];
            targets_1_ie_7_driver <= io_bus_w_payload_data[8];
            targets_1_ie_8_driver <= io_bus_w_payload_data[9];
            targets_1_ie_9_driver <= io_bus_w_payload_data[10];
            targets_1_ie_10_driver <= io_bus_w_payload_data[11];
            targets_1_ie_11_driver <= io_bus_w_payload_data[12];
            targets_1_ie_12_driver <= io_bus_w_payload_data[13];
            targets_1_ie_13_driver <= io_bus_w_payload_data[14];
            targets_1_ie_14_driver <= io_bus_w_payload_data[15];
            targets_1_ie_15_driver <= io_bus_w_payload_data[16];
            targets_1_ie_16_driver <= io_bus_w_payload_data[17];
            targets_1_ie_17_driver <= io_bus_w_payload_data[18];
            targets_1_ie_18_driver <= io_bus_w_payload_data[19];
            targets_1_ie_19_driver <= io_bus_w_payload_data[20];
            targets_1_ie_20_driver <= io_bus_w_payload_data[21];
            targets_1_ie_21_driver <= io_bus_w_payload_data[22];
            targets_1_ie_22_driver <= io_bus_w_payload_data[23];
            targets_1_ie_23_driver <= io_bus_w_payload_data[24];
            targets_1_ie_24_driver <= io_bus_w_payload_data[25];
            targets_1_ie_25_driver <= io_bus_w_payload_data[26];
            targets_1_ie_26_driver <= io_bus_w_payload_data[27];
            targets_1_ie_27_driver <= io_bus_w_payload_data[28];
            targets_1_ie_28_driver <= io_bus_w_payload_data[29];
            targets_1_ie_29_driver <= io_bus_w_payload_data[30];
            targets_1_ie_30_driver <= io_bus_w_payload_data[31];
          end
        end
        22'h002084 : begin
          if(bus_writeOccur) begin
            targets_1_ie_31_driver <= io_bus_w_payload_data[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(posedge clk) begin
    targets_0_bestRequest_priority <= (_zz_targets_0_bestRequest_priority_3 ? _zz_targets_0_bestRequest_priority_2 : targets_0_requests_32_priority);
    targets_0_bestRequest_id <= (_zz_targets_0_bestRequest_priority_3 ? (_zz_targets_0_bestRequest_id_88 ? (_zz_targets_0_bestRequest_id_84 ? (_zz_targets_0_bestRequest_id_72 ? (_zz_targets_0_bestRequest_id_48 ? _zz_targets_0_bestRequest_id_89 : _zz_targets_0_bestRequest_id_90) : (_zz_targets_0_bestRequest_id_51 ? _zz_targets_0_bestRequest_id_91 : _zz_targets_0_bestRequest_id_92)) : (_zz_targets_0_bestRequest_id_75 ? (_zz_targets_0_bestRequest_id_54 ? _zz_targets_0_bestRequest_id_93 : _zz_targets_0_bestRequest_id_94) : (_zz_targets_0_bestRequest_id_57 ? _zz_targets_0_bestRequest_id_95 : _zz_targets_0_bestRequest_id_96))) : (_zz_targets_0_bestRequest_id_86 ? (_zz_targets_0_bestRequest_id_78 ? (_zz_targets_0_bestRequest_id_60 ? _zz_targets_0_bestRequest_id_97 : _zz_targets_0_bestRequest_id_98) : (_zz_targets_0_bestRequest_id_63 ? _zz_targets_0_bestRequest_id_99 : _zz_targets_0_bestRequest_id_100)) : (_zz_targets_0_bestRequest_id_81 ? (_zz_targets_0_bestRequest_id_66 ? _zz_targets_0_bestRequest_id_101 : _zz_targets_0_bestRequest_id_102) : (_zz_targets_0_bestRequest_id_69 ? _zz_targets_0_bestRequest_id_103 : _zz_targets_0_bestRequest_id_104)))) : targets_0_requests_32_id);
    targets_0_bestRequest_valid <= (_zz_targets_0_bestRequest_priority_3 ? _zz_targets_0_bestRequest_valid : targets_0_requests_32_valid);
    targets_1_bestRequest_priority <= (_zz_targets_1_bestRequest_priority_3 ? _zz_targets_1_bestRequest_priority_2 : targets_1_requests_32_priority);
    targets_1_bestRequest_id <= (_zz_targets_1_bestRequest_priority_3 ? (_zz_targets_1_bestRequest_id_88 ? (_zz_targets_1_bestRequest_id_84 ? (_zz_targets_1_bestRequest_id_72 ? (_zz_targets_1_bestRequest_id_48 ? _zz_targets_1_bestRequest_id_89 : _zz_targets_1_bestRequest_id_90) : (_zz_targets_1_bestRequest_id_51 ? _zz_targets_1_bestRequest_id_91 : _zz_targets_1_bestRequest_id_92)) : (_zz_targets_1_bestRequest_id_75 ? (_zz_targets_1_bestRequest_id_54 ? _zz_targets_1_bestRequest_id_93 : _zz_targets_1_bestRequest_id_94) : (_zz_targets_1_bestRequest_id_57 ? _zz_targets_1_bestRequest_id_95 : _zz_targets_1_bestRequest_id_96))) : (_zz_targets_1_bestRequest_id_86 ? (_zz_targets_1_bestRequest_id_78 ? (_zz_targets_1_bestRequest_id_60 ? _zz_targets_1_bestRequest_id_97 : _zz_targets_1_bestRequest_id_98) : (_zz_targets_1_bestRequest_id_63 ? _zz_targets_1_bestRequest_id_99 : _zz_targets_1_bestRequest_id_100)) : (_zz_targets_1_bestRequest_id_81 ? (_zz_targets_1_bestRequest_id_66 ? _zz_targets_1_bestRequest_id_101 : _zz_targets_1_bestRequest_id_102) : (_zz_targets_1_bestRequest_id_69 ? _zz_targets_1_bestRequest_id_103 : _zz_targets_1_bestRequest_id_104)))) : targets_1_requests_32_id);
    targets_1_bestRequest_valid <= (_zz_targets_1_bestRequest_priority_3 ? _zz_targets_1_bestRequest_valid : targets_1_requests_32_valid);
    if(bus_writeJoinEvent_translated_haltWhen_ready) begin
      bus_writeJoinEvent_translated_haltWhen_rData_resp <= bus_writeJoinEvent_translated_haltWhen_payload_resp;
    end
    if(io_bus_ar_ready) begin
      io_bus_ar_rData_addr <= io_bus_ar_payload_addr;
      io_bus_ar_rData_prot <= io_bus_ar_payload_prot;
    end
  end


endmodule
