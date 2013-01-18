*One 6T SRAM Cell to measure leakage current

.include '/home/coimbasn/45nm_finfet/45nm_FinFET.sp'

.options post

*Bitline capacitances

.param BITCAP = .1e-12
.param BITCAP2 = 1e-12
.param v = 0.9
.param vdd = 0.9
.param k = 0.00009

CBLB BLBX 0 BITCAP2
CBL BLX 0 BITCAP2
*COUT OUT 0 BITCAP
*COUT1 OUT1 0 BITCAP

vVDD VDD 0 DC=vdd
*vVDD1 VDD1 0 DC=vdd
vVSS VSS 0 0


*Inverter 1
Xinvl1 QBD QD Vlo VSS DGNMOS2
Xinvl2 QBD QD Vhi X DGPMOS

*Inverter 2
Xinvr1 QD QBD Vlo VSS DGNMOS2
Xinvr2 QD QBD Vhi X DGPMOS

*access transistors(1 fin)
Xaccl BL WL1 Vlo QBD DGNMOS
Xaccr BLB WL1 Vlo QD DGNMOS

*Pre-charge circuit:
*Xpre1 BL phg Vhi VDD1 DGPMOS20
*Xpre2 BLB phg Vhi VDD1 DGPMOS20

*C1 Vout GND 10f

fP1 VSS N1 Vtstp1 k
Cp1 N1 VSS 100p
Rp1 N1 VSS 100k
Vtstp1 VDD X 0

fP2 VSS N2 Vtstp2 k
Cp2 N2 VSS 100p
Rp2 N2 VSS 100k
Vtstp2 BLX BL 0

fP3 VSS N3 Vtstp3 k
Cp3 N3 VSS 100p
Rp3 N3 VSS 100k
Vtstp3 BLBX BLB 0

Vhi Vhi VSS 1.1V
Vlo VSS Vlo 0.2V

*vphg phg VSS PWL (0n 0 3n 0 3.2n 0.9 9.8n 0.9 10n 0 13n 0 13.2n 0.9 19.8n 0.9 20n 0 23n 0 23.2n 0.9 29.8n 0.9 30n 0 33n 0 33.2n 0.9 39.8n 0.9 40n 0)

*vWL1 WL1 VSS PWL (0n 0 3n 0 3.2n 0.9 6.8n 0.9 7n 0 10n 0 13n 0 13.2n 0.9 16.8n 0.9 17n 0 20n 0 23n 0 23.2n 0.9 26.8n 0.9 27n 0 30n 0 33n 0 33.2n 0.9 36.8n 0.9 37n 0 40n 0 )

vWL1 WL1 VSS PWL (0n 0 0.2n 0.9 6.8n 0.9 7n 0 10n 0)

*vWL2 WL2 VSS PWL (0n 0 3n 0 3.2n 0.9 6.8n 0.9 7n 0 10n 0 13n 0 13.2n 0.9 16.8n 0.9 17n 0 20n 0 23n 0 23.2n 0.9 26.8n 0.9 27n 0 30n 0 33n 0 33.2n 0.9 36.8n 0.9 37n 0 40n 0  )

*vWL2OFF WL2 VSS PWL ( 0n 0 3n 0 3.2n 0 6.6n 0 6.8n 0 40n 0)

*vSENSE SENSE VSS PWL ( 0n 0 9.8n 0 15.7n 0 15.9n 0.9 19.8n 0.9 20n 0 35.7n 0 35.9n 0.9 39.8n 0.9 40n 0 )

*vEN1 EN1 VSS PWL (0n 0 3n 0 3.2n 0.9 6.8n 0.9 7n 0 10n 0 13n 0 13.2n 0.9 16.8n 0.9 17n 0 20n 0 23n 0 23.2n 0.9 26.8n 0.9 27n 0 30n 0 33n 0 33.2n 0.9 36.8n 0.9 37n 0 40n 0  )

*vWE WE VSS PWL (0n 0 3n 0 3.2n 0.9 6.8n 0.9 7n 0 10n 0 13n 0 13.2n 0 16.8n 0 17n 0 20n 0 23n 0 23.2n 0.9 26.8n 0.9 27n 0 30n 0 33n 0 33.2n 0 36.8n 0 37n 0 40n 0  )

*vWE WE VSS PWL (0n 0 0.2n 0.9 6.8n 0.9 7n 0 10n 0 13n 0)
vWE WE VSS PWL (0n 0 13n 0)

*vIN1 IN VSS PWL (0n 0 2.5n 0 2.51n 0.9 7n 0.9 7.1n 0 22.5n 0 22.51n 0 27n 0 27.1n 0 40n 0)

*vIN0 IN VSS PWL (0n 0 2.5n 0 2.51n 0 7n 0 7.1n 0 22.5n 0 22.51n 0.9 27n 0.9 27.1n 0 40n 0)

.IC V(BL) = VDD
.IC V(BLB) = VDD

.IC V(QBD)= VDD
.IC V(QD)= 0

*.IC V(QBD2)= 0
*.IC V(QD2)= VDD

.OP

.tran .1n 25n UIC

.end

