%%%%SSE General%%%%%
clear all
close all
clc
global z 
global nl n Y 
global Gbus 
global Bbus 
global W 
global h theta v su ldat
 disp([' '])
disp([' '])
disp([' ****************************************************************'])
disp([' *  GENERALIZED STATE ESTIMATION (c)2017                        *'])
disp([' *                             NORMAL EQUATION                  *'])
disp([' *  E-mail: pm.deoliveiradejes@uniandes.edu.co                  *'])
disp([' *  20-05-17 Basic: state variables [v, theta]                  *'])
disp([' ****************************************************************'])
disp([' '])
disp([' '])
% Select case study::
%abur4e6;caso='Abur Exposito Book Example (Chapter 4)';
%reto1;caso='Braga 1996';
%prueba_escrita;caso='Examen';
%evaluacion_5_a;caso='Identificación';
reto1;caso='Solución Reto 1';
% Options input: convergence;
%--------------------------------------------------------------------------------------------------
CallYbusBuild;
Gbus=sparse(real(Y));
Bbus=sparse(imag(Y));
for k=1:n%identifies slack angle
   if bdat(k,3)==1
   	sl=k;   
   end
end
bdat(sl,29)=0;
% Measurement set structure
i=1;
k=1;
for j=1:nl
if ldat(j,10) > 0% a P flow measurement exists!
PF(k,1)=ldat(j,1);
PF(k,2)=ldat(j,2);
PF(k,3)=ldat(j,9);
PF(k,4)=ldat(j,10);
z(i,1)=ldat(j,9);
pii(i)=ldat(j,10);
i=i+1;
k=k+1;
end
end


nPF=k-1;
k=1;
for j=1:nl
if ldat(j,14) > 0% a P Flow measurement exists!
PFr(k,1)=ldat(j,2);
PFr(k,2)=ldat(j,1);
PFr(k,3)=ldat(j,13);
PFr(k,4)=ldat(j,14);
z(i,1)=ldat(j,13);
pii(i)=ldat(j,14);
i=i+1;
k=k+1;
end
end
nPFr=k-1;
k=1;
for j=1:n
if bdat(j,32) > 0% a P injection measurement exists!
PI(k,1)=bdat(j,1);
PI(k,2)=bdat(j,1);
PI(k,3)=bdat(j,31);
PI(k,4)=bdat(j,32);
z(i,1)=bdat(j,31);
pii(i)=bdat(j,32);
i=i+1;
k=k+1;
end
end
nPI=k-1;
k=1;
for j=1:nl
if ldat(j,12) > 0% a Q flow measurement exists!
QF(k,1)=ldat(j,1);
QF(k,2)=ldat(j,2);
QF(k,3)=ldat(j,11);
QF(k,4)=ldat(j,12);
z(i,1)=ldat(j,11);
pii(i)=ldat(j,12);
i=i+1;
k=k+1;
end
end
nQF=k-1;
k=1;
for j=1:nl
if ldat(j,16) > 0% a Q flow measurement exists!
QFr(k,1)=ldat(j,2);
QFr(k,2)=ldat(j,1);
QFr(k,3)=ldat(j,15);
QFr(k,4)=ldat(j,16);
z(i,1)=ldat(j,15);
pii(i)=ldat(j,16);
i=i+1;
k=k+1;
end
end
nQFr=k-1;
k=1;
for j=1:n
if bdat(j,34) > 0% a Q injection measurement exists!
    QI(k,1)=bdat(j,1);
QI(k,2)=bdat(j,1);
QI(k,3)=bdat(j,33);
QI(k,4)=bdat(j,34);
z(i,1)=bdat(j,33);
pii(i)=bdat(j,34);
i=i+1;
k=k+1;
end
end
nQI=k-1;
k=1;
for j=1:n
if bdat(j,27) > 0% a voltage measurement exists!
V(k,1)=bdat(j,1);
V(k,2)=bdat(j,1);
V(k,3)=bdat(j,26);
V(k,4)=bdat(j,27);
z(i,1)=bdat(j,26);
pii(i)=bdat(j,27);
i=i+1;
k=k+1;
end
end
nV=k-1;

