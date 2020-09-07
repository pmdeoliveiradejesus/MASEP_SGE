% CallYbusBuild
% 3/6/2017 Sparse Ybus is not well structured, it should be adjusted

% global nl n Y Yf

%Number of lines and Buses
nl=length(ldat(:,1));
n=length(bdat(:,1));
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
end% Transformer Taps acoording to Arrillaga Model. PD 26/12/14
for k=1:n
%shbus(k)=complex(bdat(k,9),bdat(k,10));%include shunts at each bus% i=sqrt(-1);
sh(k,k)=complex(bdat(k,9),bdat(k,10));%include shunts at each bus% i=sqrt(-1);
end% Shunts PD 26/12/14
for i=1:n
   Y(i,i)=0;
   for j=1:n
      if i~=j
      Y(i,i)=inv(Z(i,j))+Y(i,i)+su(i,j);
      Y(i,j)=-inv(Z(i,j));   
      end
   end
end% Vreate Ybus
Y=Y+sh;%Add (sh) shunt suceptance at buses


% flag2=1;
% for k=1:nl
%        if ldat(k,8)>0%TAP exist at node ldat(k,1)
%            From(flag2)=ldat(k,1);
%    To(flag2)=ldat(k,2);
%  Admittance(flag2)=-inv(complex(ldat(k,4),ldat(k,5))/ldat(k,8));
%         else 
%    From(flag2)=ldat(k,1);
%    To(flag2)=ldat(k,2);
%    Admittance(flag2)=-inv(complex(ldat(k,4),ldat(k,5)));   
%     end 
%    
%    flag2=flag2+1;
% end
% for k=1:nl
%        if ldat(k,8)>0
%   From(flag2)=ldat(k,2);
%    To(flag2)=ldat(k,1);
%  Admittance(flag2)=-inv(complex(ldat(k,4),ldat(k,5)))/ldat(k,8);
%         else 
%    From(flag2)=ldat(k,2);
%    To(flag2)=ldat(k,1);
%    Admittance(flag2)=-inv(complex(ldat(k,4),ldat(k,5)));   
%     end 
%    flag2=flag2+1;
% end
% 
% Ybusp = sparse(From,To,Admittance,n,n);
% 
% for k=1:n
% A=find(ldat(:,2)==k);
% B=find(ldat(:,1)==k);    
% C=vertcat(A,B);
% nt=length(C);
% sh(k,1)=0;
% for i=1:nt
% sh(k,1)=sh(k,1)+0.5*complex(0,ldat(C(i),6));    
% end
% end
% for k=1:n
% From2(k)=k;
% end
% Ybush = sparse(From2,From2,sh(:,1),n,n);
% Ysh=sparse(From2,From2,sh(:,1),n,n);
% Ybustaphigh = 0;
% Ybustaplow = 0;
% 
% flagh=1;
% flagl=1;
% for k=1:n
%   
%     if ldat(k,8)>0
% sstaphigh(flagh,1)=inv(complex(ldat(k,4),ldat(k,5)))*((1-ldat(k,8))/ldat(k,8)^2);    
% sstaplow(flagl,1)=inv(complex(ldat(k,4),ldat(k,5)))*((ldat(k,8)-1)/ldat(k,8));
% Athigh(flagh)=ldat(k,1);
% Atlow(flagl)=ldat(k,2);
% flagh=flagh+1;
% flagl=flagl+1;
%     end
% end
% if flagh>1
% Ybustaphigh = sparse(Athigh,Athigh,sstaphigh(:,1),n,n);
% Ybustaplow = sparse(Atlow,Atlow,sstaplow(:,1),n,n);
% end
% 
% 
% for k=1:n
%    From(flag2)=k;
%    To(flag2)=k;
%    Admittance(flag2)=0;
%    for j=1:n
%       Admittance(flag2)=Admittance(flag2)-(Ybusp(j,k)+Ybusp(j,k))/2;
%    end
%    flag2=flag2+1;
% end
% 
% 
% Ybus = sparse(From,To,Admittance,n,n)+Ybush+Ybustaphigh+Ybustaplow+Ysh;
% %Y2=sparse((Y));

 
%% Ybus neglecting series impedance (real part)
for i=1:n
   for j=1:n
Zf(i,j)=10^20;
	end
end
for k=1:nl
   if ldat(k,1)>=ldat(k,2)
      Zf(ldat(k,2),ldat(k,1))=complex(0*ldat(k,4),ldat(k,5));
      else
      Zf(ldat(k,1),ldat(k,2))=complex(0*ldat(k,4),ldat(k,5));
