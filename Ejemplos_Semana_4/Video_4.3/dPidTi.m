function [derivative] = dPidTi(i)
global v theta  Gbus  Bbus n
derivative=-v(i)^2*Bbus(i,i);
for c=1:n
derivative = derivative+v(i)*v(c)*(-Gbus(i,c)*sin(theta(i)-theta(c))+(Bbus(i,c))*cos(theta(i)-theta(c)));   %dpi/dTi
end