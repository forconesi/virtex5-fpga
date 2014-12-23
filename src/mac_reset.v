/*******************************************************************************
*
*  NetFPGA-10G http://www.netfpga.org
*
*  File:
*        mac_reset.v
*
*  Project:
*
*
*  Author:
*        Marco Forconesi
*
*  Description:
*        Synchronizes active high reset
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

module mac_reset (

    input                     clk156_25,
    input                     xaui_reset,
    output reg                reset156_25
    );

    // localparam
    localparam s0 = 8'b00000001;
    localparam s1 = 8'b00000010;
    localparam s2 = 8'b00000100;
    localparam s3 = 8'b00001000;
    localparam s4 = 8'b00010000;
    localparam s5 = 8'b00100000;
    localparam s6 = 8'b01000000;
    localparam s7 = 8'b10000000;

    //-------------------------------------------------------
    // Local reset
    //-------------------------------------------------------
    reg     [7:0]    reset_fsm = s0;

    ////////////////////////////////////////////////
    // reset
    ////////////////////////////////////////////////
    always @(posedge clk156_25) begin

        if (xaui_reset) begin  // reset
            reset_fsm <= s0;
        end
        
        else begin  // not reset

            (* parallel_case *)
            casex (reset_fsm)

                s0 : begin
                    reset156_25 <= 1'b1;
                    reset_fsm <= s1;
                end

                s1 : reset_fsm <= s2;
                s2 : reset_fsm <= s3;
                s3 : reset_fsm <= s4;
                s4 : reset_fsm <= s5;
                s5 : reset_fsm <= s6;

                s6 : begin
                    reset156_25 <= 1'b0;
                    reset_fsm <= s7;
                end

                s7 : begin
                    reset_fsm <= s7;
                end

            endcase
        end     // not reset
    end  //always

endmodule // mac_reset

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////