k=1;

for j=1:n
if bdat(j,3) > 1% 
tk(k,1)=bdat(j,1);
tk(k,2)=bdat(j,1);
tk(k,3)=bdat(j,28);
tk(k,4)=bdat(j,29);
k=k+1;
end
end
k=1;
for j=1:n
if bdat(j,29) > 0% an Angle measurement exists!
z(i,1)=bdat(j,28);
pii(i)=bdat(j,29);
i=i+1;
k=k+1;
end
end
ntk=k-1;
m=nPF+nPFr+nPI+nQF+nQFr+nQI+nV+ntk; %Total number of measurements
wii=(pii.^-2);
W=diag(wii);
z0=z;
% %Generate values from a normal distribution with mean x and standard deviation SIGMA 
% SIGMAp=0.08;
% SIGMAv=0.02;
% SIGMAt=0.000001;
% for k=1:nPF+nPFr+nPI+nQF+nQFr+nQI 
% z(k)=norminv(rand(1,1),z(k),SIGMAp);
% end
% for k=nPF+nPFr+nPI+nQF+nQFr+nQI+1: nPF+nPFr+nPI+nQF+nQFr+nQI+nV
% z(k)=norminv(rand(1,1),z(k),SIGMAv);
% end
% for k=nPF+nPFr+nPI+nQF+nQFr+nQI+nV+1:nPF+nPFr+nPI+nQF+nQFr+nQI+nV+ntk
% z(k)=norminv(rand(1,1),z(k),SIGMAt);
% end
%%------
%callz; % Calls an external measurmenet vector
 
%[Pij Qij Pji Qji Vi Thethai]
%------
 
for k=1:m
    Ax(k)=k;
end

Ws = sparse(Ax,Ax,wii,m,m); %Sparse weight matrix
%Flat x0 Initial state 
 for k=1:2*n-1
           if k<n
 x(k,1)=0;%angle
           else
 x(k,1)=1;%voltage magnitude             
           
           end
 end
dx=100;
iter=1;
tic

while max(abs(dx)) > econv 
%for iter=1:1% In case if you need only one iteration

   j=1;
for k=1:n    
    if k==sl
    theta(sl)=0;    
    else
    theta(k)=x(j,iter);
    j=j+1; end
end

for k=n:2*n-1
v(k+1-n)=x(k,iter); 
end

flag=1;
for k=1:2*n-1
    i=1;
  if nPF>0  
   for j=1:length(PF(:,1))
       if PF(j,4) > 0
          if k<n
       H(i,k)= dPijdTk(PF(j,1),PF(j,2),tk(k,1));
        if dPijdTk(PF(j,1),PF(j,2),tk(k,1)) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dPijdTk(PF(j,1),PF(j,2),tk(k,1)); 
flag=flag+1;
        end
                     
       else
       H(i,k)= dPijdVk(PF(j,1),PF(j,2),k+1-n);
               if dPijdVk(PF(j,1),PF(j,2),k+1-n) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dPijdVk(PF(j,1),PF(j,2),k+1-n);  
flag=flag+1;
        end
           end
       i=i+1;
       end
   end
  end
  
   if nPFr>0
      for j=1:length(PFr(:,1))
       if PFr(j,4) > 0
          if k<n
       H(i,k)= dPijdTk(PFr(j,1),PFr(j,2),tk(k,1));
        if dPijdTk(PFr(j,1),PFr(j,2),tk(k,1)) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dPijdTk(PFr(j,1),PFr(j,2),tk(k,1)); 
flag=flag+1;
        end
                     
       else
       H(i,k)= dPijdVk(PFr(j,1),PFr(j,2),k+1-n);
               if dPijdVk(PFr(j,1),PFr(j,2),k+1-n) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dPijdVk(PFr(j,1),PFr(j,2),k+1-n);  
