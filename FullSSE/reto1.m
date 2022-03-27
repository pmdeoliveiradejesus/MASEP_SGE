% 4 bus 6 lines (one paralel) 3 generators
global Dmin C  nr bdat ldat k1 k2 k3 Ip Sbase Vbase Zbase Ibase neval
%% System Data
Sbase=150;%MVA
Vbase=150;%kV
Vbaselow=10;%kV
Zbase=Vbase^2/Sbase;%ohms
Zbaselow=Vbaselow^2/Sbase;%ohms
Ibase=Sbase/(sqrt(3)*Vbase);%kA
econv=0.0001;
itermax=100;
% Generator rated powers and reactances    
SG1=150;%MVA
SG2=150;%MVA
XG1=.15;% pu
XG2=.15;% pu
Xt=0.04;%pu
Xg1=(XG1*Vbaselow^2/SG1)/Zbase+Xt;
Xg2=(XG2*Vbaselow^2/SG2)/Zbase+Xt;
Rg1=0;
Rg2=0;

Le=[100 70 80 100 110 90 100]; 
R=[.004 .0057 .005 .005 .0045 .0044 .005].*Le/Zbase; %line resistances (ohms)
X=[ .05 .0714 .0563 .045 .0409 .05 .05].*Le/Zbase; %line reactance (ohms)
B=[0     0    0 0     0    0 0 0]*Zbase; %line total susceptance (siemens)
nl=length(R);
%		1 2	3	  4	    5	  6	  7   8	9       10    11		12   13  14
ldat=[  
        1 3 10001 Rg1  Xg1    0   0   0;
        2 7 10002 Rg2  Xg2    0   0   0;
        3 8 90001 R(1) X(1) B(1)  0   0;
        3 4 90002 R(2) X(2) B(2)  0   0;
        4 5 90003 R(3) X(3) B(3)  0   0;
        5 6 90004 R(4) X(4) B(4)  0   0;        
        6 7 90005 R(5) X(5) B(5)  0   0;
        7 8 90005 R(6) X(6) B(6)  0   0; 
        3 7 90006 R(7) X(7) B(7)  0   0;
];
ep0=0.08;
ep1=0.08;
ep2=0.00;
ep3=0.00;
ep4=0.02;
 
ldat(:,9)=[0.604838782455270;1.00000000000024;0.0812760472643883;0.608670791672273;0.207104239680056;-0.259753261413015;-0.726715415249432;0.185529605701390;-0.0851080564994322];
ldat(:,10)=ep0;
ldat(:,11)=[0.555729253015610;0.575995625480502;0.0724915338907586;0.438733490407191;0.152443698827742;-0.116371763396732;-0.452364481264375;0.0624587885914423;0.0170678535660507];
ldat(:,12)=ep1;
 ldat(:,17)=0;
 ldat(:,18)=0;
ldat(:,13)=[-0.604838782455270;-1.00000000000024;-0.0812429598021196;-0.607104239700049;-0.206913405179383;0.260048748575751;0.729336063875859;-0.185423706863507;0.0851343303892262];
ldat(:,14)=ep2;
ldat(:,15)=[-0.528292878161889;-0.521836939750525;-0.0720779406124024;-0.419110365702494;-0.150294902350161;0.119031147861353;0.476183265446785;-0.0612553927063892;-0.0168051146681165];
ldat(:,16)=ep3;
ldat(:,19)=0;
ldat(:,20)=0;
%     1   2     3 4    5 6      7       8   9    10  11 12  13   14  15    16   17   18 19    20 21 22 23  
bdat=[  1 1001  1 0    0 0.0000 0.0000  1   0    0   0  0   0     0  0    1.0  1.0   0  0      0 0  0 0;
        2 1001  2 1.00 0 0.0000 0.0000  1   0    0   0  0   0     0  0     .9  1.10  0  0      0 0  0 0;
        3 9001  3 0    0 0.0000 0.0000  1   0    0   0  0   0     0  0     .9  1.10  0  0      0 0  0 0;
        4 9002  3 0    0 60/150 40/150  1   0    0   0  0   0     0  0     .9  1.10  0  0      0 0  0 0;
        5 9003  3 0    0 70/150 40/150  1   0    0   0  0   0     0  0     .9  1.10  0  0      0 0  0 0;
        6 9001  3 0    0 70/150 50/150  1   0    0   0  0   0     0  0     .9  1.10  0  0      0 0  0 0;
        7 9002  3 0    0 0.0000 0.0000  1   0    0   0  0   0     0  0     .9  1.10  0  0      0 0  0 0;
        8 9003  3 0    0 40/150 20/150  1   0    0   0  0   0     0  0     .9  1.10  0  0      0 0  0 0;
                 ];
