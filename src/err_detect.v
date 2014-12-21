/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        err_detect.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        
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

module err_detect (

    input                  trn_clk,
    input                  reset,
    
    input                  trn_rerrfwd_n,
    input      [15:0]      cfg_dstatus,

    output     [4:0]       detected_errors
    );

    // localparam
    localparam s0 = 8'b00000000;
    localparam s1 = 8'b00000001;
    localparam s2 = 8'b00000010;
    localparam s3 = 8'b00000100;
    localparam s4 = 8'b00001000;
    localparam s5 = 8'b00010000;
    localparam s6 = 8'b00100000;
    localparam s7 = 8'b01000000;
    localparam s8 = 8'b10000000;

    //-------------------------------------------------------
    // Local 
    //-------------------------------------------------------
    reg             trn_rerrfwd_n_reg0;
    reg             trn_rerrfwd_n_reg1;
    reg     [15:0]  cfg_dstatus_reg0;
    reg     [15:0]  cfg_dstatus_reg1;

    assign detected_errors = {trn_rerrfwd_n_reg1, cfg_dstatus_reg1[3:0]};

    ////////////////////////////////////////////////
    // 
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        trn_rerrfwd_n_reg0 <= trn_rerrfwd_n;
        trn_rerrfwd_n_reg1 <= trn_rerrfwd_n_reg0;

        cfg_dstatus_reg0 <= cfg_dstatus;
        cfg_dstatus_reg1 <= cfg_dstatus_reg0;

    end  //always
   

endmodule // err_detect

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////