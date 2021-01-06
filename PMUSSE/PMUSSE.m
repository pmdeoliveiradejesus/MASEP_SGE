% PMU Linear State estimator
clear all
close all
clc
reto2; caso='BragaSaraiva 8bus';
% Options input: convergence;
tic;
%--------------------------------------------------------------------------------------------------
%Number of lines and Buses
nl=length(ldat(:,1));
n=length(bdat(:,1));
%
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

%% Transformer Taps acoording Arrillaga Model. PD 26/12/14
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

%% PMU STATE ESTIMATOR
Y(3,:)=[];
Y(7-1,:)=[];
G=real(Y);
B=imag(Y);
Wv=ones(2*n,1)*0.02^-2;
Wi=ones(2*n-4,1)*0.0612^-2;
W=diag([Wv;Wi]);
%z=[real(vv);imag(vv);real(I);imag(I)];
YY=[G,-B;B,G];
H=[eye(2*n,2*n);YY];
x=inv(H'*W*H)*H'*W*z;
h=H*x;
J=(z-h)'*W*(z-h)
m=length(z);
nve=length(x);
df=m-nve
pValue=1-chi2cdf(J,df)%>.01% not suspicious bad data
Jcrit=chi2inv(1-.5,df);
J-Jcrit %<0 not suspicious bad data
 % identyfying bad data 
uest=z-H*x;
Ks=H*inv(H'*W*H)*H'*W;
S=eye(m,m)-Ks;
Omega=S*inv(W);
r=S*uest;
rN=abs(r)./sqrt(diag(Omega));%if rN(j) > 3 j is bad data
max(rN);
[i]=find(rN==max(max((rN))))
% figure
% plot(abs(z-h))
figure
plot(rN)
% % 
% %Retiramos el TC9, medidas 17 y 25
% clearvars -except z Y n
% Y(1,:)=[];
% z(17,:)=[];
% z(17+8-1,:)=[];
% G=real(Y);
% B=imag(Y);
% Wv=ones(2*n,1)*0.02^-2;
% Wi=ones(2*n-4-2,1)*0.0612^-2;
% W=diag([Wv;Wi]);
% %z=[real(vv);imag(vv);real(I);imag(I)];
% YY=[G,-B;B,G];
% H=[eye(2*n,2*n);YY];
% x=inv(H'*W*H)*H'*W*z;
% h=H*x;
% J=(z-h)'*W*(z-h)
% m=length(z);
% nve=length(x);
% df=m-nve
% pValue=1-chi2cdf(J,df)%>.01% not suspicious bad data
% Jcrit=chi2inv(1-.5,df);
% J-Jcrit %<0 not suspicious bad data
%  % identyfying bad data 
% uest=z-H*x;
% Ks=H*inv(H'*W*H)*H'*W;
% S=eye(m,m)-Ks;
% Omega=S*inv(W);
% r=S*uest;
% rN=abs(r)./sqrt(diag(Omega));%if rN(j) > 3 j is bad data
% max(rN);
% [i]=find(rN==max(max((rN))))
% % figure
% % plot(abs(z-h))
% figure
% plot(rN)


 