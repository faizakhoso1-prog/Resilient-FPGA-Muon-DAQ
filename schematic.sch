# File saved with Nlview 6.8.5  2018-01-30 bk=1.4354 VDI=40 GEI=35 GUI=JA:1.6 non-TLS-threadsafe
# 
# non-default properties - (restore without -noprops)
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #ff6666
property objecthighlight4 #0000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlapcolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 8
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 4
property timelimit 1
#
module new tmr_voter work:tmr_voter:NOFILE -nosplit
load symbol RTL_NEQ work RTL(!=) pin O output.right pinBus I0 input.left [1:0] pinBus I1 input.left [1:0] fillcolor 1
load symbol RTL_MUX work MUX pin I0 input.left pin I1 input.left pin O output.right pin S input.bot fillcolor 1
load symbol RTL_REG_SYNC__BREG_2 work GEN pin C input.clk.left pin D input.left pin Q output.right pin RST input.top pin SET input.bot fillcolor 1
load symbol RTL_MUX2 work MUX pin S input.bot pinBus I0 input.left [1:0] pinBus I1 input.left [1:0] pinBus O output.right [1:0] fillcolor 1
load symbol RTL_OR2 work OR pin I0 input pin I1 input pin O output fillcolor 1
load symbol RTL_AND2 work AND pin I0 input pin I1 input pin O output fillcolor 1
load symbol RTL_REG_SYNC__BREG_1 work[1:0]swws GEN pin C input.clk.left pinBus D input.left [1:0] pinBus Q output.right [1:0] pin RST input.top fillcolor 1 sandwich 3 prop @bundle 2
load symbol RTL_REG__BREG_3 work[1:0]sww GEN pin C input.clk.left pinBus D input.left [1:0] pinBus Q output.right [1:0] fillcolor 1 sandwich 3 prop @bundle 2
load port fault_detected output -pg 1 -y 200
load port rst input -pg 1 -y 570
load port clk input -pg 1 -y 450
load portBus voted_state output [1:0] -attr @name voted_state[1:0] -pg 1 -y 380
load portBus faulty_core output [1:0] -attr @name faulty_core[1:0] -pg 1 -y 500
load portBus core_A_state input [1:0] -attr @name core_A_state[1:0] -pg 1 -y 140
load portBus core_B_state input [1:0] -attr @name core_B_state[1:0] -pg 1 -y 160
load portBus core_C_state input [1:0] -attr @name core_C_state[1:0] -pg 1 -y 120
load inst fault_detected1_i RTL_NEQ work -attr @cell(#000000) RTL_NEQ -pinBusAttr I0 @name I0[1:0] -pinBusAttr I1 @name I1[1:0] -pg 1 -lvl 5 -y 380
load inst faulty_core_i__0 RTL_MUX2 work -attr @cell(#000000) RTL_MUX -pinBusAttr I0 @name I0[1:0] -pinBusAttr I0 @attr V=B\"01\",\ S=1'b1 -pinBusAttr I1 @name I1[1:0] -pinBusAttr I1 @attr S=default -pinBusAttr O @name O[1:0] -pg 1 -lvl 6 -y 340
load inst faulty_core_i__1 RTL_MUX2 work -attr @cell(#000000) RTL_MUX -pinBusAttr I0 @name I0[1:0] -pinBusAttr I0 @attr S=1'b1 -pinBusAttr I1 @name I1[1:0] -pinBusAttr I1 @attr S=default -pinBusAttr O @name O[1:0] -pg 1 -lvl 7 -y 510
load inst voted_state0_i__0 RTL_OR2 work -attr @cell(#000000) RTL_OR -pg 1 -lvl 3 -y 370
load inst voted_state2_i RTL_AND2 work -attr @cell(#000000) RTL_AND -pg 1 -lvl 1 -y 40
load inst fault_detected_i RTL_MUX work -attr @cell(#000000) RTL_MUX -pinAttr I0 @attr S=1'b1 -pinAttr I1 @attr S=default -pg 1 -lvl 7 -y 260
load inst faulty_core_reg[1:0] RTL_REG__BREG_3 work[1:0]sww -attr @cell(#000000) RTL_REG -pg 1 -lvl 8 -y 500
load inst fault_detected0_i RTL_NEQ work -attr @cell(#000000) RTL_NEQ -pinBusAttr I0 @name I0[1:0] -pinBusAttr I1 @name I1[1:0] -pg 1 -lvl 4 -y 230
load inst fault_detected_reg RTL_REG_SYNC__BREG_2 work -attr @cell(#000000) RTL_REG_SYNC -pg 1 -lvl 8 -y 200
load inst faulty_core_i RTL_MUX2 work -attr @cell(#000000) RTL_MUX -pinBusAttr I0 @name I0[1:0] -pinBusAttr I0 @attr V=B\"10\",\ S=1'b1 -pinBusAttr I1 @name I1[1:0] -pinBusAttr I1 @attr S=default -pinBusAttr O @name O[1:0] -pg 1 -lvl 5 -y 260
load inst voted_state2_i__0 RTL_AND2 work -attr @cell(#000000) RTL_AND -pg 1 -lvl 1 -y 110
load inst voted_state1_i RTL_OR2 work -attr @cell(#000000) RTL_OR -pg 1 -lvl 2 -y 100
load inst voted_state2_i__1 RTL_AND2 work -attr @cell(#000000) RTL_AND -pg 1 -lvl 1 -y 250
load inst fault_detected0_i__0 RTL_NEQ work -attr @cell(#000000) RTL_NEQ -pinBusAttr I0 @name I0[1:0] -pinBusAttr I1 @name I1[1:0] -pg 1 -lvl 4 -y 320
load inst voted_state0_i RTL_OR2 work -attr @cell(#000000) RTL_OR -pg 1 -lvl 3 -y 110
load inst voted_state1_i__0 RTL_AND2 work -attr @cell(#000000) RTL_AND -pg 1 -lvl 2 -y 210
load inst voted_state2_i__2 RTL_AND2 work -attr @cell(#000000) RTL_AND -pg 1 -lvl 1 -y 320
load inst voted_state_reg[1:0] RTL_REG_SYNC__BREG_1 work[1:0]swws -attr @cell(#000000) RTL_REG_SYNC -pg 1 -lvl 8 -y 380
load inst voted_state1_i__1 RTL_OR2 work -attr @cell(#000000) RTL_OR -pg 1 -lvl 2 -y 310
load inst voted_state1_i__2 RTL_AND2 work -attr @cell(#000000) RTL_AND -pg 1 -lvl 2 -y 380
load net fault_detected0 -pin fault_detected0_i O -pin fault_detected_reg D -pin faulty_core_i I1[1] -pin faulty_core_i I1[0]
netloc fault_detected0 1 4 4 1030 180 NJ 180 NJ 180 2010J
load net fault_detected0_i__0_n_0 -pin fault_detected0_i__0 O -pin fault_detected_i I1 -pin faulty_core_i S
netloc fault_detected0_i__0_n_0 1 4 3 N N 1390 260 1720J
load net voted_state1_i__2_n_0 -pin voted_state0_i__0 I1 -pin voted_state1_i__2 O
netloc voted_state1_i__2_n_0 1 2 1 N
load net core_C_state[0] -attr @rip(#000000) core_C_state[0] -port core_C_state[0] -pin fault_detected0_i I0[0] -pin voted_state1_i__0 I1 -pin voted_state2_i__0 I1
load net fault_detected1 -pin fault_detected1_i O -pin fault_detected_i S -pin faulty_core_i__0 S
netloc fault_detected1 1 5 2 1390 N 1720
load net sig_voted[1] -attr @rip(#000000) 1 -pin fault_detected0_i I1[1] -pin fault_detected0_i__0 I1[1] -pin fault_detected1_i I1[1] -pin voted_state0_i__0 O -pin voted_state_reg[1:0] D[1]
load net voted_state2_i__0_n_0 -pin voted_state1_i I1 -pin voted_state2_i__0 O
netloc voted_state2_i__0_n_0 1 1 1 N
load net fault_detected -port fault_detected -pin fault_detected_reg Q
netloc fault_detected 1 8 1 NJ
load net voted_state[0] -attr @rip(#000000) 0 -port voted_state[0] -pin voted_state_reg[1:0] Q[0]
load net <const0> -ground -pin faulty_core_i I0[0] -pin faulty_core_i__0 I0[1] -pin faulty_core_i__1 I0[1] -pin faulty_core_i__1 I0[0]
load net faulty_core_i__1_n_0 -attr @rip(#000000) O[1] -pin faulty_core_i__1 O[1] -pin faulty_core_reg[1:0] D[1]
load net sig_voted[0] -attr @rip(#000000) 0 -pin fault_detected0_i I1[0] -pin fault_detected0_i__0 I1[0] -pin fault_detected1_i I1[0] -pin voted_state0_i O -pin voted_state_reg[1:0] D[0]
load net faulty_core_i__1_n_1 -attr @rip(#000000) O[0] -pin faulty_core_i__1 O[0] -pin faulty_core_reg[1:0] D[0]
load net faulty_core_i_n_0 -attr @rip(#000000) O[1] -pin faulty_core_i O[1] -pin faulty_core_i__0 I1[1]
load net core_B_state[1] -attr @rip(#000000) core_B_state[1] -port core_B_state[1] -pin fault_detected0_i__0 I0[1] -pin voted_state2_i__1 I1 -pin voted_state2_i__2 I0
load net fault_detected_i_n_0 -pin fault_detected_i O -pin fault_detected_reg SET
netloc fault_detected_i_n_0 1 7 1 N
load net faulty_core_i_n_1 -attr @rip(#000000) O[0] -pin faulty_core_i O[0] -pin faulty_core_i__0 I1[0]
load net voted_state[1] -attr @rip(#000000) 1 -port voted_state[1] -pin voted_state_reg[1:0] Q[1]
load net faulty_core[0] -attr @rip(#000000) 0 -port faulty_core[0] -pin faulty_core_reg[1:0] Q[0]
load net rst -pin fault_detected_reg RST -pin faulty_core_i__1 S -port rst -pin voted_state_reg[1:0] RST
netloc rst 1 0 8 NJ 570 NJ 570 NJ 570 NJ 570 NJ 570 NJ 570 NJ N 1990
load net voted_state2_i__2_n_0 -pin voted_state1_i__1 I1 -pin voted_state2_i__2 O
netloc voted_state2_i__2_n_0 1 1 1 N
load net <const1> -power -pin fault_detected_i I0 -pin faulty_core_i I0[1] -pin faulty_core_i__0 I0[0]
load net core_A_state[1] -attr @rip(#000000) core_A_state[1] -port core_A_state[1] -pin fault_detected1_i I0[1] -pin voted_state1_i__2 I0 -pin voted_state2_i__1 I0
load net core_B_state[0] -attr @rip(#000000) core_B_state[0] -port core_B_state[0] -pin fault_detected0_i__0 I0[0] -pin voted_state2_i I1 -pin voted_state2_i__0 I0
load net voted_state1 -pin voted_state0_i__0 I0 -pin voted_state1_i__1 O
netloc voted_state1 1 2 1 520
load net voted_state1_i__0_n_0 -pin voted_state0_i I1 -pin voted_state1_i__0 O
netloc voted_state1_i__0_n_0 1 2 1 520
load net voted_state2 -pin voted_state1_i__1 I0 -pin voted_state2_i__1 O
netloc voted_state2 1 1 1 270
load net clk -port clk -pin fault_detected_reg C -pin faulty_core_reg[1:0] C -pin voted_state_reg[1:0] C
netloc clk 1 0 8 NJ 450 NJ 450 NJ 450 NJ 450 NJ 450 NJ 450 NJ 450 2030
load net core_A_state[0] -attr @rip(#000000) core_A_state[0] -port core_A_state[0] -pin fault_detected1_i I0[0] -pin voted_state1_i__0 I0 -pin voted_state2_i I0
load net faulty_core_i__0_n_0 -attr @rip(#000000) O[1] -pin faulty_core_i__0 O[1] -pin faulty_core_i__1 I1[1]
load net faulty_core[1] -attr @rip(#000000) 1 -port faulty_core[1] -pin faulty_core_reg[1:0] Q[1]
load net faulty_core_i__0_n_1 -attr @rip(#000000) O[0] -pin faulty_core_i__0 O[0] -pin faulty_core_i__1 I1[0]
load net core_C_state[1] -attr @rip(#000000) core_C_state[1] -port core_C_state[1] -pin fault_detected0_i I0[1] -pin voted_state1_i__2 I1 -pin voted_state2_i__2 I1
load net voted_state1_i_n_0 -pin voted_state0_i I0 -pin voted_state1_i O
netloc voted_state1_i_n_0 1 2 1 N
load net voted_state2_i_n_0 -pin voted_state1_i I0 -pin voted_state2_i O
netloc voted_state2_i_n_0 1 1 1 310
load netBundle @core_C_state 2 core_C_state[1] core_C_state[0] -autobundled
netbloc @core_C_state 1 0 4 20 200 290 260 NJ 260 770
load netBundle @faulty_core_i__0_n_0 2 faulty_core_i__0_n_0 faulty_core_i__0_n_1 -autobundled
netbloc @faulty_core_i__0_n_0 1 6 1 1700
load netBundle @sig_voted 2 sig_voted[1] sig_voted[0] -autobundled
netbloc @sig_voted 1 3 5 750 370 1030 430 NJ 430 NJ 430 2010
load netBundle @voted_state 2 voted_state[1] voted_state[0] -autobundled
netbloc @voted_state 1 8 1 NJ
load netBundle @core_B_state 2 core_B_state[1] core_B_state[0] -autobundled
netbloc @core_B_state 1 0 4 60 160 NJ 160 NJ 160 730
load netBundle @faulty_core_i__1_n_0 2 faulty_core_i__1_n_0 faulty_core_i__1_n_1 -autobundled
netbloc @faulty_core_i__1_n_0 1 7 1 N
load netBundle @faulty_core_i_n_0 2 faulty_core_i_n_0 faulty_core_i_n_1 -autobundled
netbloc @faulty_core_i_n_0 1 5 1 1370
load netBundle @faulty_core 2 faulty_core[1] faulty_core[0] -autobundled
netbloc @faulty_core 1 8 1 NJ
load netBundle @core_A_state 2 core_A_state[1] core_A_state[0] -autobundled
netbloc @core_A_state 1 0 5 40 180 310 430 NJ 430 NJ 430 1050
levelinfo -pg 1 0 110 360 570 840 1210 1570 1860 2090 2290 -top 0 -bot 600
show
zoom 0.659518
scrollpos 53 4
#
# initialize ictrl to current module tmr_voter work:tmr_voter:NOFILE
ictrl init topinfo |
ictrl layer glayer install
ictrl layer glayer config ibundle 1
ictrl layer glayer config nbundle 0
ictrl layer glayer config pbundle 0
ictrl layer glayer config cache 1