flag=flag+1;
        end
           end
       i=i+1;
       end
   end
   end
   
   if nPI>0
   for j=1:length(PI(:,1))
       if PI(j,4) > 0
          if k<n
       H(i,k)= dPidTk(PI(j,1),tk(k,1));
                     if dPidTk(PI(j,1),tk(k,1)) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dPidTk(PI(j,1),tk(k,1)); 
flag=flag+1;
                     end
                   
       
          else
         
        H(i,k)= dPidVk(PI(j,2),k+1-n);
                            if dPidVk(PI(j,2),k+1-n) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dPidVk(PI(j,2),k+1-n); 
flag=flag+1;
        end
           end
       i=i+1;
       end
   end
   end
   
   if nQF>0
    for j=1:length(QF(:,1))
       if QF(j,4) > 0
          if k<n
       H(i,k)= dQijdTk(QF(j,1),QF(j,2),tk(k,1));
                                  if dQijdTk(QF(j,1),QF(j,2),tk(k,1)) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dQijdTk(QF(j,1),QF(j,2),tk(k,1)); 
flag=flag+1;
        end
          else
       H(i,k)= dQijdVk(QF(j,1),QF(j,2),k+1-n);
                                  if dQijdVk(QF(j,1),QF(j,2),k+1-n) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dQijdVk(QF(j,1),QF(j,2),k+1-n);  
flag=flag+1;
        end
           end
       i=i+1;
       end
    end
   end
   
   if nQFr>0
    for j=1:length(QFr(:,1))
       if QF(j,4) > 0
          if k<n
       H(i,k)= dQijdTk(QFr(j,1),QFr(j,2),tk(k,1));
                                  if dQijdTk(QFr(j,1),QFr(j,2),tk(k,1)) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dQijdTk(QFr(j,1),QFr(j,2),tk(k,1)); 
flag=flag+1;
        end
          else
       H(i,k)= dQijdVk(QFr(j,1),QFr(j,2),k+1-n);
                                  if dQijdVk(QFr(j,1),QFr(j,2),k+1-n) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dQijdVk(QFr(j,1),QFr(j,2),k+1-n);  
flag=flag+1;
        end
           end
       i=i+1;
       end
    end
   end
   
   if nQI>0 
   for j=1:length(QI(:,1))
       if QI(j,4) > 0
          if k<n
       H(i,k)= dQidTk(QI(j,1),tk(k,1));
                                  if dQidTk(QI(j,1),tk(k,1)) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dQidTk(QI(j,1),tk(k,1));  
flag=flag+1;
        end
           else
       H(i,k)= dQidVk(QI(j,2),k+1-n);
                                  if dQidVk(QI(j,2),k+1-n) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dQidVk(QI(j,2),k+1-n);
flag=flag+1;
        end
           end
       i=i+1;
       end
   end
   end
   
   if nV>0
      for j=1:length(V(:,1))
       if V(j,4) > 0
          if k<n
       H(i,k)= dVidTk(V(j,1),tk(k,1));
                                  if dVidTk(V(j,1),tk(k,1))== 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dVidTk(V(j,1),tk(k,1));  
flag=flag+1;
        end
           else
       H(i,k)= dVidVk(V(j,2),k+1-n);
                                  if dVidVk(V(j,2),k+1-n) == 0
        else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dVidVk(V(j,2),k+1-n);  
flag=flag+1;
        end
           end
       i=i+1;
       end
      end   
     
   end
   
       if ntk>0
          for j=1:length(tk(:,1))
             if tk(j,4) > 0
                if k<n

                    H(i,k)= dTidTk(tk(j,1),tk(k,1));


                                  if   dTidTk(tk(j,1),tk(k,1))== 0
                                   else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dTidTk(tk(j,1),tk(k,1));  
flag=flag+1;
                                  end
                  
                    
                    
                else
                                   
       H(i,k)= dTidVk(tk(j,2),k+1-n);
                           if dTidVk(tk(j,2),k+1-n) == 0
                            else
