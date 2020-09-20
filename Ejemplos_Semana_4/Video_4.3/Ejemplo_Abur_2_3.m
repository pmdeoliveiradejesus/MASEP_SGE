clear all
clc
global z 
global Gbus 
global Bbus 
global W 
global theta1 
global n 
global h theta v
disp([' '])
disp([' '])
disp([' ****************************************************************'])
disp([' *  STATE ESTIMATION (c)2017                                    *'])
disp([' *                               NORMAL EQUATION                *'])
disp([' *  E-mail: pm.deoliveiradejes@uniandes.edu.co                  *'])
disp([' *  20-05-17 Basic: state variables [v, theta]                  *'])
disp([' ****************************************************************'])
disp([' '])
disp([' '])
abur4e3; caso='abur4e3';%Abur.Exposito Example 2.3
tic;
%--------------------------------------------------------------------------------------------------
%Number of lines and Buses
nl=length(ldat(:,1));
n=length(bdat(:,1));
%% Build Ybus
for i=1:n
   for j=1:n
Z(i,j)=10^20;
	end
end
for k=1:nl
   if ldat(k,1)>=ldat(k,2)
      Z(ldat(k,2),ldat(k,1))=complex(ldat(k,4),ldat(k,5));
      else
      Z(ldat(k,1),ldat(k,2))=complex(ldat(k,4),ldat(k,5));
end
end
for k=1:nl
   if ldat(k,1)>=ldat(k,2)
      su(ldat(k,2),ldat(k,1))=0.5*complex(0,ldat(k,6));
      else
      su(ldat(k,1),ldat(k,2))=0.5*complex(0,ldat(k,6));
   end
end
for i=1:n
   for j=1:n
      if i~=j
      su(j,i)=su(i,j);   
      end
   end
end
for i=1:n
   for j=1:n
      if i~=j
      Z(j,i)=Z(i,j);   
      end
   end
end
for k=1:nl
    if ldat(k,8)>0
      su(ldat(k,1),ldat(k,2))= inv(Z(ldat(k,1),ldat(k,2)))*((1-ldat(k,8))/ldat(k,8)^2);
      su(ldat(k,2),ldat(k,1))= inv(Z(ldat(k,2),ldat(k,1)))*((ldat(k,8)-1)/ldat(k,8));        
      Z(ldat(k,2),ldat(k,1))=ldat(k,8)*complex(ldat(k,4),ldat(k,5));
      Z(ldat(k,1),ldat(k,2))=Z(ldat(k,2),ldat(k,1));    
   end
end
%% Shunts PD 26/12/14
for k=1:n    
sh(k,k)=complex(bdat(k,9),bdat(k,10));%include shunts at each bus% i=sqrt(-1);
end
%create Ybus
for i=1:n
   Y(i,i)=0;
   for j=1:n
      if i~=j
      Y(i,i)=inv(Z(i,j))+Y(i,i)+su(i,j);
      Y(i,j)=-inv(Z(i,j));   
      end
   end
end
Y=Y+sh;%Add (sh) shunt suceptance at buses
Gbus=real(Y);
Bbus=imag(Y);
%% MEASUREMENT DATA
[n,n]=size(Gbus);
[nl,flag]=size(ldat);
i=1;
z=[0.888 1.173 -0.501 .568 .663 -0.286 1.006 .968]';%p12 p13 p2 q12 q13 q2 v1 v2 
sii=[.008 .008 .010 .008 .008 .010 .0040 .0040]';%p12 p13 p2 q12 q13 q2 v1 v2
wii=sii.^-2;
W=diag(wii);
theta1=0;
x(:,1)=[ 0 0 1 1 1]';%theta2 theta3 v1 v2 v3

%% BUILD THE JACOBIAN
itermax=1;
for iter=1:1 
theta(2)=x(1,iter);
theta(3)=x(2,iter); 
v(1)=x(3,iter); 
v(2)=x(4,iter); 
v(3)=x(5,iter); 