bdat(:,24)=0;
bdat(:,25)=0;
bdat(:,26)=[1;1;0.937668685535354;0.961300740904266;0.955983700878540;0.960572536068881;0.977422533510425;0.975020034065881];
bdat(:,27)=ep4;
for k=28:37
    bdat(:,k)=0;
end
% 	Line Dat Array Input (ldat): 																								
%	1-  From Bus 																								
%  2.- To Bus																									
%  3.- Circuit Name																									
%  4.- Line Resistance (R)(p.u)	
%  5.- Line Impedance (X) (p.u.)	
%  6.- Line Charging (Bcap)(p.u) 	
%  7.- Thermal Maximun Line Limit (Smax)(p.u); 	
%  8.- Transfromer tap >0
%  9.- Active power flow measurement ij
%  10.- Active power flow accuracy (std dev) ij
%  11.- ReActive power flow measurement ij
%  12.- ReActive power flow accuracy (std dev) i
%  13.- Active power flow measurement ji
%  14.- Active power flow accuracy (std dev) ji
%  15.- ReActive power flow measurement ji
%  16.- ReActive power flow accuracy (std dev) ji
%  17.- Current flow measurement ij
%  18.- Current flow accuracy (std dev) ij
%  19.- Current flow measurement ji
%  20.- Current flow accuracy (std dev) ji

%  NOTE: Bus ordering cannot be aleatory	

% 	Bus Dat Array Input (bdat): 	
%	1-  Bus 	
%  2.- Bus Name		
%  3.- Bus Type: (1) Slack or Swing Bus  (2) PV Bus (3) PQ Bus	
%  4.- Active Power Generation (Initial Value) (Pgen)(p.u)	
%  5.- Reactive Power Generation (Initial Value) (Qgen)(p.u)	
%  6.- Active Power Load (Inelastic Value) (Pload)(p.u)	
%  7.- Reactive Power Load (Inelastic Value) (Qload)(p.u)	
%  8.- Bus Tension (Initial Value) (V)(p.u)		
%  9.- Gsh(pu)	(not active)	
% 10.- Bsh(pu)	 
% 11.- reserved	
% 12.- reserved	
% 13.- reserved	
% 14.- reserved	
% 15.- reserved	
% 16.- Bus Tension Minimum Limit (Vmin)(p.u)	
% 17.- Bus Tension Maximum Limit (Vmax)(p.u)	
% 18.- Active Load Type:  (0) Inelastic (1) Elastic: Linear Price = A - B*Pload 	
% 19.- Demand Function Coeficient A ($/pu) 	
% 20.- Demand Function Coeficient B -slope- %/pu^2) 	
% 21.- Reactive Load Type:  (0) Inelastic (1) Elastic: Qload = Pload * tan(acos(Bus Power Factor))	
% 22.- Bus Power Factor 	
% 23.- Number of generators	
% 24.- reserved	
% 25.- reserved	
% 26.- Bus Voltage magnitude measurement	
% 27.- Bus Voltage magnitude measurement accuracy (std dev)	
% 28.- Bus angle measurement	
% 29.- Bus angle magnitude measurement accuracy (std dev)	
% 30.- free
% 31.- Active power injection measurement  	
% 32.- Active power injection measurement accuracy (std dev)	
% 33.- reActive power injection measurement 	
% 34.- reActive power injection measurement accuracy (std dev)	
% 35.- Active current injection measurement  	
% 36.- Active current injection measurement accuracy (std dev)	
% 37.- reActive current injection measurement  	
% 38.- reActive current injection measurement accuracy (std dev)
             
%POWER FLOW SOLUTION
%  x0=[0.0194860156162146;-0.0251601985620076;-0.0454982596615947;-0.0518227962166833;-0.0437591577161918;-0.0221320228166140;-0.0277993772232958;1;1;0.977709789933657;0.961300740904266;0.955983700878540;0.960572536068881;0.977422533510425;0.975020034065881];
