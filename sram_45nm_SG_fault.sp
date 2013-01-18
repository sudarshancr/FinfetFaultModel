*SRAM full electrical schematic by Rathna Keerthi 

*The design consists of two single FinFET SRAM in a column *along with precharge , write driver and sense *Amplifier *circuitry. 

* SRAM read time is around 9n
* SRAM write time is around 6.4n
* Thes Read time and write time includes Precharge and *sense time.
*The signals used in the design are:
*BL, BLB- BIT LINES
*OUT, OUT1- OUTPUT LINES(DRIVEN BY Sense Amp)
*WE- Write enable
*SENSE- Sense Amplifier enable
*phg - precharge
*EN1- column multiplexer enable
*IN- input to write to SRAM
*QBD,QD - Two storage points of SRAM CELL 0
*QBD2,QD2 - Two storage points of SRAM CELL 1
*WL1,WL2 - Word line of Cell 0 and Cell 1

*PLEASE NOTE- Modify your model files to have pfet and nfet *to have diffrent fins. I have used upto 20 fins(prcharge *circuitry) to acheive resonable read *and write times. *When you modify please make sure you follow the same *naming conventions that I have used. Also make changes to *the path settings.

*Last, I apologize for not commenting out fully, this is *just partly commented due to lack of time. I hope the *design works for you in your first attempt.

*.lib '/home/meenakri/finfet/PTM-MG/models' ptm20lstp
*.lib '/home/coimbasn/PTM-MG/modelfiles/models' ptm20lstp
.include '/home/coimbasn/45nm_finfet/45nm_FinFET.sp'

.options post

*Bitline capacitances

.param BITCAP = .1e-12
.param BITCAP2 = 1e-12
.param v = 1.1
.param vdd = 1.1

CBLB BLB 0 BITCAP2
CBL BL 0 BITCAP2
COUT OUT 0 BITCAP
COUT1 OUT1 0 BITCAP

vVDD VDD 0 DC=vdd
vVSS VSS 0 0

*Precharge

*Xprech1 BL phg VDD VDD pfet20
*Xprech2 BLB phg VDD VDD pfet20
*Xprech3 BL phg BLB VDD pfet20

Xprech1 BL phg phg VDD DGPMOS20
Xprech2 BLB phg phg VDD DGPMOS20
Xprech3 BL phg phg BLB DGPMOS20

*Sram1(Pulldown - 2 fins   Pullup- 1 fin)
*Inverter 1
*Xinvl1 QBD QD VSS VSS nfet2
*Xinvl2 QBD QD VDD VDD pfet

Xinvl1 QBD QD QD VSS DGNMOS
Xinvl2 QBD QD QD VDD DGPMOS

*Inverter 2
*Xinvr1 QD QBD VSS VSS nfet2
*Xinvr2 QD QBD VDD VDD pfet

Xinvr1 QD QBD QBD VSS DGNMOS
Xinvr2 QD QBD QBD VDD DGPMOS


*access transistors(1 fin)
*Xaccl BL WL1 QBD VSS nfet
*Xaccr BLB WL1 QD VSS nfet

Xaccl BL WL1 WL1 QBD DGNMOS
Xaccr BLB WL1 WL1 QD DGNMOS


*Sram2
*Inverter 1
*Xinv2l1 QBD2 QD2 VSS VSS nfet2
*Xinv2l2 QBD2 QD2 VDD VDD pfet

Xinv2l1 QBD2 QD2 QD2 VSS DGNMOS2
Xinv2l2 QBD2 QD2 QD2 VDD DGPMOS

*Inverter 2
*Xinv2r1 QD2 QBD2 VSS VSS nfet2
*Xinv2r2 QD2 QBD2 VDD VDD pfet

Xinv2r1 QD2 QBD2 QBD2 VSS DGNMOS2
Xinv2r2 QD2 QBD2 QBD2 VDD DGPMOS


*access transistors
*Xaccl2 BL WL2 QBD2 VSS nfet
*Xaccr2 BLB WL2 QD2 VSS nfet

Xaccl2 BL WL2 WL2 QBD2 DGNMOS
Xaccr2 BLB WL2 WL2 QD2 DGNMOS

*Enable Mux
*Xen1 BL EN1 OUT VSS nfet20
*Xen2 BL N OUT VDD pfet20
*Xen3 BLB N OUT1 VDD pfet20
*Xen4 BLB EN1 OUT1 VSS nfet20

Xen1 BL EN1 EN1 OUT DGNMOS20
Xen2 BL N N OUT DGPMOS20
Xen3 BLB N N OUT1 DGPMOS20
Xen4 BLB EN1 EN1 OUT1 DGNMOS20

*Enableinv
*Xeninv1 N EN1 VDD VDD pfet2
*Xeninv2 N EN1 VSS VSS nfet2