statevar(flag)=k;
measurement(flag)=i;
JacobiValue(flag)=dTidVk(tk(j,2),k+1-n);  
flag=flag+1;
                           end
                   end
       i=i+1;
       end
      end      
       end
end %Jacobian matrx building
Hs= sparse(measurement,statevar,JacobiValue',m,2*n-1);  %Sparse Jacobi matrix
Gs=Hs'*Ws*Hs;%Sparse Gain Matrix
%G=H'*W*H;
% h(x) calculations
for k=1:2*n-1
    i=1;
  if nPF>0
   for j=1:length(PF(:,1))
       if PF(j,4) > 0
       h(i,1)= PFij(PF(j,1),PF(j,2));
       i=i+1;
       end
   end
  end
  if nPFr>0
      for j=1:length(PFr(:,1))
       if PFr(j,4) > 0
       h(i,1)= PFij(PFr(j,1),PFr(j,2));
       i=i+1;
       end
      end
  end
  if nPI>0
   for j=1:length(PI(:,1))
       if PI(j,4) > 0
       h(i,1)= Pi(PI(j,1));
       i=i+1;
       end
   end
  end
  if nQF>0
     for j=1:length(QF(:,1))
       if QF(j,4) > 0
       h(i,1)= QFij(QF(j,1),QF(j,2));
       i=i+1;
       end
     end
  end
     if nQFr>0
     for j=1:length(QFr(:,1))
       if QFr(j,4) > 0
       h(i,1)= QFij(QFr(j,1),QFr(j,2));
       i=i+1;
       end
     end
     end
     if nQI>0
   for j=1:length(QI(:,1))
       if QI(j,4) > 0
       h(i,1)= Qi(QI(j,1));
       i=i+1;
       end
   end
     end
     if nV>0
    for j=1:length(V(:,1))
       if V(j,4) > 0
       h(i,1)= v(V(j,1));
       i=i+1;
       end
   end
     end
        if ntk>0
        for j=1:length(tk(:,1))
        if tk(j,4) > 0
        h(i,1)= theta(tk(j,1));
        i=i+1;
        end
        end
        end
end
%x(:,iter+1)=x(:,iter)-inv(Gs)*(-Hs'*Ws*(z-h));
R = chol(Gs)';%Choelsky decomposition L'*L=Gs
t=(Hs'*Ws*(z-h));
u(1)=0;%Forward substitution
flag=0;
for i=1:2*n-1   
u(i)=inv(R(i,i))*(t(i)-flag);
flag=0;
if i<2*n-1
for j=1:i   
flag=R(i+1,j)*u(j)+flag; 
end
end
end
dx(2*n-1)=0;%backward substitution
flag=0;
for i=2*n-1:-1.0:1
dx(i)=inv(R(i,i))*(u(i)-flag);
flag=0;
if i>1
 for j=2*n-1:-1:i 
 flag=R(j,i-1)*dx(j)+flag; 
 end
end
end
%deltax(:,iter)=full(dx');
%fobj(iter)=(z-h)'*Ws*(z-h);
x(:,iter+1)=x(:,iter)+dx';
iter=iter+1;
% full(Gs)
% eig(full(Gs))
% pause
%fobj(iter-1);
max(abs(dx));
end
fobj=(z-h)'*Ws*(z-h);
%testing Bad data
J=(z-h)'*Ws*(z-h);
df=m-(2*n-1);
 pValue=1-chi2cdf(J,m-(2*n-1))%>0.01 not suspicious bad data
 Jcrit=chi2inv(.99,m-(2*n-1));
 J-Jcrit; %<0 not suspicious bad data
 % identyfying bad data 
uest=z-h;
Ks=Hs*inv(Gs)*Hs'*Ws;
S=eye(m,m)-Ks;
Omega=S*inv(Ws);
r=S*uest;
rN=abs(r)./sqrt(diag(Omega));%if rN(j) > 3 j is bad data
max(rN)
[i]=find(rN==max(max((rN))));
figure
plot(rN);
%figure
%plot(100*abs((z-h)./h));

