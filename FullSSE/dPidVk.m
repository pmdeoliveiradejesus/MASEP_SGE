function [derivative] = dPidVk(i,k)
global v theta  Gbus  Bbus n
if i==k
derivative=v(i)*Gbus(i,i);
for c=1:n
derivative = derivative+v(c)*(Gbus(i,c)*cos(theta(i)-theta(c))+(Bbus(i,c))*sin(theta(i)-theta(c)));   %dpi/dVi
end
else
derivative = v(i)*(Gbus(i,k)*cos(theta(i)-theta(k))+(Bbus(i,k))*sin(theta(i)-theta(k)));   %dpi/dVj
end













