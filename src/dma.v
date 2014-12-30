/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        dma.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        Interconnects dma logic
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

module dma ( 

    // PCIe
    input                    sys_clk_p,
    input                    sys_clk_n,
    //input                    sys_reset_n,                // MF: no reset available
    output       [7:0]       pci_exp_txp,
    output       [7:0]       pci_exp_txn,
    input        [7:0]       pci_exp_rxp,
    input        [7:0]       pci_exp_rxn,

    input                    clk156_25,
    input                    reset156_25,

    // MAC tx
    output                   mac_tx_underrun,
    output       [63:0]      mac_tx_data,
    output       [7:0]       mac_tx_data_valid,
    output                   mac_tx_start,
    input                    mac_tx_ack,

    // MAC rx
    input        [63:0]      mac_rx_data,
    input        [7:0]       mac_rx_data_valid,
    input                    mac_rx_good_frame,
    input                    mac_rx_bad_frame

    );

    //-------------------------------------------------------
    // Local pcie_endpoint_reset 
    //-------------------------------------------------------
    wire                     reset250;

    //-------------------------------------------------------
    // Local PCIe ep
    //-------------------------------------------------------
    wire                     sys_clk_c;
    wire                     sys_reset_n_c;
    wire                     refclkout;
    // TRN intf
    wire                     trn_clk_c;
    wire                     trn_reset_n_c;
    wire                     trn_lnk_up_n_c;
    // Tx Local-Link
    wire         [63:0]      trn_td_c;
    wire         [7:0]       trn_trem_n_c;
    wire                     trn_tsof_n_c;
    wire                     trn_teof_n_c;
    wire                     trn_tsrc_rdy_n_c;
    wire                     trn_tsrc_dsc_n_c;
    wire                     trn_tdst_rdy_n_c;
    wire                     trn_tdst_dsc_n_c;
    wire                     trn_terrfwd_n_c;
    wire         [3:0]       trn_tbuf_av_c;
    // Rx Local-Link
    wire         [63:0]      trn_rd_c;
    wire         [7:0]       trn_rrem_n_c;
    wire                     trn_rsof_n_c;
    wire                     trn_reof_n_c;
    wire                     trn_rsrc_rdy_n_c;
    wire                     trn_rsrc_dsc_n_c;
    wire                     trn_rdst_rdy_n_c;
    wire                     trn_rerrfwd_n_c;
    wire                     trn_rnp_ok_n_c;
    wire         [6:0]       trn_rbar_hit_n_c;
    wire         [7:0]       trn_rfc_nph_av_c;
    wire         [11:0]      trn_rfc_npd_av_c;
    wire         [7:0]       trn_rfc_ph_av_c;
    wire         [11:0]      trn_rfc_pd_av_c;
    wire                     trn_rcpl_streaming_n_c;
    // CFG intf
    wire         [31:0]      cfg_do_c;
    wire                     cfg_rd_wr_done_n_c;
    wire         [31:0]      cfg_di_c;
    wire         [3:0]       cfg_byte_en_n_c;
    wire         [9:0]       cfg_dwaddr_c;
    wire                     cfg_wr_en_n_c;
    wire                     cfg_rd_en_n_c;
    wire                     cfg_err_cor_n_c;
    wire                     cfg_err_ur_n_c;
    wire                     cfg_err_cpl_rdy_n_c;
    wire                     cfg_err_ecrc_n_c;
    wire                     cfg_err_cpl_timeout_n_c;
    wire                     cfg_err_cpl_abort_n_c;
    wire                     cfg_err_cpl_unexpect_n_c;
    wire                     cfg_err_posted_n_c;
    wire         [47:0]      cfg_err_tlp_cpl_header_c;
    wire                     cfg_err_locked_n_c = 1'b1;
    wire                     cfg_interrupt_n_c;
    wire                     cfg_interrupt_rdy_n_c;
    wire                     cfg_interrupt_assert_n_c;
    wire         [7:0]       cfg_interrupt_di_c;
    wire         [7:0]       cfg_interrupt_do_c;
    wire         [2:0]       cfg_interrupt_mmenable_c;
    wire                     cfg_interrupt_msienable_c;
    wire                     cfg_to_turnoff_n_c;
    wire                     cfg_pm_wake_n_c;
    wire         [2:0]       cfg_pcie_link_state_n_c;
    wire                     cfg_trn_pending_n_c;
    wire         [7:0]       cfg_bus_number_c;
    wire         [4:0]       cfg_device_number_c;
    wire         [2:0]       cfg_function_number_c;
    wire         [15:0]      cfg_status_c;
    wire         [15:0]      cfg_command_c;
    wire         [15:0]      cfg_dstatus_c;
    wire         [15:0]      cfg_dcommand_c;
    wire         [15:0]      cfg_lstatus_c;
    wire         [15:0]      cfg_lcommand_c;
    wire         [63:0]      cfg_dsn_n_c;

    //-------------------------------------------------------
    // Virtex5-FX Global Clock Buffer
    //-------------------------------------------------------
    IBUFDS refclk_ibuf (.O(sys_clk_c), .I(sys_clk_p), .IB(sys_clk_n));  // 100 MHz

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
    // assigns
    //-------------------------------------------------------
    assign sys_reset_n_c = 1'b1;         // MF: no reset available
    assign trn_tsrc_dsc_n_c = 1'b1;      // MF: !discontinue
    assign trn_terrfwd_n_c = 1'b1;       // MF: !terrfwd
    assign trn_rdst_rdy_n_c = 1'b0;      // MF: always listen
    assign trn_rnp_ok_n_c = 1'b0;        // MF: rnp_ok
    assign trn_rcpl_streaming_n_c = 1'b0;   // MF: streaming
    assign cfg_interrupt_assert_n_c = 1'b1; // MF: not used with MSI
    assign cfg_interrupt_di_c = 8'b0;    // MF
    assign cfg_trn_pending_n_c = 1'b1;   // MF: needs implementation
    assign cfg_dsn_n_c = {32'h00000001,  {{8'h1},24'h000A35}};
    assign cfg_err_cor_n_c = 1'b1;
    assign cfg_err_ur_n_c = 1'b1;
    assign cfg_err_ecrc_n = 1'b1;
    assign cfg_err_cpl_timeout_n_c = 1'b1;
    assign cfg_err_cpl_abort_n_c = 1'b1;
    assign cfg_err_cpl_unexpect_n_c = 1'b1;
    assign cfg_err_posted_n_c = 1'b0;
    assign cfg_pm_wake_n_c = 1'b1;
    assign cfg_dwaddr_c = 'b0;
    assign cfg_rd_en_n_c = 1'b1;
    assign cfg_err_tlp_cpl_header_c = 'b0;
    assign cfg_di_c = 'b0;
    assign cfg_byte_en_n_c = 'hF;
    assign cfg_wr_en_n_c = 1'b1;

    //-------------------------------------------------------
    // PCIe ep
    //-------------------------------------------------------
    endpoint_blk_plus_v1_15 ep (
        // PCIe //
        .pci_exp_txp(pci_exp_txp),                             // O [7:0]
        .pci_exp_txn(pci_exp_txn),                             // O [7:0]
        .pci_exp_rxp(pci_exp_rxp),                             // O [7:0]
        .pci_exp_rxn(pci_exp_rxn),                             // O [7:0]
        .sys_clk(sys_clk_c),                                   // I
        .sys_reset_n(sys_reset_n_c),                           // I
        .refclkout(refclkout),                                 // O
        // TRN Intf
        .trn_clk(trn_clk_c),                                   // O
        .trn_reset_n(trn_reset_n_c),                           // O
        .trn_lnk_up_n(trn_lnk_up_n_c),                         // O
        // Tx Local-Link
        .trn_td(trn_td_c),                                     // I [63:0]
        .trn_trem_n(trn_trem_n_c),                             // I [7:0]
        .trn_tsof_n(trn_tsof_n_c),                             // I
        .trn_teof_n(trn_teof_n_c),                             // I
        .trn_tsrc_rdy_n(trn_tsrc_rdy_n_c),                     // I
        .trn_tsrc_dsc_n(trn_tsrc_dsc_n_c),                     // I
        .trn_tdst_rdy_n(trn_tdst_rdy_n_c),                     // O
        .trn_tdst_dsc_n(trn_tdst_dsc_n_c),                     // O
        .trn_terrfwd_n(trn_terrfwd_n_c),                       // I
        .trn_tbuf_av(trn_tbuf_av_c),                           // O [3:0]
        // Rx Local-Link
        .trn_rd(trn_rd_c),                                     // O [63:0]
        .trn_rrem_n(trn_rrem_n_c),                             // O [7:0]
        .trn_rsof_n(trn_rsof_n_c),                             // O
        .trn_reof_n(trn_reof_n_c),                             // O
        .trn_rsrc_rdy_n(trn_rsrc_rdy_n_c),                     // O
        .trn_rsrc_dsc_n(trn_rsrc_dsc_n_c),                     // O
        .trn_rdst_rdy_n(trn_rdst_rdy_n_c),                     // I
        .trn_rerrfwd_n(trn_rerrfwd_n_c),                       // O
        .trn_rnp_ok_n(trn_rnp_ok_n_c),                         // I
        .trn_rbar_hit_n(trn_rbar_hit_n_c),                     // O [6:0]
        .trn_rfc_nph_av(trn_rfc_nph_av_c),                     // O [11:0]
        .trn_rfc_npd_av(trn_rfc_npd_av_c),                     // O [7:0]
        .trn_rfc_ph_av(trn_rfc_ph_av_c),                       // O [11:0]
        .trn_rfc_pd_av(trn_rfc_pd_av_c),                       // O [7:0]
        .trn_rcpl_streaming_n(trn_rcpl_streaming_n_c),         // I
        // CFG Intf
        .cfg_do(cfg_do_c),                                     // O [31:0]
        .cfg_rd_wr_done_n(cfg_rd_wr_done_n_c),                 // O
        .cfg_di(cfg_di_c),                                     // I [31:0]
        .cfg_byte_en_n(cfg_byte_en_n_c),                       // I [3:0]
        .cfg_dwaddr(cfg_dwaddr_c),                             // I [9:0]
        .cfg_wr_en_n(cfg_wr_en_n_c),                           // I
        .cfg_rd_en_n(cfg_rd_en_n_c),                           // I
        .cfg_err_cor_n(cfg_err_cor_n_c),                       // I
        .cfg_err_ur_n(cfg_err_ur_n_c),                         // I
        .cfg_err_cpl_rdy_n(cfg_err_cpl_rdy_n_c),               // O
        .cfg_err_ecrc_n(cfg_err_ecrc_n_c),                     // I
        .cfg_err_cpl_timeout_n(cfg_err_cpl_timeout_n_c),       // I
        .cfg_err_cpl_abort_n(cfg_err_cpl_abort_n_c),           // I
        .cfg_err_cpl_unexpect_n(cfg_err_cpl_unexpect_n_c),     // I
        .cfg_err_posted_n(cfg_err_posted_n_c),                 // I
        .cfg_err_tlp_cpl_header(cfg_err_tlp_cpl_header_c),     // I [47:0]
        .cfg_err_locked_n(cfg_err_locked_n_c),                 // I
        .cfg_interrupt_n(cfg_interrupt_n_c),                   // I
        .cfg_interrupt_rdy_n(cfg_interrupt_rdy_n_c),           // O
        .cfg_interrupt_assert_n(cfg_interrupt_assert_n_c),     // I
        .cfg_interrupt_di(cfg_interrupt_di_c),                 // I [7:0]
        .cfg_interrupt_do(cfg_interrupt_do_c),                 // O [7:0]
        .cfg_interrupt_mmenable(cfg_interrupt_mmenable_c),     // O [2:0]
        .cfg_interrupt_msienable(cfg_interrupt_msienable_c),   // O
        .cfg_to_turnoff_n(cfg_to_turnoff_n_c),                 // O
        .cfg_pm_wake_n(cfg_pm_wake_n_c),                       // I
        .cfg_pcie_link_state_n(cfg_pcie_link_state_n_c),       // O [2:0]
        .cfg_trn_pending_n(cfg_trn_pending_n_c),               // I
        .cfg_bus_number(cfg_bus_number_c),                     // O [7:0]
        .cfg_device_number(cfg_device_number_c),               // O [4:0]
        .cfg_function_number(cfg_function_number_c),           // O [2:0]
        .cfg_status(cfg_status_c),                             // O [15:0]
        .cfg_command(cfg_command_c),                           // O [15:0]
        .cfg_dstatus(cfg_dstatus_c),                           // O [15:0]
        .cfg_dcommand(cfg_dcommand_c),                         // O [15:0]
        .cfg_lstatus(cfg_lstatus_c),                           // O [15:0]
        .cfg_lcommand(cfg_lcommand_c),                         // O [15:0]
        .cfg_dsn(cfg_dsn_n_c),                                 // I [63:0]
        `ifdef SIMULATION
        .fast_train_simulation_only(1'b1)
        `else
        .fast_train_simulation_only(1'b0)
        `endif
        );

endmodule // dma

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////