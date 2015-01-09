#ChipScope Core Inserter Project File Version 3.0
#Fri Jan 09 08:29:00 GMT 2015
Project.device.designInputFile=/local/scratch/mf537/NetFPGA-NewNIC/forconesi/virtex5-fpga/ise/top_cs.ngc
Project.device.designOutputFile=/local/scratch/mf537/NetFPGA-NewNIC/forconesi/virtex5-fpga/ise/top_cs.ngc
Project.device.deviceFamily=14
Project.device.enableRPMs=true
Project.device.outputDirectory=/local/scratch/mf537/NetFPGA-NewNIC/forconesi/virtex5-fpga/ise/_ngo
Project.device.useSRL16=true
Project.filter.dimension=19
Project.filter<0>=*irq_thr*
Project.filter<10>=*qw_cnt*
Project.filter<11>=*send_qws*
Project.filter<12>=*chng_lbuf*
Project.filter<13>=*trig_tlp*
Project.filter<14>=*diff*
Project.filter<15>=*committed_prod*
Project.filter<16>=*activity*
Project.filter<17>=*mac_activity*
Project.filter<18>=
Project.filter<1>=*irq_dis*
Project.filter<2>=*irq_en*
Project.filter<3>=*host_mem_addr*
Project.filter<4>=*sw_ptr*
Project.filter<5>=*hw_ptr*
Project.filter<6>=*send_irq*
Project.filter<7>=*committed_cons*
Project.filter<8>=*lbuf_dn*
Project.filter<9>=*lbuf_en*
Project.icon.boundaryScanChain=1
Project.icon.enableExtTriggerIn=false
Project.icon.enableExtTriggerOut=false
Project.icon.triggerInPinName=
Project.icon.triggerOutPinName=
Project.unit.dimension=2
Project.unit<0>.clockChannel=dma_mod/trn_clk_c
Project.unit<0>.clockEdge=Rising
Project.unit<0>.dataChannel<0>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<0>
Project.unit<0>.dataChannel<100>=dma_mod/trn_rd_c<30>
Project.unit<0>.dataChannel<101>=dma_mod/trn_rd_c<31>
Project.unit<0>.dataChannel<102>=dma_mod/trn_rd_c<32>
Project.unit<0>.dataChannel<103>=dma_mod/trn_rd_c<33>
Project.unit<0>.dataChannel<104>=dma_mod/trn_rd_c<34>
Project.unit<0>.dataChannel<105>=dma_mod/trn_rd_c<35>
Project.unit<0>.dataChannel<106>=dma_mod/trn_rd_c<36>
Project.unit<0>.dataChannel<107>=dma_mod/trn_rd_c<37>
Project.unit<0>.dataChannel<108>=dma_mod/trn_rd_c<38>
Project.unit<0>.dataChannel<109>=dma_mod/trn_rd_c<39>
Project.unit<0>.dataChannel<10>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<10>
Project.unit<0>.dataChannel<110>=dma_mod/trn_rd_c<40>
Project.unit<0>.dataChannel<111>=dma_mod/trn_rd_c<41>
Project.unit<0>.dataChannel<112>=dma_mod/trn_rd_c<42>
Project.unit<0>.dataChannel<113>=dma_mod/trn_rd_c<43>
Project.unit<0>.dataChannel<114>=dma_mod/trn_rd_c<44>
Project.unit<0>.dataChannel<115>=dma_mod/trn_rd_c<45>
Project.unit<0>.dataChannel<116>=dma_mod/trn_rd_c<46>
Project.unit<0>.dataChannel<117>=dma_mod/trn_rd_c<47>
Project.unit<0>.dataChannel<118>=dma_mod/trn_rd_c<48>
Project.unit<0>.dataChannel<119>=dma_mod/trn_rd_c<49>
Project.unit<0>.dataChannel<11>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<11>
Project.unit<0>.dataChannel<120>=dma_mod/trn_rd_c<50>
Project.unit<0>.dataChannel<121>=dma_mod/trn_rd_c<51>
Project.unit<0>.dataChannel<122>=dma_mod/trn_rd_c<52>
Project.unit<0>.dataChannel<123>=dma_mod/trn_rd_c<53>
Project.unit<0>.dataChannel<124>=dma_mod/trn_rd_c<54>
Project.unit<0>.dataChannel<125>=dma_mod/trn_rd_c<55>
Project.unit<0>.dataChannel<126>=dma_mod/trn_rd_c<56>
Project.unit<0>.dataChannel<127>=dma_mod/trn_rd_c<57>
Project.unit<0>.dataChannel<128>=dma_mod/trn_rd_c<58>
Project.unit<0>.dataChannel<129>=dma_mod/trn_rd_c<59>
Project.unit<0>.dataChannel<12>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<12>
Project.unit<0>.dataChannel<130>=dma_mod/trn_rd_c<60>
Project.unit<0>.dataChannel<131>=dma_mod/trn_rd_c<61>
Project.unit<0>.dataChannel<132>=dma_mod/trn_rd_c<62>
Project.unit<0>.dataChannel<133>=dma_mod/trn_rd_c<63>
Project.unit<0>.dataChannel<134>=dma_mod/trn_rsof_n_c
Project.unit<0>.dataChannel<135>=dma_mod/trn_rsrc_rdy_n_c
Project.unit<0>.dataChannel<136>=dma_mod/trn_rbar_hit_n_c<0>
Project.unit<0>.dataChannel<137>=dma_mod/trn_rbar_hit_n_c<2>
Project.unit<0>.dataChannel<138>=dma_mod/cfg_interrupt_n_c
Project.unit<0>.dataChannel<139>=dma_mod/cfg_interrupt_rdy_n_c
Project.unit<0>.dataChannel<13>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<13>
Project.unit<0>.dataChannel<140>=dma_mod/ep_rst_mod/rst250
Project.unit<0>.dataChannel<141>=dma_mod/chn0/rx_mod/buff2tlp_mod/trig_tlp_ack
Project.unit<0>.dataChannel<142>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/trig_tlp
Project.unit<0>.dataChannel<143>=dma_mod/chn0/rx_mod/buff2tlp_mod/chng_lbuf_ack
Project.unit<0>.dataChannel<144>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/chng_lbuf
Project.unit<0>.dataChannel<145>=dma_mod/chn0/rx_mod/buff2tlp_mod/send_qws_ack
Project.unit<0>.dataChannel<146>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/send_qws
Project.unit<0>.dataChannel<147>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/qw_cnt<0>
Project.unit<0>.dataChannel<148>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/qw_cnt<1>
Project.unit<0>.dataChannel<149>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/qw_cnt<2>
Project.unit<0>.dataChannel<14>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<14>
Project.unit<0>.dataChannel<150>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/qw_cnt<3>
Project.unit<0>.dataChannel<151>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/qw_cnt<4>
Project.unit<0>.dataChannel<152>=dma_mod/chn0/rx_mod/eth2tlp_ctrl_mod/qw_cnt<5>
Project.unit<0>.dataChannel<153>=dma_mod/chn0/rx_mod/lbuf_mgmt_mod/gv_lbuf_mod/lbuf_en
Project.unit<0>.dataChannel<154>=dma_mod/chn0/rx_mod/buff2tlp_mod/lbuf_dn
Project.unit<0>.dataChannel<155>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<0>
Project.unit<0>.dataChannel<156>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<1>
Project.unit<0>.dataChannel<157>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<2>
Project.unit<0>.dataChannel<158>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<3>
Project.unit<0>.dataChannel<159>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<4>
Project.unit<0>.dataChannel<15>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<15>
Project.unit<0>.dataChannel<160>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<5>
Project.unit<0>.dataChannel<161>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<6>
Project.unit<0>.dataChannel<162>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<7>
Project.unit<0>.dataChannel<163>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<8>
Project.unit<0>.dataChannel<164>=dma_mod/chn0/rx_mod/buff2tlp_mod/committed_cons<9>
Project.unit<0>.dataChannel<165>=dma_mod/chn0/rx_mod/irq_gen_mod/send_irq
Project.unit<0>.dataChannel<166>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<0>
Project.unit<0>.dataChannel<167>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<1>
Project.unit<0>.dataChannel<168>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<2>
Project.unit<0>.dataChannel<169>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<3>
Project.unit<0>.dataChannel<16>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<16>
Project.unit<0>.dataChannel<170>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<4>
Project.unit<0>.dataChannel<171>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<5>
Project.unit<0>.dataChannel<172>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<6>
Project.unit<0>.dataChannel<173>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<7>
Project.unit<0>.dataChannel<174>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<8>
Project.unit<0>.dataChannel<175>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<9>
Project.unit<0>.dataChannel<176>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<10>
Project.unit<0>.dataChannel<177>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<11>
Project.unit<0>.dataChannel<178>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<12>
Project.unit<0>.dataChannel<179>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<13>
Project.unit<0>.dataChannel<17>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<17>
Project.unit<0>.dataChannel<180>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<14>
Project.unit<0>.dataChannel<181>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<15>
Project.unit<0>.dataChannel<182>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<16>
Project.unit<0>.dataChannel<183>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<17>
Project.unit<0>.dataChannel<184>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<18>
Project.unit<0>.dataChannel<185>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<19>
Project.unit<0>.dataChannel<186>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<20>
Project.unit<0>.dataChannel<187>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<21>
Project.unit<0>.dataChannel<188>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<22>
Project.unit<0>.dataChannel<189>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<23>
Project.unit<0>.dataChannel<18>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<18>
Project.unit<0>.dataChannel<190>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<24>
Project.unit<0>.dataChannel<191>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<25>
Project.unit<0>.dataChannel<192>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<26>
Project.unit<0>.dataChannel<193>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<27>
Project.unit<0>.dataChannel<194>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<28>
Project.unit<0>.dataChannel<195>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<29>
Project.unit<0>.dataChannel<196>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<30>
Project.unit<0>.dataChannel<197>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<31>
Project.unit<0>.dataChannel<198>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<32>
Project.unit<0>.dataChannel<199>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<33>
Project.unit<0>.dataChannel<19>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<19>
Project.unit<0>.dataChannel<1>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<1>
Project.unit<0>.dataChannel<200>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<34>
Project.unit<0>.dataChannel<201>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<35>
Project.unit<0>.dataChannel<202>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<36>
Project.unit<0>.dataChannel<203>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<37>
Project.unit<0>.dataChannel<204>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<38>
Project.unit<0>.dataChannel<205>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<39>
Project.unit<0>.dataChannel<206>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<40>
Project.unit<0>.dataChannel<207>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<41>
Project.unit<0>.dataChannel<208>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<42>
Project.unit<0>.dataChannel<209>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<43>
Project.unit<0>.dataChannel<20>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<20>
Project.unit<0>.dataChannel<210>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<44>
Project.unit<0>.dataChannel<211>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<45>
Project.unit<0>.dataChannel<212>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<46>
Project.unit<0>.dataChannel<213>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<47>
Project.unit<0>.dataChannel<214>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<48>
Project.unit<0>.dataChannel<215>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<49>
Project.unit<0>.dataChannel<216>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<50>
Project.unit<0>.dataChannel<217>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<51>
Project.unit<0>.dataChannel<218>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<52>
Project.unit<0>.dataChannel<219>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<53>
Project.unit<0>.dataChannel<21>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<21>
Project.unit<0>.dataChannel<220>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<54>
Project.unit<0>.dataChannel<221>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<55>
Project.unit<0>.dataChannel<222>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<56>
Project.unit<0>.dataChannel<223>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<57>
Project.unit<0>.dataChannel<224>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<58>
Project.unit<0>.dataChannel<225>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<59>
Project.unit<0>.dataChannel<226>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<60>
Project.unit<0>.dataChannel<227>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<61>
Project.unit<0>.dataChannel<228>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<62>
Project.unit<0>.dataChannel<229>=dma_mod/chn0/rx_mod/sw_wrbck_mod/sw_ptr<63>
Project.unit<0>.dataChannel<22>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<22>
Project.unit<0>.dataChannel<230>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<0>
Project.unit<0>.dataChannel<231>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<1>
Project.unit<0>.dataChannel<232>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<2>
Project.unit<0>.dataChannel<233>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<3>
Project.unit<0>.dataChannel<234>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<4>
Project.unit<0>.dataChannel<235>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<5>
Project.unit<0>.dataChannel<236>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<6>
Project.unit<0>.dataChannel<237>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<7>
Project.unit<0>.dataChannel<238>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<8>
Project.unit<0>.dataChannel<239>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<9>
Project.unit<0>.dataChannel<23>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<23>
Project.unit<0>.dataChannel<240>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<10>
Project.unit<0>.dataChannel<241>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<11>
Project.unit<0>.dataChannel<242>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<12>
Project.unit<0>.dataChannel<243>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<13>
Project.unit<0>.dataChannel<244>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<14>
Project.unit<0>.dataChannel<245>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<15>
Project.unit<0>.dataChannel<246>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<16>
Project.unit<0>.dataChannel<247>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<17>
Project.unit<0>.dataChannel<248>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<18>
Project.unit<0>.dataChannel<249>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<19>
Project.unit<0>.dataChannel<24>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<24>
Project.unit<0>.dataChannel<250>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<20>
Project.unit<0>.dataChannel<251>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<21>
Project.unit<0>.dataChannel<252>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<22>
Project.unit<0>.dataChannel<253>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<23>
Project.unit<0>.dataChannel<254>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<24>
Project.unit<0>.dataChannel<255>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<25>
Project.unit<0>.dataChannel<256>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<26>
Project.unit<0>.dataChannel<257>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<27>
Project.unit<0>.dataChannel<258>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<28>
Project.unit<0>.dataChannel<259>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<29>
Project.unit<0>.dataChannel<25>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<25>
Project.unit<0>.dataChannel<260>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<30>
Project.unit<0>.dataChannel<261>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<31>
Project.unit<0>.dataChannel<262>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<32>
Project.unit<0>.dataChannel<263>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<33>
Project.unit<0>.dataChannel<264>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<34>
Project.unit<0>.dataChannel<265>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<35>
Project.unit<0>.dataChannel<266>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<36>
Project.unit<0>.dataChannel<267>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<37>
Project.unit<0>.dataChannel<268>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<38>
Project.unit<0>.dataChannel<269>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<39>
Project.unit<0>.dataChannel<26>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<26>
Project.unit<0>.dataChannel<270>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<40>
Project.unit<0>.dataChannel<271>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<41>
Project.unit<0>.dataChannel<272>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<42>
Project.unit<0>.dataChannel<273>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<43>
Project.unit<0>.dataChannel<274>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<44>
Project.unit<0>.dataChannel<275>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<45>
Project.unit<0>.dataChannel<276>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<46>
Project.unit<0>.dataChannel<277>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<47>
Project.unit<0>.dataChannel<278>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<48>
Project.unit<0>.dataChannel<279>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<49>
Project.unit<0>.dataChannel<27>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<27>
Project.unit<0>.dataChannel<280>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<50>
Project.unit<0>.dataChannel<281>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<51>
Project.unit<0>.dataChannel<282>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<52>
Project.unit<0>.dataChannel<283>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<53>
Project.unit<0>.dataChannel<284>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<54>
Project.unit<0>.dataChannel<285>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<55>
Project.unit<0>.dataChannel<286>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<56>
Project.unit<0>.dataChannel<287>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<57>
Project.unit<0>.dataChannel<288>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<58>
Project.unit<0>.dataChannel<289>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<59>
Project.unit<0>.dataChannel<28>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<28>
Project.unit<0>.dataChannel<290>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<60>
Project.unit<0>.dataChannel<291>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<61>
Project.unit<0>.dataChannel<292>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<62>
Project.unit<0>.dataChannel<293>=dma_mod/chn0/rx_mod/buff2tlp_mod/host_mem_addr<63>
Project.unit<0>.dataChannel<294>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_en
Project.unit<0>.dataChannel<295>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_dis
Project.unit<0>.dataChannel<296>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<0>
Project.unit<0>.dataChannel<297>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<1>
Project.unit<0>.dataChannel<298>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<2>
Project.unit<0>.dataChannel<299>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<3>
Project.unit<0>.dataChannel<29>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<29>
Project.unit<0>.dataChannel<2>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<2>
Project.unit<0>.dataChannel<300>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<4>
Project.unit<0>.dataChannel<301>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<5>
Project.unit<0>.dataChannel<302>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<6>
Project.unit<0>.dataChannel<303>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<7>
Project.unit<0>.dataChannel<304>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<8>
Project.unit<0>.dataChannel<305>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<9>
Project.unit<0>.dataChannel<306>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<10>
Project.unit<0>.dataChannel<307>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<11>
Project.unit<0>.dataChannel<308>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<12>
Project.unit<0>.dataChannel<309>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<13>
Project.unit<0>.dataChannel<30>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<30>
Project.unit<0>.dataChannel<310>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<14>
Project.unit<0>.dataChannel<311>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<15>
Project.unit<0>.dataChannel<312>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<16>
Project.unit<0>.dataChannel<313>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<17>
Project.unit<0>.dataChannel<314>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<18>
Project.unit<0>.dataChannel<315>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<19>
Project.unit<0>.dataChannel<316>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<20>
Project.unit<0>.dataChannel<317>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<21>
Project.unit<0>.dataChannel<318>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<22>
Project.unit<0>.dataChannel<319>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<23>
Project.unit<0>.dataChannel<31>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<31>
Project.unit<0>.dataChannel<320>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<24>
Project.unit<0>.dataChannel<321>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<25>
Project.unit<0>.dataChannel<322>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<26>
Project.unit<0>.dataChannel<323>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<27>
Project.unit<0>.dataChannel<324>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<28>
Project.unit<0>.dataChannel<325>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr<29>
Project.unit<0>.dataChannel<326>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<2>
Project.unit<0>.dataChannel<327>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<3>
Project.unit<0>.dataChannel<328>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<4>
Project.unit<0>.dataChannel<329>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<5>
Project.unit<0>.dataChannel<32>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<32>
Project.unit<0>.dataChannel<330>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<6>
Project.unit<0>.dataChannel<331>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<7>
Project.unit<0>.dataChannel<332>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<8>
Project.unit<0>.dataChannel<333>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<9>
Project.unit<0>.dataChannel<334>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<10>
Project.unit<0>.dataChannel<335>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<11>
Project.unit<0>.dataChannel<336>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<12>
Project.unit<0>.dataChannel<337>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<13>
Project.unit<0>.dataChannel<338>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<14>
Project.unit<0>.dataChannel<339>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<15>
Project.unit<0>.dataChannel<33>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<33>
Project.unit<0>.dataChannel<340>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<16>
Project.unit<0>.dataChannel<341>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<17>
Project.unit<0>.dataChannel<342>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<18>
Project.unit<0>.dataChannel<343>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<19>
Project.unit<0>.dataChannel<344>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<20>
Project.unit<0>.dataChannel<345>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<21>
Project.unit<0>.dataChannel<346>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<22>
Project.unit<0>.dataChannel<347>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<23>
Project.unit<0>.dataChannel<348>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<24>
Project.unit<0>.dataChannel<349>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<25>
Project.unit<0>.dataChannel<34>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<34>
Project.unit<0>.dataChannel<350>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<26>
Project.unit<0>.dataChannel<351>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<27>
Project.unit<0>.dataChannel<352>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<28>
Project.unit<0>.dataChannel<353>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<29>
Project.unit<0>.dataChannel<354>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<30>
Project.unit<0>.dataChannel<355>=dma_mod/chn0/irq_mod/hst_ctrl_mod/irq_thr_i<31>
Project.unit<0>.dataChannel<356>=
Project.unit<0>.dataChannel<357>=
Project.unit<0>.dataChannel<358>=
Project.unit<0>.dataChannel<359>=
Project.unit<0>.dataChannel<35>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<35>
Project.unit<0>.dataChannel<360>=
Project.unit<0>.dataChannel<361>=
Project.unit<0>.dataChannel<362>=
Project.unit<0>.dataChannel<363>=
Project.unit<0>.dataChannel<364>=
Project.unit<0>.dataChannel<365>=
Project.unit<0>.dataChannel<36>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<36>
Project.unit<0>.dataChannel<37>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<37>
Project.unit<0>.dataChannel<38>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<38>
Project.unit<0>.dataChannel<39>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<39>
Project.unit<0>.dataChannel<3>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<3>
Project.unit<0>.dataChannel<40>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<40>
Project.unit<0>.dataChannel<41>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<41>
Project.unit<0>.dataChannel<42>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<42>
Project.unit<0>.dataChannel<43>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<43>
Project.unit<0>.dataChannel<44>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<44>
Project.unit<0>.dataChannel<45>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<45>
Project.unit<0>.dataChannel<46>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<46>
Project.unit<0>.dataChannel<47>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<47>
Project.unit<0>.dataChannel<48>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<48>
Project.unit<0>.dataChannel<49>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<49>
Project.unit<0>.dataChannel<4>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<4>
Project.unit<0>.dataChannel<50>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<50>
Project.unit<0>.dataChannel<51>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<51>
Project.unit<0>.dataChannel<52>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<52>
Project.unit<0>.dataChannel<53>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<53>
Project.unit<0>.dataChannel<54>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<54>
Project.unit<0>.dataChannel<55>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<55>
Project.unit<0>.dataChannel<56>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<56>
Project.unit<0>.dataChannel<57>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<57>
Project.unit<0>.dataChannel<58>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<58>
Project.unit<0>.dataChannel<59>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<59>
Project.unit<0>.dataChannel<5>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<5>
Project.unit<0>.dataChannel<60>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<60>
Project.unit<0>.dataChannel<61>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<61>
Project.unit<0>.dataChannel<62>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<62>
Project.unit<0>.dataChannel<63>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<63>
Project.unit<0>.dataChannel<64>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_trem_n<0>
Project.unit<0>.dataChannel<65>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_tsof_n
Project.unit<0>.dataChannel<66>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_teof_n
Project.unit<0>.dataChannel<67>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_tsrc_rdy_n
Project.unit<0>.dataChannel<68>=dma_mod/trn_tdst_rdy_n_c
Project.unit<0>.dataChannel<69>=dma_mod/trn_tbuf_av_c<1>
Project.unit<0>.dataChannel<6>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<6>
Project.unit<0>.dataChannel<70>=dma_mod/trn_rd_c<0>
Project.unit<0>.dataChannel<71>=dma_mod/trn_rd_c<1>
Project.unit<0>.dataChannel<72>=dma_mod/trn_rd_c<2>
Project.unit<0>.dataChannel<73>=dma_mod/trn_rd_c<3>
Project.unit<0>.dataChannel<74>=dma_mod/trn_rd_c<4>
Project.unit<0>.dataChannel<75>=dma_mod/trn_rd_c<5>
Project.unit<0>.dataChannel<76>=dma_mod/trn_rd_c<6>
Project.unit<0>.dataChannel<77>=dma_mod/trn_rd_c<7>
Project.unit<0>.dataChannel<78>=dma_mod/trn_rd_c<8>
Project.unit<0>.dataChannel<79>=dma_mod/trn_rd_c<9>
Project.unit<0>.dataChannel<7>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<7>
Project.unit<0>.dataChannel<80>=dma_mod/trn_rd_c<10>
Project.unit<0>.dataChannel<81>=dma_mod/trn_rd_c<11>
Project.unit<0>.dataChannel<82>=dma_mod/trn_rd_c<12>
Project.unit<0>.dataChannel<83>=dma_mod/trn_rd_c<13>
Project.unit<0>.dataChannel<84>=dma_mod/trn_rd_c<14>
Project.unit<0>.dataChannel<85>=dma_mod/trn_rd_c<15>
Project.unit<0>.dataChannel<86>=dma_mod/trn_rd_c<16>
Project.unit<0>.dataChannel<87>=dma_mod/trn_rd_c<17>
Project.unit<0>.dataChannel<88>=dma_mod/trn_rd_c<18>
Project.unit<0>.dataChannel<89>=dma_mod/trn_rd_c<19>
Project.unit<0>.dataChannel<8>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<8>
Project.unit<0>.dataChannel<90>=dma_mod/trn_rd_c<20>
Project.unit<0>.dataChannel<91>=dma_mod/trn_rd_c<21>
Project.unit<0>.dataChannel<92>=dma_mod/trn_rd_c<22>
Project.unit<0>.dataChannel<93>=dma_mod/trn_rd_c<23>
Project.unit<0>.dataChannel<94>=dma_mod/trn_rd_c<24>
Project.unit<0>.dataChannel<95>=dma_mod/trn_rd_c<25>
Project.unit<0>.dataChannel<96>=dma_mod/trn_rd_c<26>
Project.unit<0>.dataChannel<97>=dma_mod/trn_rd_c<27>
Project.unit<0>.dataChannel<98>=dma_mod/trn_rd_c<28>
Project.unit<0>.dataChannel<99>=dma_mod/trn_rd_c<29>
Project.unit<0>.dataChannel<9>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_td<9>
Project.unit<0>.dataDepth=8192
Project.unit<0>.dataEqualsTrigger=false
Project.unit<0>.dataPortWidth=356
Project.unit<0>.enableGaps=false
Project.unit<0>.enableStorageQualification=true
Project.unit<0>.enableTimestamps=false
Project.unit<0>.timestampDepth=0
Project.unit<0>.timestampWidth=0
Project.unit<0>.triggerChannel<0><0>=dma_mod/chn0/rx_mod/buff2tlp_mod/trn_tsof_n
Project.unit<0>.triggerChannel<0><1>=dma_mod/trn_rsof_n_c
Project.unit<0>.triggerChannel<0><2>=dma_mod/cfg_interrupt_n_c
Project.unit<0>.triggerConditionCountWidth=0
Project.unit<0>.triggerMatchCount<0>=1
Project.unit<0>.triggerMatchCountWidth<0><0>=0
Project.unit<0>.triggerMatchType<0><0>=1
Project.unit<0>.triggerPortCount=1
Project.unit<0>.triggerPortIsData<0>=true
Project.unit<0>.triggerPortWidth<0>=3
Project.unit<0>.triggerSequencerLevels=16
Project.unit<0>.triggerSequencerType=1
Project.unit<0>.type=ilapro
Project.unit<1>.clockChannel=mac_clk
Project.unit<1>.clockEdge=Rising
Project.unit<1>.dataChannel<0>=xge_intf_d/xaui_mod/reset156
Project.unit<1>.dataChannel<100>=
Project.unit<1>.dataChannel<101>=
Project.unit<1>.dataChannel<102>=
Project.unit<1>.dataChannel<103>=
Project.unit<1>.dataChannel<104>=
Project.unit<1>.dataChannel<105>=
Project.unit<1>.dataChannel<106>=
Project.unit<1>.dataChannel<107>=
Project.unit<1>.dataChannel<108>=
Project.unit<1>.dataChannel<109>=
Project.unit<1>.dataChannel<10>=mac_rx_data<9>
Project.unit<1>.dataChannel<110>=
Project.unit<1>.dataChannel<111>=
Project.unit<1>.dataChannel<112>=
Project.unit<1>.dataChannel<113>=
Project.unit<1>.dataChannel<114>=
Project.unit<1>.dataChannel<115>=
Project.unit<1>.dataChannel<116>=
Project.unit<1>.dataChannel<117>=
Project.unit<1>.dataChannel<118>=
Project.unit<1>.dataChannel<119>=
Project.unit<1>.dataChannel<11>=mac_rx_data<10>
Project.unit<1>.dataChannel<120>=
Project.unit<1>.dataChannel<121>=
Project.unit<1>.dataChannel<122>=
Project.unit<1>.dataChannel<123>=
Project.unit<1>.dataChannel<124>=
Project.unit<1>.dataChannel<125>=
Project.unit<1>.dataChannel<126>=
Project.unit<1>.dataChannel<127>=
Project.unit<1>.dataChannel<128>=
Project.unit<1>.dataChannel<129>=
Project.unit<1>.dataChannel<12>=mac_rx_data<11>
Project.unit<1>.dataChannel<130>=
Project.unit<1>.dataChannel<131>=
Project.unit<1>.dataChannel<132>=
Project.unit<1>.dataChannel<133>=
Project.unit<1>.dataChannel<134>=
Project.unit<1>.dataChannel<135>=
Project.unit<1>.dataChannel<136>=
Project.unit<1>.dataChannel<137>=
Project.unit<1>.dataChannel<138>=
Project.unit<1>.dataChannel<139>=
Project.unit<1>.dataChannel<13>=mac_rx_data<12>
Project.unit<1>.dataChannel<140>=
Project.unit<1>.dataChannel<141>=
Project.unit<1>.dataChannel<142>=
Project.unit<1>.dataChannel<143>=
Project.unit<1>.dataChannel<144>=
Project.unit<1>.dataChannel<145>=
Project.unit<1>.dataChannel<146>=
Project.unit<1>.dataChannel<147>=
Project.unit<1>.dataChannel<148>=
Project.unit<1>.dataChannel<149>=
Project.unit<1>.dataChannel<14>=mac_rx_data<13>
Project.unit<1>.dataChannel<150>=
Project.unit<1>.dataChannel<151>=
Project.unit<1>.dataChannel<15>=mac_rx_data<14>
Project.unit<1>.dataChannel<16>=mac_rx_data<15>
Project.unit<1>.dataChannel<17>=mac_rx_data<16>
Project.unit<1>.dataChannel<18>=mac_rx_data<17>
Project.unit<1>.dataChannel<19>=mac_rx_data<18>
Project.unit<1>.dataChannel<1>=mac_rx_data<0>
Project.unit<1>.dataChannel<20>=mac_rx_data<19>
Project.unit<1>.dataChannel<21>=mac_rx_data<20>
Project.unit<1>.dataChannel<22>=mac_rx_data<21>
Project.unit<1>.dataChannel<23>=mac_rx_data<22>
Project.unit<1>.dataChannel<24>=mac_rx_data<23>
Project.unit<1>.dataChannel<25>=mac_rx_data<24>
Project.unit<1>.dataChannel<26>=mac_rx_data<25>
Project.unit<1>.dataChannel<27>=mac_rx_data<26>
Project.unit<1>.dataChannel<28>=mac_rx_data<27>
Project.unit<1>.dataChannel<29>=mac_rx_data<28>
Project.unit<1>.dataChannel<2>=mac_rx_data<1>
Project.unit<1>.dataChannel<30>=mac_rx_data<29>
Project.unit<1>.dataChannel<31>=mac_rx_data<30>
Project.unit<1>.dataChannel<32>=mac_rx_data<31>
Project.unit<1>.dataChannel<33>=mac_rx_data<32>
Project.unit<1>.dataChannel<34>=mac_rx_data<33>
Project.unit<1>.dataChannel<35>=mac_rx_data<34>
Project.unit<1>.dataChannel<36>=mac_rx_data<35>
Project.unit<1>.dataChannel<37>=mac_rx_data<36>
Project.unit<1>.dataChannel<38>=mac_rx_data<37>
Project.unit<1>.dataChannel<39>=mac_rx_data<38>
Project.unit<1>.dataChannel<3>=mac_rx_data<2>
Project.unit<1>.dataChannel<40>=mac_rx_data<39>
Project.unit<1>.dataChannel<41>=mac_rx_data<40>
Project.unit<1>.dataChannel<42>=mac_rx_data<41>
Project.unit<1>.dataChannel<43>=mac_rx_data<42>
Project.unit<1>.dataChannel<44>=mac_rx_data<43>
Project.unit<1>.dataChannel<45>=mac_rx_data<44>
Project.unit<1>.dataChannel<46>=mac_rx_data<45>
Project.unit<1>.dataChannel<47>=mac_rx_data<46>
Project.unit<1>.dataChannel<48>=mac_rx_data<47>
Project.unit<1>.dataChannel<49>=mac_rx_data<48>
Project.unit<1>.dataChannel<4>=mac_rx_data<3>
Project.unit<1>.dataChannel<50>=mac_rx_data<49>
Project.unit<1>.dataChannel<51>=mac_rx_data<50>
Project.unit<1>.dataChannel<52>=mac_rx_data<51>
Project.unit<1>.dataChannel<53>=mac_rx_data<52>
Project.unit<1>.dataChannel<54>=mac_rx_data<53>
Project.unit<1>.dataChannel<55>=mac_rx_data<54>
Project.unit<1>.dataChannel<56>=mac_rx_data<55>
Project.unit<1>.dataChannel<57>=mac_rx_data<56>
Project.unit<1>.dataChannel<58>=mac_rx_data<57>
Project.unit<1>.dataChannel<59>=mac_rx_data<58>
Project.unit<1>.dataChannel<5>=mac_rx_data<4>
Project.unit<1>.dataChannel<60>=mac_rx_data<59>
Project.unit<1>.dataChannel<61>=mac_rx_data<60>
Project.unit<1>.dataChannel<62>=mac_rx_data<61>
Project.unit<1>.dataChannel<63>=mac_rx_data<62>
Project.unit<1>.dataChannel<64>=mac_rx_data<63>
Project.unit<1>.dataChannel<65>=mac_rx_data_valid<0>
Project.unit<1>.dataChannel<66>=mac_rx_data_valid<1>
Project.unit<1>.dataChannel<67>=mac_rx_data_valid<2>
Project.unit<1>.dataChannel<68>=mac_rx_data_valid<3>
Project.unit<1>.dataChannel<69>=mac_rx_data_valid<4>
Project.unit<1>.dataChannel<6>=mac_rx_data<5>
Project.unit<1>.dataChannel<70>=mac_rx_data_valid<5>
Project.unit<1>.dataChannel<71>=mac_rx_data_valid<6>
Project.unit<1>.dataChannel<72>=mac_rx_data_valid<7>
Project.unit<1>.dataChannel<73>=mac_rx_good_frame
Project.unit<1>.dataChannel<74>=dma_mod/chn0/rx_mod/mac2buff_mod/activity
Project.unit<1>.dataChannel<75>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<0>
Project.unit<1>.dataChannel<76>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<1>
Project.unit<1>.dataChannel<77>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<2>
Project.unit<1>.dataChannel<78>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<3>
Project.unit<1>.dataChannel<79>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<4>
Project.unit<1>.dataChannel<7>=mac_rx_data<6>
Project.unit<1>.dataChannel<80>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<5>
Project.unit<1>.dataChannel<81>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<6>
Project.unit<1>.dataChannel<82>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<7>
Project.unit<1>.dataChannel<83>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<8>
Project.unit<1>.dataChannel<84>=dma_mod/chn0/rx_mod/mac2buff_mod/committed_prod<9>
Project.unit<1>.dataChannel<85>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<0>
Project.unit<1>.dataChannel<86>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<1>
Project.unit<1>.dataChannel<87>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<2>
Project.unit<1>.dataChannel<88>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<3>
Project.unit<1>.dataChannel<89>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<4>
Project.unit<1>.dataChannel<8>=mac_rx_data<7>
Project.unit<1>.dataChannel<90>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<5>
Project.unit<1>.dataChannel<91>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<6>
Project.unit<1>.dataChannel<92>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<7>
Project.unit<1>.dataChannel<93>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<8>
Project.unit<1>.dataChannel<94>=dma_mod/chn0/rx_mod/mac2buff_mod/diff<9>
Project.unit<1>.dataChannel<95>=
Project.unit<1>.dataChannel<96>=
Project.unit<1>.dataChannel<97>=
Project.unit<1>.dataChannel<98>=
Project.unit<1>.dataChannel<99>=
Project.unit<1>.dataChannel<9>=mac_rx_data<8>
Project.unit<1>.dataDepth=4096
Project.unit<1>.dataEqualsTrigger=false
Project.unit<1>.dataPortWidth=95
Project.unit<1>.enableGaps=false
Project.unit<1>.enableStorageQualification=true
Project.unit<1>.enableTimestamps=false
Project.unit<1>.timestampDepth=0
Project.unit<1>.timestampWidth=0
Project.unit<1>.triggerChannel<0><0>=mac_rx_good_frame
Project.unit<1>.triggerChannel<0><10>=
Project.unit<1>.triggerChannel<0><11>=
Project.unit<1>.triggerChannel<0><12>=
Project.unit<1>.triggerChannel<0><13>=
Project.unit<1>.triggerChannel<0><14>=
Project.unit<1>.triggerChannel<0><15>=
Project.unit<1>.triggerChannel<0><1>=
Project.unit<1>.triggerChannel<0><2>=
Project.unit<1>.triggerChannel<0><3>=
Project.unit<1>.triggerChannel<0><4>=
Project.unit<1>.triggerChannel<0><5>=
Project.unit<1>.triggerChannel<0><6>=
Project.unit<1>.triggerChannel<0><7>=
Project.unit<1>.triggerChannel<0><8>=
Project.unit<1>.triggerChannel<0><9>=
Project.unit<1>.triggerConditionCountWidth=0
Project.unit<1>.triggerMatchCount<0>=1
Project.unit<1>.triggerMatchCountWidth<0><0>=0
Project.unit<1>.triggerMatchType<0><0>=1
Project.unit<1>.triggerPortCount=1
Project.unit<1>.triggerPortIsData<0>=true
Project.unit<1>.triggerPortWidth<0>=1
Project.unit<1>.triggerSequencerLevels=16
Project.unit<1>.triggerSequencerType=1
Project.unit<1>.type=ilapro