Xeninv1 N EN1 EN1 VDD DGPMOS2
Xeninv2 N EN1 EN1 VSS DGNMOS2

*Precharge 2(Out lines for  Sense Amplifier)
*X2prech1 OUT phg VDD VDD pfet4
*X2prech2 OUT1 phg VDD VDD pfet4
*X2prech3 OUT phg OUT1 VDD pfet4

X2prech1 OUT phg phg VDD DGPMOS4
X2prech2 OUT1 phg phg VDD DGPMOS4
X2prech3 OUT phg phg OUT1 DGPMOS4

*Latch-based Sense Amp
*Inverter 1
*XSENSE1 OUT OUT1 M VSS nfet20
*XSENSE2 OUT OUT1 VDD VDD pfet8

XSENSE1 OUT OUT1 OUT1 M DGNMOS20
XSENSE2 OUT OUT1 OUT1 VDD DGPMOS8

*Inverter 2
*XSENSE3 OUT1 OUT M VSS nfet20
*XSENSE4 OUT1 OUT VDD VDD pfet8

XSENSE3 OUT1 OUT OUT M DGNMOS20
XSENSE4 OUT1 OUT OUT VDD DGPMOS8

*SA control
*XSENSE5 M SENSE VSS VSS nfet20
XSENSE5 M SENSE SENSE VSS DGNMOS20

*Write driver
*Xwr1 OUT WE I VSS nfet10
*Xwr2 OUT1 WE J VSS nfet10
*Xwr3 I K VSS VSS nfet10
*Xwr4 J IN VSS VSS nfet10
*Xwr5 K IN VDD VDD pfet2
*Xwr6 K IN VSS VSS nfet2

Xwr1 OUT WE WE I DGNMOS10
Xwr2 OUT1 WE WE J DGNMOS10
Xwr3 I K K VSS DGNMOS10
Xwr4 J IN IN VSS DGNMOS10
Xwr5 K IN IN VDD DGPMOS2
Xwr6 K IN IN VSS DGNMOS2

*Input[ Consists of two read and two write operation sequence. Only one of vIN1 or vIN0 should  be active for a simulation. For Example, when vIN0 is *active the following input does this operation in sequence write0, read 0, write1, read1. When vIN1 is active, it does Write1, read1, write0,read0.
*to select cell 0, vWL1 and vWL2OFF should be active.You can write a script to automate it to your need.

*VDD VDD gnd v

vphg phg VSS PWL (0n 0 3n 0 3.2n v 9.8n v 10n 0 13n 0 13.2n v 19.8n v 20n 0 23n 0 23.2n v 29.8n v 30n 0 33n 0 33.2n v 39.8n v 40n 0)

vWL1 WL1 VSS PWL (0n 0 3n 0 3.2n v 6.8n v 7n 0 10n 0 13n 0 13.2n v 16.8n v 17n 0 20n 0 23n 0 23.2n v 26.8n v 27n 0 30n 0 33n 0 33.2n v 36.8n v 37n 0 40n 0 )

*vWL2 WL2 VSS PWL (0n 0 3n 0 3.2n v 6.8n v 7n 0 10n 0 13n 0 13.2n v 16.8n v 17n 0 20n 0 23n 0 23.2n v 26.8n v 27n 0 30n 0 33n 0 33.2n v 36.8n v 37n 0 40n 0  )

vWL2OFF WL2 VSS PWL ( 0n 0 3n 0 3.2n 0 6.6n 0 6.8n 0 40n 0)

vSENSE SENSE VSS PWL ( 0n 0 9.8n 0 15.7n 0 15.9n v 19.8n v 20n 0 35.7n 0 35.9n v 39.8n v 40n 0 )

vEN1 EN1 VSS PWL (0n 0 3n 0 3.2n v 6.8n v 7n 0 10n 0 13n 0 13.2n v 16.8n v 17n 0 20n 0 23n 0 23.2n v 26.8n v 27n 0 30n 0 33n 0 33.2n v 36.8n v 37n 0 40n 0  )

vWE WE VSS PWL (0n 0 3n 0 3.2n v 6.8n v 7n 0 10n 0 13n 0 13.2n 0 16.8n 0 17n 0 20n 0 23n 0 23.2n v 26.8n v 27n 0 30n 0 33n 0 33.2n 0 36.8n 0 37n 0 40n 0  )

*vIN1 IN VSS PWL (0n 0 2.5n 0 2.51n v 7n v 7.1n 0 22.5n 0 22.51n 0 27n 0 27.1n 0 40n 0)

vIN0 IN VSS PWL (0n 0 2.5n 0 2.51n 0 7n 0 7.1n 0 22.5n 0 22.51n v 27n v 27.1n 0 40n 0)

.IC V(QBD)=0
.IC V(QD)= VDD

.IC V(QBD2)=0
.IC V(QD2)= VDD

.OP

.tran .1n 45n UIC

.end
