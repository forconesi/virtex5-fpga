/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        top.v
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

module top ( 
    // PCIe
    input                    sys_clk_p,
    input                    sys_clk_n,
    //input                    sys_reset_n,    // MF: no reset available
    output       [7:0]       pci_exp_txp,
    output       [7:0]       pci_exp_txn,
    input        [7:0]       pci_exp_rxp,
    input        [7:0]       pci_exp_rxn
    );

    //-------------------------------------------------------
    // Local DMA
    //-------------------------------------------------------
    wire                     pcie_clk;
    wire                     pcie_rst;
    // Tx
    wire         [63:0]      M_AXIS_TDATA_DMA;
    wire         [7:0]       M_AXIS_TSTRB_DMA;
    wire         [127:0]     M_AXIS_TUSER_DMA; 
    wire                     M_AXIS_TLAST_DMA;
    wire                     M_AXIS_TVALID_DMA;
    wire                     M_AXIS_TREADY_DMA;
    wire                     M_AXIS_ARESETN_DMA;
    // Rx
    wire         [63:0]      S_AXIS_TDATA_DMA;
    wire         [7:0]       S_AXIS_TSTRB_DMA;
    wire         [127:0]     S_AXIS_TUSER_DMA;
    wire                     S_AXIS_TLAST_DMA;
    wire                     S_AXIS_TVALID_DMA;
    wire                     S_AXIS_TREADY_DMA;
    wire                     S_AXIS_ARESETN_DMA;
    // REGIF
    wire                     M_AXI_LITE_ACLK;
    wire                     M_AXI_LITE_ARESETN;
    wire                     IP2Bus_MstRd_Req;
    wire                     IP2Bus_MstWr_Req;
    wire         [31:0]      IP2Bus_Mst_Addr;
    wire         [3:0]       IP2Bus_Mst_BE;
    wire                     IP2Bus_Mst_Lock;
    wire                     IP2Bus_Mst_Reset;
    wire                     Bus2IP_Mst_CmdAck;
    wire                     Bus2IP_Mst_Cmplt;
    wire                     Bus2IP_Mst_Error;
    wire                     Bus2IP_Mst_Rearbitrate;
    wire                     Bus2IP_Mst_Timeout;
    wire         [31:0]      Bus2IP_MstRd_d;
    wire                     Bus2IP_MstRd_src_rdy_n;
    wire         [31:0]      IP2Bus_MstWr_d;
    wire                     Bus2IP_MstWr_dst_rdy_n;

    //-------------------------------------------------------
    // NAAS_DMA
    //-------------------------------------------------------
    naas_dma_v5 #(
        .CHN0_RX_CONFIG_TIMESTAMP(0),
        .CONFIG_MDIO_IF(1),
        .CONFIG_REGIF(1)
    ) naas_dma_mod (
        // PCIe
        .sys_clk_p(sys_clk_p),                                 // I
        .sys_clk_n(sys_clk_n),                                 // I
        .pci_exp_txp(pci_exp_txp),                             // O [7:0]
        .pci_exp_txn(pci_exp_txn),                             // O [7:0]
        .pci_exp_rxp(pci_exp_rxp),                             // I [7:0]
        .pci_exp_rxn(pci_exp_rxn),                             // I [7:0]
        .pcie_clk(pcie_clk),                                   // O
        .pcie_rst(pcie_rst),                                   // O
        // BKD
        .bkd_clk(pcie_clk),                                    // I
        .bkd_rst(pcie_rst),                                    // I
        // BKD tx
        .m_axis_tdata(M_AXIS_TDATA_DMA),                       // O [63:0]
        .m_axis_tstrb(M_AXIS_TSTRB_DMA),                       // O [7:0]
        .m_axis_tuser(M_AXIS_TUSER_DMA),                       // O [127:0]
        .m_axis_tvalid(M_AXIS_TVALID_DMA),                     // O
        .m_axis_tlast(M_AXIS_TLAST_DMA),                       // O
        .m_axis_tready(M_AXIS_TREADY_DMA),                     // I
        // BKD rx
        .s_axis_tdata(M_AXIS_TDATA_DMA),                       // I [63:0]
        .s_axis_tstrb(M_AXIS_TSTRB_DMA),                       // I [7:0]
        .s_axis_tuser(M_AXIS_TUSER_DMA),                       // I [127:0]
        .s_axis_tvalid(M_AXIS_TVALID_DMA),                     // I
        .s_axis_tlast(M_AXIS_TLAST_DMA),                       // I
        .s_axis_tready(M_AXIS_TREADY_DMA),                     // O
        // REGIF
        .reg_int_clk(M_AXI_LITE_ACLK),                         // I
        .reg_int_reset_n(M_AXI_LITE_ARESETN),                  // I
        .IP2Bus_MstRd_Req(IP2Bus_MstRd_Req),                   // O
        .IP2Bus_MstWr_Req(IP2Bus_MstWr_Req),                   // O
        .IP2Bus_Mst_Addr(IP2Bus_Mst_Addr),                     // O [31:0]
        .IP2Bus_Mst_BE(IP2Bus_Mst_BE),                         // O [3:0]
        .IP2Bus_Mst_Lock(IP2Bus_Mst_Lock),                     // O
        .IP2Bus_Mst_Reset(IP2Bus_Mst_Reset),                   // O
        .Bus2IP_Mst_CmdAck(Bus2IP_Mst_CmdAck),                 // I
        .Bus2IP_Mst_Cmplt(Bus2IP_Mst_Cmplt),                   // I
        .Bus2IP_Mst_Error(Bus2IP_Mst_Error),                   // I
        .Bus2IP_Mst_Rearbitrate(Bus2IP_Mst_Rearbitrate),       // I
        .Bus2IP_Mst_Timeout(Bus2IP_Mst_Timeout),               // I
        .Bus2IP_MstRd_d(Bus2IP_MstRd_d),                       // I [31:0]
        .Bus2IP_MstRd_src_rdy_n(Bus2IP_MstRd_src_rdy_n),       // I
        .IP2Bus_MstWr_d(IP2Bus_MstWr_d),                       // O [31:0]
        .Bus2IP_MstWr_dst_rdy_n(Bus2IP_MstWr_dst_rdy_n),       // I
        // MDIO conf intf
        .mac_host_clk(mac_host_clk),                           // I
        .mac_host_reset(mac_host_reset),                       // I
        .mac_host_opcode(mac_host_opcode),                     // O [1:0]
        .mac_host_addr(mac_host_addr),                         // O [9:0]
        .mac_host_wr_data(mac_host_wr_data),                   // O [31:0]
        .mac_host_rd_data(mac_host_rd_data),                   // I [31:0]
        .mac_host_miim_sel(mac_host_miim_sel),                 // O
        .mac_host_req(mac_host_req),                           // O
        .mac_host_miim_rdy(mac_host_miim_rdy)                  // I
        );

endmodule // top

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////