end
end
for k=1:nl
   if ldat(k,1)>=ldat(k,2)
      suf(ldat(k,2),ldat(k,1))=0.5*complex(0,ldat(k,6));
      else
      suf(ldat(k,1),ldat(k,2))=0.5*complex(0,ldat(k,6));
   end
end
for i=1:n
   for j=1:n
      if i~=j
      suf(j,i)=suf(i,j);   
      end
   end
end
for i=1:n
   for j=1:n
      if i~=j
      Zf(j,i)=Zf(i,j);   
      end
   end
end
for k=1:nl% Transformer Taps acoording to Arrillaga Model. PD 26/12/14
    if ldat(k,8)>0
      suf(ldat(k,1),ldat(k,2))= inv(Z(ldat(k,1),ldat(k,2)))*((1-ldat(k,8))/ldat(k,8)^2);
      suf(ldat(k,2),ldat(k,1))= inv(Z(ldat(k,2),ldat(k,1)))*((ldat(k,8)-1)/ldat(k,8));        
      Zf(ldat(k,2),ldat(k,1))=ldat(k,8)*complex(0*ldat(k,4),ldat(k,5));
      Zf(ldat(k,1),ldat(k,2))=Z(ldat(k,2),ldat(k,1));    
   end
end
for k=1:n% Shunts PD 26/12/14
%shbus(k)=complex(bdat(k,9),bdat(k,10));%include shunts at each bus% i=sqrt(-1);
shf(k,k)=complex(bdat(k,9),bdat(k,10));%include shunts at each bus% i=sqrt(-1);
end
for i=1:n% create Ybus
   Yf(i,i)=0;
   for j=1:n
      if i~=j
      Yf(i,i)=inv(Zf(i,j))+Yf(i,i)+suf(i,j);
      Yf(i,j)=-inv(Zf(i,j));   
      end
   end
end
Yf=Yf+shf;%Add (sh) shunt suceptance at buses
 Gbusf=sparse(real(Yf));
 BBusf=sparse(imag(Yf));
 
 %% Ybus neglecting SHUNTS and series impedance (real part)
for i=1:n
   for j=1:n
Zff(i,j)=10^20;
	end
end
for k=1:nl
   if ldat(k,1)>=ldat(k,2)
      Zff(ldat(k,2),ldat(k,1))=complex(0*ldat(k,4),ldat(k,5));
      else
      Zff(ldat(k,1),ldat(k,2))=complex(0*ldat(k,4),ldat(k,5));
end
end
for k=1:nl
   if ldat(k,1)>=ldat(k,2)
      suff(ldat(k,2),ldat(k,1))=0.*complex(0,ldat(k,6));
      else
      suff(ldat(k,1),ldat(k,2))=0.*complex(0,ldat(k,6));
   end
end
for i=1:n
   for j=1:n
      if i~=j
      suff(j,i)=suff(i,j);   
      end
   end
end
for i=1:n
   for j=1:n
      if i~=j
      Zff(j,i)=Zff(i,j);   
      end
   end
end
for k=1:nl% Transformer Taps acoording to Arrillaga Model. PD 26/12/14
    if ldat(k,8)>0
      suff(ldat(k,1),ldat(k,2))= 0*inv(Z(ldat(k,1),ldat(k,2)))*((1-ldat(k,8))/ldat(k,8)^2);
      suff(ldat(k,2),ldat(k,1))= 0*inv(Z(ldat(k,2),ldat(k,1)))*((ldat(k,8)-1)/ldat(k,8));        
      Zff(ldat(k,2),ldat(k,1))=ldat(k,8)*complex(0*ldat(k,4),ldat(k,5));
      Zff(ldat(k,1),ldat(k,2))=Z(ldat(k,2),ldat(k,1));    
   end
end
for k=1:n% Shunts PD 26/12/14
%shbus(k)=complex(bdat(k,9),bdat(k,10));%include shunts at each bus% i=sqrt(-1);
shff(k,k)=0*complex(bdat(k,9),bdat(k,10));%include shunts at each bus% i=sqrt(-1);
end
for i=1:n% create Ybus
   Yff(i,i)=0;
   for j=1:n
      if i~=j
      Yff(i,i)=inv(Zff(i,j))+Yff(i,i)+suff(i,j);
      Yff(i,j)=-inv(Zff(i,j));   
      end
   end
end
Yff=Yff+shff;%Add (sh) shunt suceptance at buses