/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        tx_retry_mon.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        Retries if no answer
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

`define CPL_W_DATA_FMT_TYPE 7'b10_01010
`define SC 3'b000


module tx_retry_mon (

    input                   trn_clk,
    input                   reset,

    input       [63:0]      trn_rd,
    input       [7:0]       trn_rrem_n,
    input                   trn_rsof_n,
    input                   trn_reof_n,
    input                   trn_rsrc_rdy_n,
    input                   trn_rsrc_dsc_n,
    input       [6:0]       trn_rbar_hit_n,
    input                   trn_rdst_rdy_n,

    input        [63:0]     huge_page_addr_read_from,
    input                   read_chunk,
    input        [3:0]      tlp_tag,
    input        [8:0]      qwords_to_rd,
    input                   read_chunk_ack,

    output reg   [63:0]     retry_huge_page_addr_read_from,
    output reg              retry_read_chunk,
    output reg   [3:0]      retry_tlp_tag,
    output reg   [9:0]      retry_dwords_to_rd,
    input                   retry_read_chunk_ack
    );

    // localparam
    localparam s0  = 16'b0000000000000000;
    localparam s1  = 16'b0000000000000001;
    localparam s2  = 16'b0000000000000010;
    localparam s3  = 16'b0000000000000100;
    localparam s4  = 16'b0000000000001000;
    localparam s5  = 16'b0000000000010000;
    localparam s6  = 16'b0000000000100000;
    localparam s7  = 16'b0000000001000000;
    localparam s8  = 16'b0000000010000000;
    localparam s9  = 16'b0000000100000000;
    localparam s10 = 16'b0000001000000000;
    localparam s11 = 16'b0000010000000000;
    localparam s12 = 16'b0000100000000000;
    localparam s13 = 16'b0001000000000000;
    localparam s14 = 16'b0010000000000000;
    localparam s15 = 16'b0100000000000000;
    localparam s16 = 16'b1000000000000000;

    //-------------------------------------------------------
    // Local register_reads_and_cpl
    //-------------------------------------------------------
    reg     [15:0]  register_fsm;
    reg     [15:0]  cpl_fsm;
    reg     [3:0]   pending_trans;
    reg             cpl_received;
    reg             update_values;
    reg     [63:0]  host_addr;
    reg     [3:0]   tlp_tag_reg;
    reg     [9:0]   dwords_to_rd_reg;
    reg     [63:0]  host_addr_mem[0:3];
    reg     [3:0]   tag_mem[0:3];
    reg     [9:0]   req_dw_mem[0:3];
    reg     [15:0]  counter[0:3];
    reg     [9:0]   dwords_on_tlp;
    reg     [3:0]   this_tlp_tag;
    reg     [63:0]  next_host_addr;
    reg     [9:0]   next_req_dw;
    reg     [3:0]   tag_to_update;
    reg             check_fin;
    
    integer i;

    //-------------------------------------------------------
    // Local monitor_timeout_and_re_send_req
    //-------------------------------------------------------
    reg     [15:0]  mon_fsm;
    reg     [4:0]   index;          // would be extended to support 32 tags for multiple DMA engines
    reg     [4:0]   mon_index;
    

    ////////////////////////////////////////////////
    // register_reads_and_cpl
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        if (reset) begin  // reset
            pending_trans <= 'b0;
            register_fsm <= s0;
        end
        
        else begin  // not reset

            cpl_received <= 1'b0;
            update_values <= 1'b0;
            check_fin <= 1'b0;

            next_host_addr <= host_addr_mem[this_tlp_tag] + {dwords_on_tlp, 2'b0};
            next_req_dw <= req_dw_mem[this_tlp_tag] + (~dwords_on_tlp) + 1;
            if (cpl_received) begin
                update_values <= 1'b1;
                tag_to_update <= this_tlp_tag;
            end
            if (update_values) begin
                host_addr_mem[tag_to_update] <= next_host_addr;
                req_dw_mem[tag_to_update] <= next_req_dw;
                check_fin <= 1'b1;
            end
            if (check_fin) begin
                if (!next_req_dw) begin
                    pending_trans[tag_to_update] <= 1'b0;
                end
            end
            

            for (i = 0; i < 4; i = i +1) begin
                counter[i] <= counter[i] + 1;
            end

            if (retry_read_chunk && retry_read_chunk_ack) begin
                pending_trans[retry_tlp_tag] <= 1'b0;
                counter[retry_tlp_tag] <= 'b0;
            end

            case (register_fsm)
                s0 : begin
                    host_addr <= huge_page_addr_read_from;
                    tlp_tag_reg <= tlp_tag;
                    dwords_to_rd_reg <= qwords_to_rd;
                    if (read_chunk && read_chunk_ack) begin
                        register_fsm <= s1;
                    end
                end

                s1 : begin
                    host_addr_mem[tlp_tag_reg] <= host_addr;
                    tag_mem[tlp_tag_reg] <= tlp_tag_reg;
                    req_dw_mem[tlp_tag_reg] <= dwords_to_rd_reg;
                    counter[tlp_tag_reg] <= 'b0;
                    pending_trans[tlp_tag_reg] <= 1'b1;
                    register_fsm <= s0;
                end

                default : begin
                    register_fsm <= s0;
                end
            endcase

            case (cpl_fsm)
                s0 : begin
                    dwords_on_tlp <= trn_rd[41:32];
                    if ( (!trn_rsrc_rdy_n) && (!trn_rsof_n) && (!trn_rdst_rdy_n)) begin
                        if ( (trn_rd[62:56] == `CPL_W_DATA_FMT_TYPE) && (trn_rd[15:13] == `SC) ) begin
                            cpl_fsm <= s1;
                        end
                    end
                end

                s1 : begin
                    this_tlp_tag <= trn_rd[43:40];
                    cpl_received <= 1'b1;
                    cpl_fsm <= s0;
                end

                default : begin //other TLPs
                    cpl_fsm <= s0;
                end
            endcase

        end     // not reset
    end  //always

    ////////////////////////////////////////////////
    // monitor_timeout_and_re_send_req
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        if (reset) begin  // reset
            retry_read_chunk <= 1'b0;
            mon_fsm <= s0;
        end
        
        else begin  // not reset

            case (mon_fsm)

                s0 : begin
                    index <= index + 1;
                    mon_index <= index;
                    if (pending_trans[index]) begin
                        mon_fsm <= s1;
                    end
                end

                s1 : begin
                    if (counter[mon_index][13]) begin
                        mon_fsm <= s2;
                    end
                    else begin
                        mon_fsm <= s0;
                    end
                end

                s2 : begin
                    retry_huge_page_addr_read_from <= host_addr_mem[mon_index];
                    retry_tlp_tag <= tag_mem[mon_index];
                    retry_dwords_to_rd <= req_dw_mem[mon_index];
                    retry_read_chunk <= 1'b1;
                    mon_fsm <= s3;
                end

                s3 : begin
                    if (retry_read_chunk_ack) begin
                        retry_read_chunk <= 1'b0;
                        mon_fsm <= s4;
                    end
                end

                s4 : begin
                    //delay : pending_trans
                    mon_fsm <= s0;
                end

                default : begin
                    mon_fsm <= s0;
                end

            endcase
        end     // not reset
    end  //always

endmodule // tx_retry_mon

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
