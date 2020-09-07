function [derivative] = dQidVk(i,k)
global v theta  Gbus  Bbus n
if i==k
derivative=-v(i)*Bbus(i,i);
for c=1:n
derivative = derivative+v(c)*(Gbus(i,c)*sin(theta(i)-theta(c))-(Bbus(i,c))*cos(theta(i)-theta(c)));   %dqi/dVi
end
else
derivative = v(i)*(Gbus(i,k)*sin(theta(i)-theta(k))-(Bbus(i,k))*cos(theta(i)-theta(k)));   %dQi/dVj
end













