function [derivative] = dQidTk(i,k)
global v theta  Gbus  Bbus n 
if i==k
derivative=-v(i)^2*Gbus(i,i);
for c=1:n
derivative = derivative+v(i)*v(c)*(Gbus(i,c)*cos(theta(i)-theta(c))+(Bbus(i,c))*sin(theta(i)-theta(c)));   %dqi/dTi
end
else
derivative = -v(i)*v(k)*(Gbus(i,k)*cos(theta(i)-theta(k))+(Bbus(i,k))*sin(theta(i)-theta(k)));   %dQi/dTj
end