%  theta(2)     theta(3)     v(1)         v(2)          v(3) (2N-1)
H=[
   dPijdTj(1,2) 0            dPijdVi(1,2) dPijdVj(1,2)  0;            %pf(1,2)
   0            dPijdTj(1,3) dPijdVi(1,3) 0             dPijdVj(1,3); %pf(1,3) 
   dPidTi(2)    dPidTj(2,3)  dPidVj(2,1)  dPidVi(2)   dPidVj(2,3);    %p(2) 
   dQijdTj(1,2) 0            dQijdVi(1,2) dQijdVj(1,2)  0;            %qf(1,2)
   0            dQijdTj(1,3) dQijdVi(1,3) 0             dQijdVj(1,3); %qf(1,3)
   dQidTi(2)    dQidTj(2,3)  dQidVj(2,1)  dQidVi(2)     dQidVj(2,3);  %q(2)
   dVidTj(1,2)  dVidTj(1,3)  dVidVi(1)    dVidVj(1,2)   dVidVj(1,3);  %v(1)
   dVidTi(2)    dVidTj(2,3)  dVidVj(2,1)  dVidVi(2)     dVidVj(2,3);  %v(2) m
];
% %% THE GAIN MATRIX
% G=H'*W*H;
% %% THE MEASUREMENT FUNCTION
% h(1,1)= (v(1)^2*-Gbus(1,2)-v(1)*v(2)*(-Gbus(1,2)*cos(theta(1)-theta(2))+-Bbus(1,2)*sin(theta(1)-theta(2)))); %p12
% h(2,1)= (v(1)^2*-Gbus(1,3)-v(1)*v(3)*(-Gbus(1,3)*cos(theta(1)-theta(3))+-Bbus(1,3)*sin(theta(1)-theta(3))));
% h(3,1)=0;
% for k=1:n
% h(3,1)=h(3,1)+v(2)*v(k)*(Gbus(2,k)*cos(theta(2)-theta(k))+Bbus(2,k)*sin(theta(2)-theta(k)));
% end
% h(4,1)=(-v(1)^2*(-Bbus(1,2))-v(1)*v(2)*(-Gbus(1,2)*sin(theta(1)-theta(2))-(-Bbus(1,2))*cos(theta(1)-theta(2)))); 
% h(5,1)=(-v(1)^2*(-Bbus(1,3))-v(1)*v(3)*(-Gbus(1,3)*sin(theta(1)-theta(3))-(-Bbus(1,3))*cos(theta(1)-theta(3))));
% h(6,1)=0;
% for k=1:n
% h(6,1)=h(6,1)+v(2)*v(k)*(Gbus(2,k)*sin(theta(2)-theta(k))-Bbus(2,k)*cos(theta(2)-theta(k)));
% end
% h(7,1)=v(1);
% h(8,1)=v(2);
% %% SOLVING THE NROMAL EQUATION
% x(:,iter+1)=x(:,iter)-inv(G)*(-H'*W*(z-h));
% end
% %% CONVERGE!
% fobj=(z-h)'*W*(z-h)
% stateofthesystem(1,1)=x(1,iter+1)*180/pi;%deg
% stateofthesystem(2,1)=x(2,iter+1)*180/pi;%deg
% stateofthesystem(3,1)=x(3,iter+1);%pu
% stateofthesystem(4,1)=x(4,iter+1);%pu
% stateofthesystem(5,1)=x(5,iter+1);%pu
% stateofthesystem(:,1)
% p1=0;
% for k=1:n
% p1=p1+v(1)*v(k)*(Gbus(1,k)*cos(theta(1)-theta(k))+Bbus(1,k)*sin(theta(1)-theta(k)));
% end
% q1=0;
% for k=1:n
% q1=q1+v(1)*v(k)*(Gbus(1,k)*sin(theta(1)-theta(k))-Bbus(1,k)*cos(theta(1)-theta(k)));
% end
% p2=h(3,1);
% q2=h(6,1);
% p3=0;
% for k=1:n
% p3=p3+v(3)*v(k)*(Gbus(3,k)*cos(theta(3)-theta(k))+Bbus(3,k)*sin(theta(3)-theta(k)));
% end
% q3=0;
% for k=1:n
% q3=q3+v(3)*v(k)*(Gbus(3,k)*sin(theta(3)-theta(k))-Bbus(3,k)*cos(theta(3)-theta(k)));
end
%losses=(p1+p2+p3)*100*1000;%kW

