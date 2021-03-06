/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        interrupt_ctrl.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        Global interrupt control.
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

module interrupt_ctrl (

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

    input       [3:0]       trn_tbuf_av,
    output reg              cfg_interrupt_n,
    input                   cfg_interrupt_rdy_n,

    // Arbitrations handshake  //
    input                   my_turn,
    output reg              driving_interface,
    output reg              req_ep,

    input                   send_interrupt
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
    // Local TLP reception
    //-------------------------------------------------------
    reg     [7:0]   tlp_rx_fsm;
    reg             interrupts_reenabled;
    reg             interrupts_disable;
    reg             period_received;
    reg     [31:0]  aux_dw;
    

    //-------------------------------------------------------
    // Local send_interrupt_fsm
    //-------------------------------------------------------
    reg     [7:0]   send_interrupt_fsm;
    reg     [29:0]  counter;

    //-------------------------------------------------------
    // Local interrupt_period_fsm
    //-------------------------------------------------------
    reg     [7:0]   interrupt_period_fsm;
    reg     [31:0]  aux_period;
    reg     [29:0]  interrupt_period;

    ////////////////////////////////////////////////
    // send_interrupt_fsm
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        if (reset) begin  // reset
            req_ep <= 1'b0;
            driving_interface <= 1'b0;
            cfg_interrupt_n <= 1'b1;
            send_interrupt_fsm <= s0;
        end
        
        else begin  // not reset

            case (send_interrupt_fsm)

                s0 : begin
                    if (send_interrupt && !interrupts_disable) begin
                        req_ep <= 1'b1;
                        send_interrupt_fsm <= s1;
                    end
                end

                s1 : begin
                    if (my_turn) begin
                        req_ep <= 1'b0;
                        driving_interface <= 1'b1;
                        send_interrupt_fsm <= s2;
                    end
                end

                s2 : begin
                    if (trn_tbuf_av[1]) begin
                        cfg_interrupt_n <= 1'b0;
                        send_interrupt_fsm <= s3;
                    end
                    else begin
                        driving_interface <= 1'b0;
                        send_interrupt_fsm <= s5;
                    end
                end

                s3 : begin
                    if (!cfg_interrupt_rdy_n) begin
                        cfg_interrupt_n <= 1'b1;
                        driving_interface <= 1'b0;
                        send_interrupt_fsm <= s4;
                    end
                end

                s4 : begin
                    counter <= 'b0;
                    if (interrupts_reenabled) begin
                        send_interrupt_fsm <= s6;
                    end
                end

                s5 : begin
                    if (trn_tbuf_av[1]) begin
                        req_ep <= 1'b1;
                        send_interrupt_fsm <= s1;
                    end
                end

                s6 : begin
                    counter <= counter + 1;
                    if (interrupt_period == counter) begin
                        send_interrupt_fsm <= s0;
                    end
                end

                default : begin
                    send_interrupt_fsm <= s0;
                end

            endcase
        end     // not reset
    end  //always

    ////////////////////////////////////////////////
    // interrupt_period_fsm
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        if (reset) begin  // reset
            interrupt_period_fsm <= s0;
        end
        
        else begin  // not reset

            case (interrupt_period_fsm)

                s0 : begin
                    interrupt_period <= 'b0;
                    interrupt_period_fsm <= s1;
                end

                s1 : begin
                    aux_period[7:0]   <= aux_dw[31:24];
                    aux_period[15:8]  <= aux_dw[23:16];
                    aux_period[23:16] <= aux_dw[15:8];
                    aux_period[31:24] <= aux_dw[7:0];
                    if (period_received) begin
                        interrupt_period_fsm <= s2;
                    end
                end

                s2 : begin
                    interrupt_period <= aux_period[31:2];
                    interrupt_period_fsm <= s1;
                end

                default : begin
                    interrupt_period_fsm <= s0;
                end

            endcase
        end     // not reset
    end  //always

    ////////////////////////////////////////////////
    // interrupts_enabled & TLP reception
    ////////////////////////////////////////////////
    always @(posedge trn_clk) begin

        if (reset) begin  // reset
            interrupts_reenabled <= 1'b0;
            interrupts_disable <= 1'b0;
            period_received <= 1'b0;
            tlp_rx_fsm <= s0;
        end
        
        else begin  // not reset

            interrupts_reenabled <= 1'b0;
            period_received <= 1'b0;

            case (tlp_rx_fsm)

                s0 : begin
                    if ( (!trn_rsrc_rdy_n) && (!trn_rsof_n) && (!trn_rdst_rdy_n) && (!trn_rbar_hit_n[2])) begin
                        if (trn_rd[62:56] == `MEM_WR32_FMT_TYPE) begin
                            tlp_rx_fsm <= s1;
                        end
                        else if (trn_rd[62:56] == `MEM_WR64_FMT_TYPE) begin
                            tlp_rx_fsm <= s2;
                        end
                    end
                end

                s1 : begin
                    aux_dw <= trn_rd[31:0];
                    if ( (!trn_rsrc_rdy_n) && (!trn_rdst_rdy_n)) begin
                        case (trn_rd[39:34])

                            6'b001000 : begin     // host going to sleep
                                interrupts_reenabled <= 1'b1;
                                interrupts_disable <= 1'b0;
                                tlp_rx_fsm <= s0;
                            end

                            6'b001001 : begin     // interrupts disable
                                interrupts_disable <= 1'b1;
                                tlp_rx_fsm <= s0;
                            end

                            6'b001010 : begin     // interrupts period
                                period_received <= 1'b1;
                                tlp_rx_fsm <= s0;
                            end

                            default : begin //other addresses
                                tlp_rx_fsm <= s0;
                            end

                        endcase
                    end
                end

                s2 : begin
                    if ( (!trn_rsrc_rdy_n) && (!trn_rdst_rdy_n)) begin
                        case (trn_rd[7:2])

                            6'b001000 : begin     // host going to sleep
                                interrupts_reenabled <= 1'b1;
                                interrupts_disable <= 1'b0;
                                tlp_rx_fsm <= s0;
                            end

                            6'b001001 : begin     // interrupts disable
                                interrupts_disable <= 1'b1;
                                tlp_rx_fsm <= s0;
                            end

                            6'b001010 : begin     // interrupts period
                                tlp_rx_fsm <= s3;
                            end

                            default : begin //other addresses
                                tlp_rx_fsm <= s0;
                            end

                        endcase
                    end
                end

                s3 : begin
                    aux_dw <= trn_rd[63:32];
                    if ( (!trn_rsrc_rdy_n) && (!trn_rdst_rdy_n)) begin
                        period_received <= 1'b1;
                        tlp_rx_fsm <= s0;
                    end
                end

                default : begin //other TLPs
                    tlp_rx_fsm <= s0;
                end

            endcase
        end     // not reset
    end  //always
   

endmodule // interrupt_ctrl

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////