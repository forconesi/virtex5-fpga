/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        expansion_rom.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        Completes with zeros rd request to expansion rom.
*
*        TODO: 
*        The module will inform the advetised the size of the huge page given by
*        the driver.
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

`define MEM_WR64_FMT_TYPE 7'b11_00000
`define MEM_WR32_FMT_TYPE 7'b10_00000
`define MEM_RD64_FMT_TYPE 7'b01_00000
`define MEM_RD32_FMT_TYPE 7'b00_00000

module expansion_rom (

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

    output reg  [63:0]      trn_td,
    output reg  [7:0]       trn_trem_n,
    output reg              trn_tsof_n,
    output reg              trn_teof_n,
    output reg              trn_tsrc_rdy_n,
    input                   trn_tdst_rdy_n,
    input       [3:0]       trn_tbuf_av,
    input       [15:0]      cfg_completer_id
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
    // Local Expansion_rom_rd_request
    //-------------------------------------------------------
    reg     [7:0]   rd_req_fsm;
    reg     [1:0]   attr;
    reg     [7:0]   tag;
    reg     [9:0]   lenght;
    reg     [2:0]   tc;
    reg     [15:0]  req_id;
    reg     [3:0]   first_be;
    reg     [3:0]   last_be;
    reg             send_completion;

    //-------------------------------------------------------
    // Local Expansion_rom_completion
    //-------------------------------------------------------
    reg     [7:0]   compl_fsm;
    reg     [1:0]   reg_attr;
    reg     [7:0]   reg_tag;
    reg     [9:0]   reg_lenght;
    reg     [2:0]   reg_tc;
    reg     [15:0]  reg_req_id;
    reg     [3:0]   reg_first_be;
    reg     [3:0]   reg_last_be;

    ////////////////////////////////////////////////
    // Expansion_rom_rd_request
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        if (reset) begin  // reset
            rd_req_fsm <= s0;
        end
        
        else begin  // not reset

            send_completion <= 1'b0;

            case (rd_req_fsm)

                s0 : begin
                    tc <= trn_rd[54:52];
                    attr <= trn_rd[45:44];
                    lenght <= trn_rd[41:32];
                    req_id <= trn_rd[31:16];
                    tag <= trn_rd[15:8];
                    last_be <= trn_rd[7:4];
                    first_be <= trn_rd[3:0];
                    if ( (!trn_rsrc_rdy_n) && (!trn_rsof_n) && (!trn_rdst_rdy_n) && (!trn_rbar_hit_n[6])) begin
                        if (trn_rd[62:56] == `MEM_RD32_FMT_TYPE || trn_rd[62:56] == `MEM_RD64_FMT_TYPE) begin
                            rd_req_fsm <= s1;
                        end
                    end
                end

                s1 : begin
                    send_completion <= 1'b1;
                    rd_req_fsm <= s0;
                end

                default : begin //other TLPs
                    rd_req_fsm <= s0;
                end

            endcase
        end     // not reset
    end  //always

    ////////////////////////////////////////////////
    // Expansion_rom_completion
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        if (reset) begin  // reset
            trn_tsof_n <= 1'b1;
            trn_teof_n <= 1'b1;
            trn_tsrc_rdy_n <= 1'b1;
            compl_fsm <= s0;
        end
        
        else begin  // not reset

            case (compl_fsm)

                s0 : begin
                    trn_td <= 'b0;
                    trn_trem_n <= 'hFF;

                    reg_attr <= attr;
                    reg_tag <= tag;
                    reg_lenght <= lenght;
                    reg_tc <= tc;
                    reg_req_id <= req_id;
                    reg_first_be <= first_be;
                    reg_last_be <= last_be;

                    if (send_completion) begin
                        compl_fsm <= s1;
                    end
                end

                s1 : begin
                    qwords_in_tlp <= {3'b0, qwords_to_send};

                    driving_interface <= 1'b0;                                              // we're taking the risk of starving the tx process
                    trn_td <= 64'b0;
                    trn_trem_n <= 8'hFF;
                    if ( (trn_tbuf_av[1]) && (!trn_tdst_rdy_n) && (my_turn || driving_interface) ) begin
                        if (change_huge_page) begin
                            notify_huge_page_change <= 1'b1;
                            change_huge_page_ack <= 1'b1;
                            driving_interface <= 1'b1;
                            compl_fsm <= s10;
                        end
                        else if (trigger_tlp) begin
                            driving_interface <= 1'b1;
                            trigger_tlp_ack <= 1'b1;
                            compl_fsm <= s2;
                        end
                        else if (send_numb_qws) begin
                            notify_huge_page_change <= 1'b0;
                            send_numb_qws_ack <= 1'b1;
                            driving_interface <= 1'b1;
                            compl_fsm <= s10;
                        end
                    end
                end

                s2 : begin
                    trn_trem_n <= 8'b0;
                    trn_td[63:32] <= {
                                1'b0,   //reserved
                                `MEM_WR64_FMT_TYPE, //memory write request 64bit addressing
                                1'b0,   //reserved
                                3'b0,   //TC (traffic class)
                                4'b0,   //reserved
                                1'b0,   //TD (TLP digest present)
                                1'b0,   //EP (poisoned data)
                                2'b00,  //Relaxed ordering, No snoop in processor cache
                                2'b0,   //reserved
                                {qwords_in_tlp, 1'b0}  //lenght in DWs. 10-bit field    // QWs x2 equals DWs
                            };
                    trn_td[31:0] <= {
                                cfg_completer_id,   //Requester ID
                                {4'b0, tlp_number[3:0] },   //Tag
                                4'hF,   //last DW byte enable
                                4'hF    //1st DW byte enable
                            };
                    trn_tsof_n <= 1'b0;
                    trn_tsrc_rdy_n <= 1'b0;
                    rd_addr <= rd_addr +1;

                    look_ahead_host_mem_addr <= host_mem_addr + 'h80;
                    look_ahead_huge_page_qword_counter <= huge_page_qword_counter + qwords_in_tlp;
                    look_ahead_tlp_number <= tlp_number +1;
                    look_ahead_commited_rd_addr <= commited_rd_addr + qwords_in_tlp;

                    compl_fsm <= s3;
                end

                s3 : begin
                    tlp_qword_counter <= 9'b1;
                    if (!trn_tdst_rdy_n) begin
                        trn_tsof_n <= 1'b1;
                        trn_tsrc_rdy_n <= 1'b0;
                        trn_td <= host_mem_addr;
                        rd_addr <= rd_addr +1;
                        compl_fsm <= s6;
                    end
                    else begin
                        rd_addr <= rd_addr_prev2;
                        compl_fsm <= s4;
                    end
                end

                s4 : begin
                    if (!trn_tdst_rdy_n) begin
                        rd_addr <= rd_addr +1;
                        trn_tsrc_rdy_n <= 1'b1;
                        trn_tsof_n <= 1'b1;
                        compl_fsm <= s5;
                    end
                end

                s5 : begin
                    trn_tsrc_rdy_n <= 1'b1;
                    rd_addr <= rd_addr +1;
                    compl_fsm <= s3;
                end

                s6 : begin
                    if (!trn_tdst_rdy_n) begin
                        trn_tsrc_rdy_n <= 1'b0;
                        trn_td <= {rd_data[7:0], rd_data[15:8], rd_data[23:16], rd_data[31:24], rd_data[39:32], rd_data[47:40], rd_data[55:48] ,rd_data[63:56]};

                        rd_addr <= rd_addr +1;

                        tlp_qword_counter <= tlp_qword_counter +1;
                        if (tlp_qword_counter == qwords_in_tlp) begin
                            trn_teof_n <= 1'b0;
                            compl_fsm <= s9;
                        end
                    end
                    else begin
                        rd_addr <= rd_addr_prev2;
                        compl_fsm <= s7;
                    end
                end

                s7 : begin
                    if (!trn_tdst_rdy_n) begin
                        rd_addr <= rd_addr +1;
                        trn_tsrc_rdy_n <= 1'b1;
                        compl_fsm <= s8;
                    end
                end

                s8 : begin
                    trn_tsrc_rdy_n <= 1'b1;
                    rd_addr <= rd_addr +1;
                    compl_fsm <= s6;
                end

                s9 : begin
                    commited_rd_addr <= look_ahead_commited_rd_addr;
                    rd_addr <= look_ahead_commited_rd_addr;
                    host_mem_addr <= look_ahead_host_mem_addr;
                    huge_page_qword_counter <= look_ahead_huge_page_qword_counter;
                    tlp_number <= look_ahead_tlp_number;
                    if (!trn_tdst_rdy_n) begin
                        trn_teof_n <= 1'b1;
                        trn_tsrc_rdy_n <= 1'b1;
                        compl_fsm <= s1;
                    end
                end

                s10 : begin
                    trn_trem_n <= 8'b0;
                    trn_td[63:32] <= {
                                1'b0,   //reserved
                                `MEM_WR64_FMT_TYPE, //memory write request 64bit addressing
                                1'b0,   //reserved
                                3'b0,   //TC (traffic class)
                                4'b0,   //reserved
                                1'b0,   //TD (TLP digest present)
                                1'b0,   //EP (poisoned data)
                                2'b00,  //Relaxed ordering, No snoop in processor cache
                                2'b0,   //reserved
                                10'h02  //lenght equal 2 DW 
                            };
                    trn_td[31:0] <= {
                                cfg_completer_id,   //Requester ID
                                {4'b0, 4'b0 },   //Tag
                                4'hF,   //last DW byte enable
                                4'hF    //1st DW byte enable
                            };
                    trn_tsof_n <= 1'b0;
                    trn_tsrc_rdy_n <= 1'b0;
                    aux_qw_count <= huge_page_qword_counter;
                    next_qw_counter <= huge_page_qword_counter + 'hF;
                    compl_fsm <= s11;
                end

                s11 : begin
                    if (!trn_tdst_rdy_n) begin
                        trn_tsof_n <= 1'b1;
                        return_huge_page_to_host <= notify_huge_page_change;
                        trn_td <= current_huge_page_addr;
                        compl_fsm <= s12;
                    end
                end

                s12 : begin
                    huge_page_qword_counter <= {next_qw_counter[31:4], 4'b0};
                    if (!trn_tdst_rdy_n) begin
                        trn_td <= {aux_qw_count[7:0], aux_qw_count[15:8], aux_qw_count[23:16], aux_qw_count[31:24], {7'b0, notify_huge_page_change}, 24'b0};
                        trn_teof_n <= 1'b0;
                        compl_fsm <= s13;
                    end
                end

                s13 : begin
                    if (!trn_tdst_rdy_n) begin
                        trn_teof_n <= 1'b1;
                        trn_tsrc_rdy_n <= 1'b1;
                        if (notify_huge_page_change) begin
                            compl_fsm <= s0;
                        end
                        else begin
                            compl_fsm <= s1;
                        end
                    end
                end

                s14 : begin
                    qwords_in_tlp <= {3'b0, qwords_to_send};

                    driving_interface <= 1'b0;                                              // we're taking the risk of starving the tx process
                    trn_td <= 64'b0;
                    trn_trem_n <= 8'hFF;
                    if ( (trn_tbuf_av[1]) && (!trn_tdst_rdy_n) && (my_turn || driving_interface) ) begin
                        if (change_huge_page) begin
                            notify_huge_page_change <= 1'b1;
                            change_huge_page_ack <= 1'b1;
                            driving_interface <= 1'b1;
                            compl_fsm <= s24;
                        end
                        else if (trigger_tlp) begin
                            driving_interface <= 1'b1;
                            trigger_tlp_ack <= 1'b1;
                            compl_fsm <= s15;
                        end
                        else if (send_numb_qws) begin
                            notify_huge_page_change <= 1'b0;
                            send_numb_qws_ack <= 1'b1;
                            driving_interface <= 1'b1;
                            compl_fsm <= s24;
                        end
                    end
                end

                s15 : begin
                    rd_addr <= rd_addr +1;
                    compl_fsm <= s16;
                end

                s16 : begin
                    trn_trem_n <= 8'h0F;
                    trn_td[63:32] <= {
                                1'b0,   //reserved
                                `MEM_WR32_FMT_TYPE, //memory write request 32bit addressing
                                1'b0,   //reserved
                                3'b0,   //TC (traffic class)
                                4'b0,   //reserved
                                1'b0,   //TD (TLP digest present)
                                1'b0,   //EP (poisoned data)
                                2'b00,  //Relaxed ordering, No snoop in processor cache
                                2'b0,   //reserved
                                {qwords_in_tlp, 1'b0}  //lenght in DWs. 10-bit field    // QWs x2 equals DWs
                            };
                    trn_td[31:0] <= {
                                cfg_completer_id,   //Requester ID
                                {4'b0, tlp_number[3:0] },   //Tag
                                4'hF,   //last DW byte enable
                                4'hF    //1st DW byte enable
                            };
                    trn_tsof_n <= 1'b0;
                    trn_tsrc_rdy_n <= 1'b0;
                    rd_addr <= rd_addr +1;

                    look_ahead_host_mem_addr <= host_mem_addr + 'h80;
                    look_ahead_huge_page_qword_counter <= huge_page_qword_counter + qwords_in_tlp;
                    look_ahead_tlp_number <= tlp_number +1;
                    look_ahead_commited_rd_addr <= commited_rd_addr + qwords_in_tlp;

                    compl_fsm <= s17;
                end

                s17 : begin
                    aux_rd_data <= rd_data[63:32];
                    tlp_qword_counter <= 9'b1;
                    if (!trn_tdst_rdy_n) begin
                        trn_tsof_n <= 1'b1;
                        trn_tsrc_rdy_n <= 1'b0;
                        trn_td <= {host_mem_addr[31:0], rd_data[7:0], rd_data[15:8], rd_data[23:16], rd_data[31:24]};
                        rd_addr <= rd_addr +1;
                        compl_fsm <= s20;
                    end
                    else begin
                        rd_addr <= rd_addr_prev2;
                        compl_fsm <= s18;
                    end
                end

                s18 : begin
                    if (!trn_tdst_rdy_n) begin
                        rd_addr <= rd_addr +1;
                        trn_tsrc_rdy_n <= 1'b1;
                        trn_tsof_n <= 1'b1;
                        compl_fsm <= s19;
                    end
                end

                s19 : begin
                    trn_tsrc_rdy_n <= 1'b1;
                    rd_addr <= rd_addr +1;
                    compl_fsm <= s17;
                end

                s20 : begin
                    if (!trn_tdst_rdy_n) begin
                        trn_tsrc_rdy_n <= 1'b0;
                        aux_rd_data <= rd_data[63:32];
                        trn_td <= {aux_rd_data[7:0], aux_rd_data[15:8], aux_rd_data[23:16], aux_rd_data[31:24], rd_data[7:0], rd_data[15:8], rd_data[23:16], rd_data[31:24]};
                        rd_addr <= rd_addr +1;
                        tlp_qword_counter <= tlp_qword_counter +1;
                        if (tlp_qword_counter == qwords_in_tlp) begin
                            trn_teof_n <= 1'b0;
                            compl_fsm <= s23;
                        end
                    end
                    else begin
                        rd_addr <= rd_addr_prev2;
                        compl_fsm <= s21;
                    end
                end

                s21 : begin
                    if (!trn_tdst_rdy_n) begin
                        rd_addr <= rd_addr +1;
                        trn_tsrc_rdy_n <= 1'b1;
                        compl_fsm <= s22;
                    end
                end

                s22 : begin
                    trn_tsrc_rdy_n <= 1'b1;
                    rd_addr <= rd_addr +1;
                    compl_fsm <= s20;
                end

                s23 : begin
                    commited_rd_addr <= look_ahead_commited_rd_addr;
                    rd_addr <= look_ahead_commited_rd_addr;
                    host_mem_addr <= look_ahead_host_mem_addr;
                    huge_page_qword_counter <= look_ahead_huge_page_qword_counter;
                    tlp_number <= look_ahead_tlp_number;
                    if (!trn_tdst_rdy_n) begin
                        trn_teof_n <= 1'b1;
                        trn_tsrc_rdy_n <= 1'b1;
                        compl_fsm <= s14;
                    end
                end

                s24 : begin
                    trn_trem_n <= 8'h0F;
                    trn_td[63:32] <= {
                                1'b0,   //reserved
                                `MEM_WR32_FMT_TYPE, //memory write request 32bit addressing
                                1'b0,   //reserved
                                3'b0,   //TC (traffic class)
                                4'b0,   //reserved
                                1'b0,   //TD (TLP digest present)
                                1'b0,   //EP (poisoned data)
                                2'b00,  //Relaxed ordering, No snoop in processor cache
                                2'b0,   //reserved
                                10'h02  //lenght equal 2 DW 
                            };
                    trn_td[31:0] <= {
                                cfg_completer_id,   //Requester ID
                                {4'b0, 4'b0 },   //Tag
                                4'hF,   //last DW byte enable
                                4'hF    //1st DW byte enable
                            };
                    trn_tsof_n <= 1'b0;
                    trn_tsrc_rdy_n <= 1'b0;
                    aux_qw_count <= huge_page_qword_counter;
                    next_qw_counter <= huge_page_qword_counter + 'hF;
                    compl_fsm <= s25;
                end

                s25 : begin
                    if (!trn_tdst_rdy_n) begin
                        trn_tsof_n <= 1'b1;
                        return_huge_page_to_host <= notify_huge_page_change;
                        trn_td <= {current_huge_page_addr[31:0], aux_qw_count[7:0], aux_qw_count[15:8], aux_qw_count[23:16], aux_qw_count[31:24]};
                        compl_fsm <= s26;
                    end
                end

                s26 : begin
                    huge_page_qword_counter <= {next_qw_counter[31:4], 4'b0};
                    if (!trn_tdst_rdy_n) begin
                        trn_td[63:32] <= {{7'b0, notify_huge_page_change}, 24'b0};
                        trn_teof_n <= 1'b0;
                        compl_fsm <= s27;
                    end
                end

                s27 : begin
                    if (!trn_tdst_rdy_n) begin
                        trn_teof_n <= 1'b1;
                        trn_tsrc_rdy_n <= 1'b1;
                        if (notify_huge_page_change) begin
                            compl_fsm <= s0;
                        end
                        else begin
                            compl_fsm <= s14;
                        end
                    end
                end

                default : begin 
                    compl_fsm <= s0;
                end

            endcase
        end     // not reset
    end  //always
   

endmodule // expansion_rom

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////