* HW 6, Problem 1, Determination of SNM graphically
* ECE 559, Fall 2009, Purdue University 
*.TEMP    25.0000 
*.include '/home/coimbasn/45nm_finfet/45nm_FinFET.sp'
.lib '/home/coimbasn/PTM-MG/modelfiles/models' ptm20lstp
    
*.GLOBAL VDD! 
*.PARAM VDD  = 0.9 
*.PARAM L    = 300n 
*.PARAM WN   = 1800n 
*.PARAM WP   = '3*WN' 
.PARAM WNA  = 450n 
.PARAM U   = 0 
.PARAM UL  = '-VDD/sqrt(2)' 
.PARAM UH  = ' VDD/sqrt(2)' 

*.PARAM BITCAP  = 1e-12 
.param BITCAP = .1e-12
.param BITCAP2 = 1e-12
.param v = 1.1
.param vdd = 1.1
.OPTION POST 

*CBLB BLB 0 BITCAP2
*CBL BL 0 BITCAP2

Xnl1 Vout1 Vin1 0 0 nfet2
Xpl1 Vout1 Vin1 VDD! VDD! pfet

Xnl2 Vout2 Vin2 0 0 nfet2
Xpl2 Vout2 Vin2 VDD! VDD! pfet

*Xaccr BL WL WL QD DGNMOS
*Xaccl BLB WL WL QBD DGNMOS

VVDD! VDD! 0 DC=VDD 

Vin1 Vin1 0
Vin2 Vin2 0

*.DC U UL UH 0.01  
.DC Vin1 0 1.5 0.01
.DC Vin2 0 1.5 0.01
.PRINT DC V(Vout1) V(Vout2)  
.END
