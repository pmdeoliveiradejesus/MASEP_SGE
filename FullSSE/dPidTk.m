function [derivative] = dPidTk(i,k)
global v theta  Gbus  Bbus n 
if i==k
derivative=-v(i)^2*Bbus(i,i);
for c=1:n
derivative = derivative+v(i)*v(c)*(-Gbus(i,c)*sin(theta(i)-theta(c))+(Bbus(i,c))*cos(theta(i)-theta(c)));   %dpi/dTi
end
else
derivative = v(i)*v(k)*(Gbus(i,k)*sin(theta(i)-theta(k))-(Bbus(i,k))*cos(theta(i)-theta(k)));   %dPi/dTj
end




