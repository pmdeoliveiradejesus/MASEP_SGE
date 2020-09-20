%TEST CASE: 			Abur-Exposito Example 2					
Sbase=100;%MVA  
econv=1e-7;
itermax=10;
%		1	2	3	    4	    5	    6	    7   8	9       10    11		12   13  14
ldat=	[	
        1	2	10001	0.01	0.03	0.00	10	0   0.888   .008  0.568 0.008 0 0 0 0 0 0 ;
        1	3	10001	0.02	0.05	0.00	10	0   1.173   .008  0.663 0.008 0 0 0 0 0 0 ; 
        2	3	10001	0.03	0.08	0.00	10	0   0       0     0     0     0 0 0 0 0 0 ;
        
        
];																
%		1	2       3	4	5	6       7       8       9	10	11	12	13	14	15	16      17      18	19	20	21	22	23 24 25   26   27    28 29 30 31 32	
bdat=	[	
   1  1002   1  0.0000000  0.0000000 0.0000000  0.0000000  0.9996 0.0000  0.0000  0.0000 0.0000  0.0000  0.0000 0.0000  1.0000  1.0000 0.0000  0.0000  0.0000 0.0000  0.0000  1.0000 0.0000  0.0000  1.0060000 0.0040000  0.0000000  0.000000 0.0000000  0.0000000  0.000000 0.0000000 0.0000000 ;
   2  1001   3  0.0000000  0.0000000 0.4958000  0.2973000  1.0000 0.0000  0.0000  0.0000 0.0000  0.0000  0.0000 0.0000  0.9500  1.0500 0.0000  0.0000  0.0000 0.0000  0.0000  1.0000 0.0000  0.0000  0.9680000 0.0040000  0.0000000  0.000000 0.0000000  -0.501000  0.010000 -0.286000 0.010000 ;
   3  1001   3  0.0000000  0.0000000 1.5138000  0.7864000  1.0000 0.0000  0.0000  0.0000 0.0000  0.0000  0.0000 0.0000  0.9500  1.0500 0.0000  0.0000  0.0000 0.0000  0.0000  1.0000 0.0000  0.0000  0.0000000 0.0000000  0.0000000  0.000000 0.0000000  0.0000000  0.000000 0.0000000 0.0000000 ;

        ];
%		9	10	11	12	13	14	15																	
gct=	[	
        0	0.100000	0	0	10.0000	-2	2	;																
        ];		
    
    %x(:,1)=[-1.2475*pi/180 -2.7457*pi/180 .9996 .9742 .9439]';%theta2 theta3 v1 v2 v3

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




% NOTE: Bus ordering (from 1 to n bus) is important. Must be a coincidence between bus number and file number!
%Generation Cost array imput
%  1.- Cost Fuction Co + A*Pgen + B*Pgen^2:  Fixed  Cost Co ($)
% 2.- Cost Fuction Co + A*Pgen + B*Pgen^2:  Linear Incremental Cost A ($/pu)
% 3.- Cost Fuction Co + A*Pgen + B*Pgen^2:  Quadratic Incremental Cost B ($/pu^2)
% 4.- Active Power Generation Minumun Limit (Pgen-min)(p.u);
% 5.- Active Power Generation Maximun Limit (Pgen-max)(p.u);
% 6.- Rective Power Generation Minumun Limit (Qgen-min)(p.u);
% 7.- Rective Power Generation Maximun Limit (Qgen-max)(p.u);
