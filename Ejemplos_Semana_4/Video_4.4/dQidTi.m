function [derivative] = dQidTi(i,j)
global v theta  Gbus  Bbus n

derivative=-v(i)^2*Gbus(i,i);
for c=1:n
derivative = derivative+v(i)*v(c)*(Gbus(i,c)*cos(theta(i)-theta(c))+(Bbus(i,c))*sin(theta(i)-theta(c)));   %dqi/dTi
end