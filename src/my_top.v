/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        my_top.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        Top module. Instantiates and interconnects blocks.
*
*
*    This code is initially developed for the Network-as-a-Service (NaaS) project.
*
*  Copyright notice:
*        Copyright (C) 2014 University of Cambridge
*
*  Licence:
*        This file is part of the NetFPGA 10G development base package.
*
*        This file is free code: you can redistribute it and/or modify it under
*        the terms of the GNU Lesser General Public License version 2.1 as
*        published by the Free Software Foundation.
*
*        This package is distributed in the hope that it will be useful, but
*        WITHOUT ANY WARRANTY; without even the implied warranty of
*        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
*        Lesser General Public License for more details.
*
*        You should have received a copy of the GNU Lesser General Public
*        License along with the NetFPGA source package.  If not, see
*        http://www.gnu.org/licenses/.
*
*/

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//`default_nettype none
`include "includes.v"

module my_top ( 
    // PCI Express Fabric Interface
    // Tx
    output    [7:0]           pci_exp_txp,
    output    [7:0]           pci_exp_txn,
    // Rx
    input     [7:0]           pci_exp_rxp,
    input     [7:0]           pci_exp_rxn,

    // System (SYS) Interface
    input                     sys_clk_p,
    input                     sys_clk_n,
    //input                   sys_reset_n,    // MF: no reset available

    //output                    LED01,
    //output                    LED02,
    //output                    LED03,

    // XAUI D
    input refclk_D_p,
    input refclk_D_n,
    output  xaui_tx_l0_p,
    output  xaui_tx_l0_n,
    output  xaui_tx_l1_p,
    output  xaui_tx_l1_n,
    output  xaui_tx_l2_p,
    output  xaui_tx_l2_n,
    output  xaui_tx_l3_p,
    output  xaui_tx_l3_n,
    input   xaui_rx_l0_p,
    input   xaui_rx_l0_n,
    input   xaui_rx_l1_p,
    input   xaui_rx_l1_n,
    input   xaui_rx_l2_p,
    input   xaui_rx_l2_n,
    input   xaui_rx_l3_p,
    input   xaui_rx_l3_n,

    input   usr_100MHz,

    output  ael2005_mdc,
    inout   ael2005_mdio

    );//synthesis syn_noclockbuf=1


    //assign LED01 = 1'b1;
    //assign LED02 = 1'b1;
    //assign LED03 = 1'b1;


    //-------------------------------------------------------
    // Local Wires  PCIe
    //-------------------------------------------------------
    wire                                              sys_clk_c;
    wire                                              refclkout;

    wire                                              sys_reset_n_c = 1'b1;  // MF: no reset available
    wire                                              trn_clk_c;//synthesis attribute max_fanout of trn_clk_c is "100000"
    wire                                              trn_reset_n_c;
    wire                                              trn_lnk_up_n_c;
    wire                                              cfg_trn_pending_n_c;
    wire    [63:0]                                    cfg_dsn_n_c;
    wire                                              trn_tsof_n_c;
    wire                                              trn_teof_n_c;
    wire                                              trn_tsrc_rdy_n_c;
    wire                                              trn_tdst_rdy_n_c;
    wire                                              trn_tsrc_dsc_n_c;
    wire                                              trn_terrfwd_n_c;
    wire                                              trn_tdst_dsc_n_c;
    wire    [63:0]                                    trn_td_c;
    wire    [7:0]                                     trn_trem_n_c;
    wire    [3:0]                                     trn_tbuf_av_c;

    wire                                              trn_rsof_n_c;
    wire                                              trn_reof_n_c;
    wire                                              trn_rsrc_rdy_n_c;
    wire                                              trn_rsrc_dsc_n_c;
    wire                                              trn_rdst_rdy_n_c;
    wire                                              trn_rerrfwd_n_c;
    wire                                              trn_rnp_ok_n_c;

    wire    [63:0]                                    trn_rd_c;
    wire    [7:0]                                     trn_rrem_n_c;
    wire    [6:0]                                     trn_rbar_hit_n_c;
    wire    [7:0]                                     trn_rfc_nph_av_c;
    wire    [11:0]                                    trn_rfc_npd_av_c;
    wire    [7:0]                                     trn_rfc_ph_av_c;
    wire    [11:0]                                    trn_rfc_pd_av_c;
    wire                                              trn_rcpl_streaming_n_c;

    wire    [31:0]                                    cfg_do_c;
    wire    [31:0]                                    cfg_di_c;
    wire    [9:0]                                     cfg_dwaddr_c;
    wire    [3:0]                                     cfg_byte_en_n_c;
    wire    [47:0]                                    cfg_err_tlp_cpl_header_c;

    wire                                              cfg_wr_en_n_c;
    wire                                              cfg_rd_en_n_c;
    wire                                              cfg_rd_wr_done_n_c;
    wire                                              cfg_err_cor_n_c;
    wire                                              cfg_err_ur_n_c;
    wire                                              cfg_err_cpl_rdy_n_c;
    wire                                              cfg_err_ecrc_n_c;
    wire                                              cfg_err_cpl_timeout_n_c;
    wire                                              cfg_err_cpl_abort_n_c;
    wire                                              cfg_err_cpl_unexpect_n_c;
    wire                                              cfg_err_posted_n_c;
    wire                                              cfg_err_locked_n_c;

    wire                                              cfg_interrupt_n_c;
    wire                                              cfg_interrupt_rdy_n_c;
    wire                                              cfg_interrupt_assert_n_c;
    wire    [7:0]                                     cfg_interrupt_di_c;
    wire    [7:0]                                     cfg_interrupt_do_c;
    wire    [2:0]                                     cfg_interrupt_mmenable_c;
    wire                                              cfg_interrupt_msienable_c;

    wire                                              cfg_turnoff_ok_n_c;
    wire                                              cfg_to_turnoff_n;
    wire                                              cfg_pm_wake_n_c;
    wire    [2:0]                                     cfg_pcie_link_state_n_c;
    wire    [7:0]                                     cfg_bus_number_c;
    wire    [4:0]                                     cfg_device_number_c;
    wire    [2:0]                                     cfg_function_number_c;
    wire    [15:0]                                    cfg_status_c;
    wire    [15:0]                                    cfg_command_c;
    wire    [15:0]                                    cfg_dstatus_c;
    wire    [15:0]                                    cfg_dcommand_c;
    wire    [15:0]                                    cfg_lstatus_c;
    wire    [15:0]                                    cfg_lcommand_c;

    //-------------------------------------------------------
    // Local Wires 
    //-------------------------------------------------------
    wire                                              reset250;
    wire                                              reset156_25;
    
    //-------------------------------------------------------
    // Local Wires  DCM for XAUI
    //-------------------------------------------------------
    wire                                              clk50;
    wire                                              dcm_for_xaui_locked;

    //-------------------------------------------------------
    // Local Wires  XAUI
    //-------------------------------------------------------
    wire                                              xaui_reset;
    wire                                              clk156_25;
    wire   [63:0]                                     xgmii_txd;
    wire   [7:0]                                      xgmii_txc;
    wire   [63:0]                                     xgmii_rxd;
    wire   [7:0]                                      xgmii_rxc;
    wire   [3:0]                                      xaui_signal_detect;
    wire                                              xaui_align_status;
    wire   [3:0]                                      xaui_sync_status;
    wire                                              xaui_mgt_tx_ready;
    wire   [6:0]                                      xaui_configuration_vector;
    wire   [7:0]                                      xaui_status_vector;
    
    //-------------------------------------------------------
    // Local Wires  MAC
    //-------------------------------------------------------
    wire                                              mac_tx_underrun;
    wire   [63:0]                                     mac_tx_data;
    wire   [7:0]                                      mac_tx_data_valid;
    wire                                              mac_tx_start;
    wire                                              mac_tx_ack;
    wire   [7:0]                                      mac_tx_ifg_delay;
    wire   [24:0]                                     mac_tx_statistics_vector;
    wire                                              mac_tx_statistics_valid;
    wire   [15:0]                                     mac_pause_val;
    wire                                              mac_pause_req;
    wire   [63:0]                                     mac_rx_data;
    wire   [7:0]                                      mac_rx_data_valid;
    wire                                              mac_rx_good_frame;
    wire                                              mac_rx_bad_frame;
    wire   [28:0]                                     mac_rx_statistics_vector;
    wire                                              mac_rx_statistics_valid;
    //wire   [68:0]                                     mac_configuration_vector;
    //wire   [1:0]                                      mac_status_vector;
    wire   [1:0]                                      mac_host_opcode;
    wire   [9:0]                                      mac_host_addr;
    wire   [31:0]                                     mac_host_wr_data;
    wire   [31:0]                                     mac_host_rd_data;
    wire                                              mac_host_miim_sel;
    wire                                              mac_host_req;
    wire                                              mac_host_miim_rdy;
    wire                                              mac_mdio_in;
    wire                                              mac_mdio_out;
    wire                                              mac_mdio_tri;

    //////////////////////////////////////////////////////////////////////////////////////////
    // Reception side of the NIC signal declaration
    //////////////////////////////////////////////////////////////////////////////////////////
    //-------------------------------------------------------
    // Local Wires internal_true_dual_port_ram rx
    //-------------------------------------------------------
    wire   [`BF:0]                                    rx_wr_addr;
    wire   [63:0]                                     rx_wr_data;
    wire   [`BF:0]                                    rx_rd_addr;
    wire   [63:0]                                     rx_rd_data;
    wire                                              rx_wr_clk;
    wire                                              rx_rd_clk;

    //-------------------------------------------------------
    // Local Wires rx_mac_interface
    //-------------------------------------------------------
    wire   [`BF:0]                                    rx_commited_wr_addr;
    wire                                              rx_activity;
    wire   [31:0]                                     sys_nsecs;
    wire   [31:0]                                     sys_secs;
    wire                                              rx_timestamp_en;
    wire   [15:0]                                     rx_dropped_pkts;

    //-------------------------------------------------------
    // Local Wires ns_synch
    //-------------------------------------------------------
    wire   [31:0]                                     sys_nsecs_synch;
    wire                                              sys_nsecs_update;

    //-------------------------------------------------------
    // Local Wires s_synch
    //-------------------------------------------------------
    wire   [31:0]                                     sys_secs_synch;
    wire                                              sys_secs_update;

    //-------------------------------------------------------
    // Local Wires rx_wr_addr_synch
    //-------------------------------------------------------
    wire   [`BF:0]                                    rx_commited_wr_addr_synch;
    
    //-------------------------------------------------------
    // Local Wires rx_rd_addr_synch
    //-------------------------------------------------------
    wire   [`BF:0]                                    rx_commited_rd_addr;
    wire   [`BF:0]                                    rx_commited_rd_addr_synch;

    //-------------------------------------------------------
    // Local Wires rx_dropped_pkts_synch
    //-------------------------------------------------------
    wire   [15:0]                                     rx_dropped_pkts_synch;

    //////////////////////////////////////////////////////////////////////////////////////////
    // Transmition side of the NIC signal declaration
    //////////////////////////////////////////////////////////////////////////////////////////
    //-------------------------------------------------------
    // Local Wires internal_true_dual_port_ram tx
    //-------------------------------------------------------
    wire   [8:0]                                      tx_wr_addr;
    wire   [63:0]                                     tx_wr_data;
    wire   [8:0]                                      tx_rd_addr;
    wire   [63:0]                                     tx_rd_data;
    wire                                              tx_wr_clk;
    wire                                              tx_rd_clk;

    //-------------------------------------------------------
    // Local Wires tx_mac_interface
    //-------------------------------------------------------
    wire   [9:0]                                      tx_commited_rd_addr;

    //-------------------------------------------------------
    // Local Wires tx_rd_addr_synch
    //-------------------------------------------------------
    wire   [9:0]                                      tx_commited_rd_addr_synch;

    //-------------------------------------------------------
    // Local Wires tx_wr_addr_synch
    //-------------------------------------------------------
    wire   [9:0]                                      tx_commited_wr_addr;
    wire   [9:0]                                      tx_commited_wr_addr_synch;

    //-------------------------------------------------------
    // Virtex5-FX Global Clock Buffer
    //-------------------------------------------------------
    IBUFDS refclk_ibuf (.O(sys_clk_c), .I(sys_clk_p), .IB(sys_clk_n));  // 100 MHz

    //-------------------------------------------------------
    // Virtex5-FX DCM for XAUI
    //-------------------------------------------------------
    xaui_dcm dcm_for_xaui (
        .CLKIN_IN(usr_100MHz),                                 // I
        .RST_IN(reset250),                                     // I
        .CLKIN_IBUFG_OUT(),                                    // O (it's also possible to use 1 source clk for the all design)
        .CLK0_OUT(clk50),                                      // O
        .LOCKED_OUT(dcm_for_xaui_locked)                       // O
        );

    //-------------------------------------------------------
    // XAUI D
    //-------------------------------------------------------

    assign xaui_reset = ~dcm_for_xaui_locked;

    xaui_v10_4_example_design xaui_d (
        .dclk(clk50),                                          // I
        .reset(xaui_reset),                                    // I
        .clk156_out(clk156_25),                                // O
        .xgmii_txd(xgmii_txd),                                 // I [63:0]
        .xgmii_txc(xgmii_txc),                                 // I [7:0]
        .xgmii_rxd(xgmii_rxd),                                 // O [63:0]
        .xgmii_rxc(xgmii_rxc),                                 // O [7:0]
        .refclk_p(refclk_D_p),                                 // I
        .refclk_n(refclk_D_n),                                 // I
        .xaui_tx_l0_p(xaui_tx_l0_p),                           // O
        .xaui_tx_l0_n(xaui_tx_l0_n),                           // O
        .xaui_tx_l1_p(xaui_tx_l1_p),                           // O
        .xaui_tx_l1_n(xaui_tx_l1_n),                           // O
        .xaui_tx_l2_p(xaui_tx_l2_p),                           // O
        .xaui_tx_l2_n(xaui_tx_l2_n),                           // O
        .xaui_tx_l3_p(xaui_tx_l3_p),                           // O
        .xaui_tx_l3_n(xaui_tx_l3_n),                           // O
        .xaui_rx_l0_p(xaui_rx_l0_p),                           // I
        .xaui_rx_l0_n(xaui_rx_l0_n),                           // I
        .xaui_rx_l1_p(xaui_rx_l1_p),                           // I
        .xaui_rx_l1_n(xaui_rx_l1_n),                           // I
        .xaui_rx_l2_p(xaui_rx_l2_p),                           // I
        .xaui_rx_l2_n(xaui_rx_l2_n),                           // I
        .xaui_rx_l3_p(xaui_rx_l3_p),                           // I
        .xaui_rx_l3_n(xaui_rx_l3_n),                           // I
        .signal_detect(xaui_signal_detect),                    // I [3:0]
        .align_status(xaui_align_status),                      // O
        .sync_status(xaui_sync_status),                        // O [3:0]
        .mgt_tx_ready(xaui_mgt_tx_ready),                      // O
        .configuration_vector(xaui_configuration_vector),      // I [6:0]
        .status_vector(xaui_status_vector)                     // O [7:0]
        );

    // XAUI Loopback
    //always @(posedge clk156_25) begin
        //xgmii_txd <= xgmii_rxd;
        //xgmii_txc <= xgmii_rxc;
    //end

    // XAUI Configuration
    assign  xaui_signal_detect = 4'b1111;      //according to pg053
    assign  xaui_configuration_vector = 7'b0;  //see pg053

    //-------------------------------------------------------
    // MAC
    //-------------------------------------------------------
    ten_gig_eth_mac_v10_3 mac_d (
        .reset(reset156_25),                                   // I
        
        .tx_underrun(mac_tx_underrun),                         // I 
        .tx_data(mac_tx_data),                                 // I [63:0] 
        .tx_data_valid(mac_tx_data_valid),                     // I [7:0] 
        .tx_start(mac_tx_start),                               // I 
        .tx_ack(mac_tx_ack),                                   // O 
        .tx_ifg_delay(mac_tx_ifg_delay),                       // I [7:0] 
        .tx_statistics_vector(mac_tx_statistics_vector),       // O [24:0] 
        .tx_statistics_valid(mac_tx_statistics_valid),         // O 
        .pause_val(mac_pause_val),                             // I [15:0] 
        .pause_req(mac_pause_req),                             // I

        .rx_data(mac_rx_data),                                 // O [63:0]
        .rx_data_valid(mac_rx_data_valid),                     // O [7:0]
        .rx_good_frame(mac_rx_good_frame),                     // O
        .rx_bad_frame(mac_rx_bad_frame),                       // O
        .rx_statistics_vector(mac_rx_statistics_vector),       // O [28:0]
        .rx_statistics_valid(mac_rx_statistics_valid),         // O 

        .host_clk(clk50),                                      // I 
        .host_opcode(mac_host_opcode),                         // I [1:0] 
        .host_addr(mac_host_addr),                             // I [9:0] 
        .host_wr_data(mac_host_wr_data),                       // I [31:0] 
        .host_rd_data(mac_host_rd_data),                       // O [31:0] 
        .host_miim_sel(mac_host_miim_sel),                     // I 
        .host_req(mac_host_req),                               // I 
        .host_miim_rdy(mac_host_miim_rdy),                     // O 

        .tx_clk0(clk156_25),                                   // I 
        .tx_dcm_lock(xaui_mgt_tx_ready),                       // I 
        .xgmii_txd(xgmii_txd),                                 // O [63:0]
        .xgmii_txc(xgmii_txc),                                 // O [7:0]

        .rx_clk0(clk156_25),                                   // I 
        .rx_dcm_lock(xaui_align_status),                       // I pg053: '1' when the XAUI receiver is aligned across all four lanes, '0' otherwise.
        .xgmii_rxd(xgmii_rxd),                                 // I [63:0]
        .xgmii_rxc(xgmii_rxc),                                 // I [7:0]
        
        .mdc(ael2005_mdc),                                     // O 
        .mdio_in(mac_mdio_in),                                 // I
        .mdio_out(mac_mdio_out),                               // O 
        .mdio_tri(mac_mdio_tri)                                // O
        );

    // MAC Configuration
    // Tx interface disabled
    //assign mac_tx_underrun = 1'b0;
    //assign mac_tx_data = 64'b0;
    //assign mac_tx_data_valid = 8'b0;
    //assign mac_tx_start = 1'b0;
    assign mac_tx_ifg_delay = 8'b0;

    assign mac_pause_val = 16'b0;
    assign mac_pause_req = 1'b0;
    
    // When using The Management Interface the configuration vector interface doesn't exists
    // -------------------------------------------------------------------------------------
    // Rx
    //assign mac_configuration_vector[47:0] = 48'b0;  //Pause frame MAC Source Address
    //assign mac_configuration_vector[48] = 1'b1;     //Receive VLAN Enable
    //assign mac_configuration_vector[49] = 1'b1;     //Receive Enable
    //assign mac_configuration_vector[50] = 1'b1;     //Receive In-Band FCS
    //assign mac_configuration_vector[51] = 1'b1;     //Receive Jumbo Frame Enable
    //assign mac_configuration_vector[52] = 1'b0;     //Receiver Reset
    //assign mac_configuration_vector[66] = 1'b1;     //Receiver Preserve Preamble Enable
    // Tx
    //assign mac_configuration_vector[65:53] = 12'b0;
    //assign mac_configuration_vector[68:67] = 2'b0;

        //.configuration_vector(mac_configuration_vector),  // I [68:0]
        //.status_vector(mac_status_vector),  // O [1:0]
    // -------------------------------------------------------------------------------------
    // When using The Management Interface the configuration vector interface doesn't exists

    //-------------------------------------------------------
    // MDIO interface
    //-------------------------------------------------------

    assign ael2005_mdio = mac_mdio_tri ? 1'bZ : mac_mdio_out;
    assign mac_mdio_in = mac_mdio_out;

    //////////////////////////////////////////////////////////////////////////////////////////
    // Reception side of the NIC (START)
    //////////////////////////////////////////////////////////////////////////////////////////
    //-------------------------------------------------------
    // internal_true_dual_port_ram rx
    //-------------------------------------------------------
    rx_buff #(.AW(10), .DW(64)) rx_buffer_mod (
        .a(rx_wr_addr),                                        // I [`BF:0]
        .d(rx_wr_data),                                        // I [63:0]
        .dpra(rx_rd_addr),                                     // I [`BF:0]
        .clk(rx_wr_clk),                                       // I 
        .qdpo_clk(rx_rd_clk),                                  // I
        .qdpo(rx_rd_data)                                      // O [63:0]
        );  //see pg063

    assign rx_wr_clk = clk156_25;                              // 156.25 MHz
    assign rx_rd_clk = trn_clk_c;                              // 250 MHz

    //-------------------------------------------------------
    // rx_mac_interface
    //-------------------------------------------------------
    rx_mac_interface rx_mac_interface_mod (
        .clk(clk156_25),                                       // I
        .reset(reset156_25),                                   // I
        .rx_data(mac_rx_data),                                 // I [63:0]
        .rx_data_valid(mac_rx_data_valid),                     // I [7:0]
        .rx_good_frame(mac_rx_good_frame),                     // I
        .rx_bad_frame(mac_rx_bad_frame),                       // I
        .wr_addr(rx_wr_addr),                                  // O [`BF:0]
        .wr_data(rx_wr_data),                                  // O [63:0]
        .rx_activity(rx_activity),                             // O
        .commited_wr_addr(rx_commited_wr_addr),                // O [`BF:0]
        .commited_rd_addr(rx_commited_rd_addr_synch),          // I [`BF:0]
        .sys_nsecs(sys_nsecs_synch),                           // I [31:0]
        .sys_secs(sys_secs_synch),                             // I [31:0]
        .sys_nsecs_update(sys_nsecs_update),                   // I
        .sys_secs_update(sys_secs_update),                     // I
        .timestamp_en(rx_timestamp_en),                        // I
        .dropped_pkts(rx_dropped_pkts)                         // O [15:0]
        );

    //-------------------------------------------------------
    // ns_synch
    //-------------------------------------------------------
    synch_type0 #(31,0) ns_synch_mod (
        .clk_out(clk156_25),                                    // I
        .reset_clk_out(reset156_25),                            // I
        .clk_in(trn_clk_c),                                     // I
        .reset_clk_in(reset250),                                // I
        .in(sys_nsecs),                                         // I [31:0]
        .out(sys_nsecs_synch),                                  // O [31:0]
        .update(sys_nsecs_update)                               // O
        );

    //-------------------------------------------------------
    // s_synch
    //-------------------------------------------------------
    synch_type0 #(31,0) s_synch_mod (
        .clk_out(clk156_25),                                    // I
        .reset_clk_out(reset156_25),                            // I
        .clk_in(trn_clk_c),                                     // I
        .reset_clk_in(reset250),                                // I
        .in(sys_secs),                                          // I [31:0]
        .out(sys_secs_synch),                                   // O [31:0]
        .update(sys_secs_update)                                // O
        );

    //-------------------------------------------------------
    // rx_rd_addr_synch
    //-------------------------------------------------------
    synch_type0 #(`BF,1) rx_rd_addr_synch_mod (
        .clk_out(clk156_25),                                    // I
        .reset_clk_out(reset156_25),                            // I
        .clk_in(trn_clk_c),                                     // I
        .reset_clk_in(reset250),                                // I
        .in(rx_commited_rd_addr),                               // I [`BF:0]
        .out(rx_commited_rd_addr_synch)                         // O [`BF:0]
        );

    //-------------------------------------------------------
    // rx_wr_addr_synch
    //-------------------------------------------------------
    synch_type1 #(`BF,1) rx_wr_addr_synch_mod (
        .clk_out(trn_clk_c),                                    // I
        .reset_clk_out(reset250),                               // I
        .clk_in(clk156_25),                                     // I
        .reset_clk_in(reset156_25),                             // I
        .in(rx_commited_wr_addr),                               // I [`BF:0]
        .out(rx_commited_wr_addr_synch)                         // O [`BF:0]
        );

    //-------------------------------------------------------
    // rx_dropped_pkts_synch
    //-------------------------------------------------------
    synch_type1 #(15,1) rx_dropped_pkts_synch_mod (
        .clk_out(trn_clk_c),                                    // I
        .reset_clk_out(reset250),                               // I
        .clk_in(clk156_25),                                     // I
        .reset_clk_in(reset156_25),                             // I
        .in(rx_dropped_pkts),                                   // I [15:0]
        .out(rx_dropped_pkts_synch)                             // O [15:0]
        );
    //////////////////////////////////////////////////////////////////////////////////////////
    // Reception side of the NIC (END)
    //////////////////////////////////////////////////////////////////////////////////////////

    //////////////////////////////////////////////////////////////////////////////////////////
    // Transmition side of the NIC (START)
    //////////////////////////////////////////////////////////////////////////////////////////
    //-------------------------------------------------------
    // internal_true_dual_port_ram tx
    //-------------------------------------------------------
    tx_buff #(.AW(9), .DW(64)) tx_buffer_mod (
        .a(tx_wr_addr),                                        // I [8:0]
        .d(tx_wr_data),                                        // I [63:0]
        .dpra(tx_rd_addr),                                     // I [8:0]
        .clk(tx_wr_clk),                                       // I 
        .qdpo_clk(tx_rd_clk),                                  // I
        .qdpo(tx_rd_data)                                      // O [63:0]
        );  //see pg063

    assign tx_rd_clk = clk156_25;                              // 156.25 MHz
    assign tx_wr_clk = trn_clk_c;                              // 250 MHz

    //-------------------------------------------------------
    // tx_mac_interface
    //-------------------------------------------------------
    tx_mac_interface tx_mac_interface_mod (
        .clk(clk156_25),                                       // I
        .reset(reset156_25),                                   // I
        .tx_underrun(mac_tx_underrun),                         // O
        .tx_data(mac_tx_data),                                 // O [63:0]
        .tx_data_valid(mac_tx_data_valid),                     // O [7:0]
        .tx_start(mac_tx_start),                               // O
        .tx_ack(mac_tx_ack),                                   // I
        .rd_addr(tx_rd_addr),                                  // O [8:0]
        .rd_data(tx_rd_data),                                  // I [63:0]
        .commited_rd_addr(tx_commited_rd_addr),                // O [9:0]
        .commited_wr_addr(tx_commited_wr_addr_synch)           // I [9:0]
        );

    //-------------------------------------------------------
    // tx_rd_addr_synch
    //-------------------------------------------------------
    synch_type1 #(9,1) tx_rd_addr_synch_mod (
        .clk_out(trn_clk_c),                                    // I
        .reset_clk_out(reset250),                               // I
        .clk_in(clk156_25),                                     // I
        .reset_clk_in(reset156_25),                             // I
        .in(tx_commited_rd_addr),                               // I [9:0]
        .out(tx_commited_rd_addr_synch)                         // O [9:0]
        );

    //-------------------------------------------------------
    // tx_wr_addr_synch
    //-------------------------------------------------------
    synch_type0 #(9,1) tx_wr_addr_synch_mod (
        .clk_out(clk156_25),                                    // I
        .reset_clk_out(reset156_25),                            // I
        .clk_in(trn_clk_c),                                     // I
        .reset_clk_in(reset250),                                // I
        .in(tx_commited_wr_addr),                               // I [9:0]
        .out(tx_commited_wr_addr_synch)                         // O [9:0]
        );
    //////////////////////////////////////////////////////////////////////////////////////////
    // Transmition side of the NIC (END)
    //////////////////////////////////////////////////////////////////////////////////////////


    //-------------------------------------------------------
    // Endpoint Implementation Application
    //-------------------------------------------------------
    pcie_endpoint_driver pcie_endpoint_driver_mod (
        
        // Transaction ( TRN ) Interface  //
        .trn_clk(trn_clk_c),                                      // I
        .reset250(reset250),                                      // I

        // Tx Local-Link  //
        .trn_td(trn_td_c),                                        // O [63/31:0]
        .trn_trem_n(trn_trem_n_c),                                // O [7:0]
        .trn_tsof_n(trn_tsof_n_c),                                // O
        .trn_teof_n(trn_teof_n_c),                                // O
        .trn_tsrc_rdy_n(trn_tsrc_rdy_n_c),                        // O
        .trn_tsrc_dsc_n(trn_tsrc_dsc_n_c),                        // O
        .trn_tdst_rdy_n(trn_tdst_rdy_n_c),                        // I
        .trn_tdst_dsc_n(trn_tdst_dsc_n_c),                        // I
        .trn_terrfwd_n(trn_terrfwd_n_c),                          // O
        .trn_tbuf_av(trn_tbuf_av_c),                              // I [4/3:0]

        // To rx_mac_interface  //
        .rx_activity(rx_activity),                                // I
        .rx_commited_rd_addr(rx_commited_rd_addr),                // O [`BF:0]
        .rx_commited_wr_addr(rx_commited_wr_addr_synch),          // I [`BF:0]
        .sys_nsecs(sys_nsecs),                                    // O [31:0]
        .sys_secs(sys_secs),                                      // O [31:0]
        .rx_timestamp_en(rx_timestamp_en),                        // O
        .rx_dropped_pkts(rx_dropped_pkts_synch),                  // I [15:0]

        // To mac_host_configuration_interface  //
        .host_clk(clk50),                                         // I 
        .host_reset(xaui_reset),                                  // I
        .reset156_25(reset156_25),                                // I
        .host_opcode(mac_host_opcode),                            // O [1:0] 
        .host_addr(mac_host_addr),                                // O [9:0] 
        .host_wr_data(mac_host_wr_data),                          // O [31:0] 
        .host_rd_data(mac_host_rd_data),                          // I [31:0] 
        .host_miim_sel(mac_host_miim_sel),                        // O 
        .host_req(mac_host_req),                                  // O 
        .host_miim_rdy(mac_host_miim_rdy),                        // I 
        
        // To internal_true_dual_port_ram RX  //
        .rx_rd_addr(rx_rd_addr),                                  // O [`BF:0]
        .rx_rd_data(rx_rd_data),                                  // I [63:0]

        // To internal_true_dual_port_ram TX  //
        .tx_wr_addr(tx_wr_addr),                                  // O [8:0]
        .tx_wr_data(tx_wr_data),                                  // O [63:0]

        // To tx_mac_interface
        .tx_commited_rd_addr(tx_commited_rd_addr_synch),          // I [9:0]
        .tx_commited_wr_addr(tx_commited_wr_addr),                // O [9:0]

        // Rx Local-Link  //
        .trn_rd(trn_rd_c),                                        // I [63/31:0]
        .trn_rrem(trn_rrem_n_c),                                  // I [7:0]
        .trn_rsof_n(trn_rsof_n_c),                                // I
        .trn_reof_n(trn_reof_n_c),                                // I
        .trn_rsrc_rdy_n(trn_rsrc_rdy_n_c),                        // I
        .trn_rsrc_dsc_n(trn_rsrc_dsc_n_c),                        // I
        .trn_rdst_rdy_n(trn_rdst_rdy_n_c),                        // O
        .trn_rerrfwd_n(trn_rerrfwd_n_c),                          // I
        .trn_rnp_ok_n(trn_rnp_ok_n_c),                            // O
        .trn_rbar_hit_n(trn_rbar_hit_n_c),                        // I [6:0]
        .trn_rfc_npd_av(trn_rfc_npd_av_c),                        // I [11:0]
        .trn_rfc_nph_av(trn_rfc_nph_av_c),                        // I [7:0]
        .trn_rfc_pd_av(trn_rfc_pd_av_c),                          // I [11:0]
        .trn_rfc_ph_av(trn_rfc_ph_av_c),                          // I [7:0]
        .trn_rcpl_streaming_n(trn_rcpl_streaming_n_c),            // O

        // Host ( CFG ) Interface  //
        .cfg_do(cfg_do_c),                                        // I [31:0]
        .cfg_rd_wr_done_n(cfg_rd_wr_done_n_c),                    // I
        .cfg_di(cfg_di_c),                                        // O [31:0]
        .cfg_byte_en_n(cfg_byte_en_n_c),                          // O
        .cfg_dwaddr(cfg_dwaddr_c),                                // O
        .cfg_wr_en_n(cfg_wr_en_n_c),                              // O
        .cfg_rd_en_n(cfg_rd_en_n_c),                              // O
        .cfg_err_cor_n(cfg_err_cor_n_c),                          // O
        .cfg_err_ur_n(cfg_err_ur_n_c),                            // O
        .cfg_err_cpl_rdy_n(cfg_err_cpl_rdy_n_c),                  // I
        .cfg_err_ecrc_n(cfg_err_ecrc_n_c),                        // O
        .cfg_err_cpl_timeout_n(cfg_err_cpl_timeout_n_c),          // O
        .cfg_err_cpl_abort_n(cfg_err_cpl_abort_n_c),              // O
        .cfg_err_cpl_unexpect_n(cfg_err_cpl_unexpect_n_c),        // O
        .cfg_err_posted_n(cfg_err_posted_n_c),                    // O
        .cfg_err_tlp_cpl_header(cfg_err_tlp_cpl_header_c),        // O [47:0]
        .cfg_interrupt_n(cfg_interrupt_n_c),                      // O
        .cfg_interrupt_rdy_n(cfg_interrupt_rdy_n_c),              // I

        .cfg_interrupt_assert_n(cfg_interrupt_assert_n_c),        // O
        .cfg_interrupt_di(cfg_interrupt_di_c),                    // O [7:0]
        .cfg_interrupt_do(cfg_interrupt_do_c),                    // I [7:0]
        .cfg_interrupt_mmenable(cfg_interrupt_mmenable_c),        // I [2:0]
        .cfg_interrupt_msienable(cfg_interrupt_msienable_c),      // I
        .cfg_to_turnoff_n(cfg_to_turnoff_n_c),                    // I
        .cfg_pm_wake_n(cfg_pm_wake_n_c),                          // O
        .cfg_pcie_link_state_n(cfg_pcie_link_state_n_c),          // I [2:0]
        .cfg_trn_pending_n(cfg_trn_pending_n_c),                  // O
        .cfg_dsn(cfg_dsn_n_c),                                    // O [63:0]

        .cfg_bus_number(cfg_bus_number_c),                        // I [7:0]
        .cfg_device_number(cfg_device_number_c),                  // I [4:0]
        .cfg_function_number(cfg_function_number_c),              // I [2:0]
        .cfg_status(cfg_status_c),                                // I [15:0]
        .cfg_command(cfg_command_c),                              // I [15:0]
        .cfg_dstatus(cfg_dstatus_c),                              // I [15:0]
        .cfg_dcommand(cfg_dcommand_c),                            // I [15:0]
        .cfg_lstatus(cfg_lstatus_c),                              // I [15:0]
        .cfg_lcommand(cfg_lcommand_c)                             // I [15:0]
        );

    //-------------------------------------------------------
    // pcie_endpoint_reset
    //-------------------------------------------------------
    pcie_endpoint_reset pcie_endpoint_reset_mod (
        .clk250(trn_clk_c),                                    // I
        .trn_reset_n(trn_reset_n_c),                           // I
        .trn_lnk_up_n(trn_lnk_up_n_c),                         // I
        .reset250(reset250)                                    // O
        );

    //-------------------------------------------------------
    // mac_reset
    //-------------------------------------------------------
    mac_reset mac_reset_mod (
        .clk156_25(clk156_25),                                 // I
        .xaui_reset(xaui_reset),                               // I
        .reset156_25(reset156_25)                              // O
        );

    //-------------------------------------------------------
    // endpoint_blk_plus_v1_15
    //-------------------------------------------------------
    endpoint_blk_plus_v1_15 ep  (

        //
        // PCI Express Fabric Interface
        //
        .pci_exp_txp( pci_exp_txp ),             // O [7/3/0:0]
        .pci_exp_txn( pci_exp_txn ),             // O [7/3/0:0]
        .pci_exp_rxp( pci_exp_rxp ),             // O [7/3/0:0]
        .pci_exp_rxn( pci_exp_rxn ),             // O [7/3/0:0]

        //
        // System ( SYS ) Interface
        //
        .sys_clk( sys_clk_c ),                                 // I
        .sys_reset_n( sys_reset_n_c ),                         // I
        .refclkout( refclkout ),                               // O

        //
        // Transaction ( TRN ) Interface
        //

        .trn_clk( trn_clk_c ),                   // O
        .trn_reset_n( trn_reset_n_c ),           // O
        .trn_lnk_up_n( trn_lnk_up_n_c ),         // O

        // Tx Local-Link

        .trn_td( trn_td_c ),                     // I [63/31:0]
        .trn_trem_n( trn_trem_n_c ),             // I [7:0]
        .trn_tsof_n( trn_tsof_n_c ),             // I
        .trn_teof_n( trn_teof_n_c ),             // I
        .trn_tsrc_rdy_n( trn_tsrc_rdy_n_c ),     // I
        .trn_tsrc_dsc_n( trn_tsrc_dsc_n_c ),     // I
        .trn_tdst_rdy_n( trn_tdst_rdy_n_c ),     // O
        .trn_tdst_dsc_n( trn_tdst_dsc_n_c ),     // O
        .trn_terrfwd_n( trn_terrfwd_n_c ),       // I
        .trn_tbuf_av( trn_tbuf_av_c ),           // O [4/3:0]

        // Rx Local-Link

        .trn_rd( trn_rd_c ),                     // O [63/31:0]
        .trn_rrem_n( trn_rrem_n_c ),             // O [7:0]
        .trn_rsof_n( trn_rsof_n_c ),             // O
        .trn_reof_n( trn_reof_n_c ),             // O
        .trn_rsrc_rdy_n( trn_rsrc_rdy_n_c ),     // O
        .trn_rsrc_dsc_n( trn_rsrc_dsc_n_c ),     // O
        .trn_rdst_rdy_n( trn_rdst_rdy_n_c ),     // I
        .trn_rerrfwd_n( trn_rerrfwd_n_c ),       // O
        .trn_rnp_ok_n( trn_rnp_ok_n_c ),         // I
        .trn_rbar_hit_n( trn_rbar_hit_n_c ),     // O [6:0]
        .trn_rfc_nph_av( trn_rfc_nph_av_c ),     // O [11:0]
        .trn_rfc_npd_av( trn_rfc_npd_av_c ),     // O [7:0]
        .trn_rfc_ph_av( trn_rfc_ph_av_c ),       // O [11:0]
        .trn_rfc_pd_av( trn_rfc_pd_av_c ),       // O [7:0]
        .trn_rcpl_streaming_n( trn_rcpl_streaming_n_c ),       // I

        //
        // Host ( CFG ) Interface
        //

        .cfg_do( cfg_do_c ),                                    // O [31:0]
        .cfg_rd_wr_done_n( cfg_rd_wr_done_n_c ),                // O
        .cfg_di( cfg_di_c ),                                    // I [31:0]
        .cfg_byte_en_n( cfg_byte_en_n_c ),                      // I [3:0]
        .cfg_dwaddr( cfg_dwaddr_c ),                            // I [9:0]
        .cfg_wr_en_n( cfg_wr_en_n_c ),                          // I
        .cfg_rd_en_n( cfg_rd_en_n_c ),                          // I

        .cfg_err_cor_n( cfg_err_cor_n_c ),                      // I
        .cfg_err_ur_n( cfg_err_ur_n_c ),                        // I
        .cfg_err_cpl_rdy_n( cfg_err_cpl_rdy_n_c ),              // O
        .cfg_err_ecrc_n( cfg_err_ecrc_n_c ),                    // I
        .cfg_err_cpl_timeout_n( cfg_err_cpl_timeout_n_c ),      // I
        .cfg_err_cpl_abort_n( cfg_err_cpl_abort_n_c ),          // I
        .cfg_err_cpl_unexpect_n( cfg_err_cpl_unexpect_n_c ),    // I
        .cfg_err_posted_n( cfg_err_posted_n_c ),                // I
        .cfg_err_tlp_cpl_header( cfg_err_tlp_cpl_header_c ),    // I [47:0]
        .cfg_err_locked_n( 1'b1 ),                // I
        .cfg_interrupt_n( cfg_interrupt_n_c ),                  // I
        .cfg_interrupt_rdy_n( cfg_interrupt_rdy_n_c ),          // O

        .cfg_interrupt_assert_n(cfg_interrupt_assert_n_c),      // I
        .cfg_interrupt_di(cfg_interrupt_di_c),                  // I [7:0]
        .cfg_interrupt_do(cfg_interrupt_do_c),                  // O [7:0]
        .cfg_interrupt_mmenable(cfg_interrupt_mmenable_c),      // O [2:0]
        .cfg_interrupt_msienable(cfg_interrupt_msienable_c),    // O
        .cfg_to_turnoff_n( cfg_to_turnoff_n_c ),                // I
        .cfg_pm_wake_n( cfg_pm_wake_n_c ),                      // I
        .cfg_pcie_link_state_n( cfg_pcie_link_state_n_c ),      // O [2:0]
        .cfg_trn_pending_n( cfg_trn_pending_n_c ),              // I
        .cfg_bus_number( cfg_bus_number_c ),                    // O [7:0]
        .cfg_device_number( cfg_device_number_c ),              // O [4:0]
        .cfg_function_number( cfg_function_number_c ),          // O [2:0]
        .cfg_status( cfg_status_c ),                            // O [15:0]
        .cfg_command( cfg_command_c ),                          // O [15:0]
        .cfg_dstatus( cfg_dstatus_c ),                          // O [15:0]
        .cfg_dcommand( cfg_dcommand_c ),                        // O [15:0]
        .cfg_lstatus( cfg_lstatus_c ),                          // O [15:0]
        .cfg_lcommand( cfg_lcommand_c ),                        // O [15:0]
        .cfg_dsn( cfg_dsn_n_c),                                 // I [63:0]


        // The following is used for simulation only.  Setting
        // the following core input to 1 will result in a fast
        // train simulation to happen.  This bit should not be set
        // during synthesis or the core may not operate properly.
        `ifdef SIMULATION
        .fast_train_simulation_only(1'b1)
        `else
        .fast_train_simulation_only(1'b0)
        `endif
        );


endmodule // my_top

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////