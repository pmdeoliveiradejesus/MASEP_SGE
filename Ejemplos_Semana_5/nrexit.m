POWER FLOW Version 2.0 (c)2003, 2014                        
---------                                                   
This program has been developed by Paulo M. De Oliveira     
in MATLAB                                                   
E-mail: pdeoliv@GMAIL.COM                                   
NEWTON RAPHSON                               
--------- 
 
Power flow completed in:  0.118 s
NUMBER OF BUSES:   8
NUMBER OF LINES:   9
NUMBER OF ITERATIONS:   5
CONVERGENCY: 0.0001000000000000
 
NLines   SBus RBus R(p.u.) X(p.u)  P(i,j)   P(j,i)  Ploss(kW) Q(i,j)   Q(j,i)   Qloss (kVAr) S(i,j)
Line  1     1    3 0.0000  0.0407  0.6048  -0.6048  0.0000  0.5557  -0.5283  4115.4590  121.8242
Line  2     2    7 0.0000  0.0407  1.0000  -1.0000  0.0000  0.5760  -0.5218  8123.8060  171.1124
Line  3     3    8 0.0027  0.0333  0.0813  -0.0812  4.9631  0.0725  -0.0721  62.0392  16.3137
Line  4     3    4 0.0027  0.0333  0.6087  -0.6071  234.9844  0.4387  -0.4191  2943.4890  111.5969
Line  5     4    5 0.0027  0.0300  0.2071  -0.2069  28.6257  0.1524  -0.1503  322.3250  38.4674
Line  6     5    6 0.0033  0.0300  -0.2598  0.2600  44.3235  -0.1164  0.1190  398.9117  42.7968
Line  7     6    7 0.0033  0.0300  -0.7267  0.7293  393.1001  -0.4524  0.4762  3572.8429  129.5202
Line  8     7    8 0.0026  0.0300  0.1855  -0.1854  15.8848  0.0625  -0.0613  180.5096  29.3279
Line  9     3    7 0.0033  0.0333  -0.0851  0.0851  3.9411  0.0171  -0.0168  39.4108  13.0185
 
                                                     -----                    -----
TOTAL LOSSES in kW and kVAr:                         725.82274169                    19758.7932
 
NBus      P(p.u.)    Q(p.u)    V(p.u.)     Th(rad)
Bus  1    0.6048     0.5557    1.0000     0.0000
Bus  2    1.0000     0.5760    1.0000     0.0195
Bus  3    0.0000     0.0000    0.9777     -0.0252
Bus  4    -0.4000     -0.2667    0.9613     -0.0455
Bus  5    -0.4667     -0.2667    0.9560     -0.0518
Bus  6    -0.4667     -0.3333    0.9606     -0.0438
Bus  7    0.0000     0.0000    0.9774     -0.0221
Bus  8    -0.2667     -0.1333    0.9750     -0.0278
 
CONTROL VARIABLES
SLACK BUS
Bus  1   Active Generation 90.72581574 MW 
PV BUSES
Bus  2   Active Generation 150.00000000 MW 
 
       Total active Generation 240.72581574 MW 
 
Bus  1   Reactive Generation 83.35945189 MVAr
Bus  2   Reactive Generation 86.399414994 MVAr
 
       Total Reactive Generation 169.75886689 MVAr 
 
STATE VARIABLES
 
Bus  1  Tension 1.00000000 pu  Angle 0.0000 DEG
Bus  2  Tension 1.00000000 pu  Angle 1.1165 DEG
Bus  3  Tension 0.97770977 pu  Angle -1.4416 DEG
Bus  4  Tension 0.96130058 pu  Angle -2.6069 DEG
Bus  5  Tension 0.95598344 pu  Angle -2.9692 DEG
Bus  6  Tension 0.96057236 pu  Angle -2.5072 DEG
Bus  7  Tension 0.97742251 pu  Angle -1.2681 DEG
Bus  8  Tension 0.97502001 pu  Angle -1.5928 DEG
