function [derivative] = dQidVi(i)
global v theta  Gbus  Bbus n

derivative=-v(i)*Bbus(i,i);
for c=1:n
derivative = derivative+v(c)*(Gbus(i,c)*sin(theta(i)-theta(c))-(Bbus(i,c))*cos(theta(i)-theta(c)));   %dqi/dVi
end