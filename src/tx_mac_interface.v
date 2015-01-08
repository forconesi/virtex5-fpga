/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        tx_mac_interface.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        Sends ethernet frames to the MAC core. Packets are read from the
*        tx internal buffer. Synchronization is recovered from the packet
*        length located at the top of each packet.
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

module tx_mac_interface (

    input    clk,
    input    reset,

    // MAC Rx
    output                 tx_underrun,
    output     [63:0]      tx_data,
    output     [7:0]       tx_data_valid,
    output                 tx_start,
    input                     tx_ack,

    // Internal memory driver
    output        [8:0]       rd_addr,
    input         [63:0]      rd_data,
    
    
    // Internal logic
    output     [9:0]       commited_rd_addr,
    input         [9:0]       commited_wr_addr

    );

    assign commited_rd_addr = commited_wr_addr;
    assign rd_addr = 'b0;
    assign tx_underrun = 'b0;
    assign tx_data = 'b0;
    assign tx_data_valid = 'b0;
    assign tx_start = 'b0;

endmodule // tx_mac_interface

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////