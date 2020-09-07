function [derivative] = dPidVi(i)
global v theta  Gbus  Bbus n

derivative=v(i)*Gbus(i,i);
for c=1:n
derivative = derivative+v(c)*(Gbus(i,c)*cos(theta(i)-theta(c))+(Bbus(i,c))*sin(theta(i)-theta(c)));   %dpi/dVi
end