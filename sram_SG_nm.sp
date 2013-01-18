* HW 6, Problem 1, Determination of SNM graphically
* ECE 559, Fall 2009, Purdue University 
*.TEMP    25.0000 
.include '/home/coimbasn/45nm_finfet/45nm_FinFET.sp'
    
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

CBLB BLB 0 BITCAP2
CBL BL 0 BITCAP2

* one inverter 
*MPL QD QB VDD! VDD!  TSMC25P  L='L' W='WP'  
*+AD='WP*2.5*L' AS='WP*2.5*L' PD='2*WP+5*L' PS='2*WP+5*L'  
*+M=1  
*MNL QD QB 0  0    TSMC25N  L='L' W='WN'  
*+AD='WN*2.5*L' AS='WN*2.5*L' PD='2*WN+5*L' PS='2*WN+5*L' 
*+M=1  Homework 6 Solution  ECE 559 (Fall 2009), Purdue *University 
*Page 10 of 16

Xnl1 QD QB QB  0 DGNMOS
Xpl1 QD QB QB VDD! DGPMOS

* one inverter 
*MPR QBD Q VDD! VDD!  TSMC25P  L='L' W='WP'  
*+AD='WP*2.5*L' AS='WP*2.5*L' PD='2*WP+5*L' PS='2*WP+5*L'  
*+M=1  
*MNR QBD Q 0  0    TSMC25N  L='L' W='WN'  
*+AD='WN*2.5*L' AS='WN*2.5*L' PD='2*WN+5*L' PS='2*WN+5*L' 
*+M=1  

Xnl2 QBD Q Q 0 DGNMOS
Xpl2 QBD Q Q VDD! DGPMOS

* access transistors 
*MNAL BLB WL QBD 0    TSMC25N  L='L' W='WNA'  
*+AD='WNA*2.5*L' AS='WNA*2.5*L' PD='2*WNA+5*L' PS='2*WNA+5*L' 
*+M=1  
*MNAR BL  WL QD  0    TSMC25N  L='L' W='WNA'  
*+AD='WNA*2.5*L' AS='WNA*2.5*L' PD='2*WNA+5*L' PS='2*WNA+5*L' 
*+M=1  

Xaccr BL WL WL QD DGNMOS
Xaccl BLB WL WL QBD DGNMOS


VVDD!   VDD! 0  DC=VDD 
* when reading, use VDD  
VWL WL   0  DC=VDD 
.IC V(BL)  = VDD  
.IC V(BLB) = VDD   
* use voltage controlled voltage sources (VCVS) 
* changing the co-ordinates in 45 degree angle 
EQ     Q  0 VOL=' 1/sqrt(2)*U + 1/sqrt(2)*V(V1)' 
EQB  QB 0 VOL='-1/sqrt(2)*U + 1/sqrt(2)*V(V2)' 
* inverter characteristics 
EV1  V1 0 VOL=' U + sqrt(2)*V(QBD)' 
EV2  V2 0 VOL='-U + sqrt(2)*V(QD)' 
* take the absolute value for determination of SNM 
EVD  VD 0 VOL='ABS(V(V1) - V(V2))' 
*Homework 6 Solution  ECE 559 (Fall 2009), Purdue *University 
*Page 11 of 16

.DC  U UL UH 0.01  
.PRINT DC V(QD) V(QBD) V(V1) V(V2) 
.MEASURE DC MAXVD MAX V(VD) 
* measure SNM 
.MEASURE DC SNM param='1/sqrt(2)*MAXVD' 
.END
