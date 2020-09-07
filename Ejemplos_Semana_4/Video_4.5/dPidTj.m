function [derivative] = dPidTk(i,j,k)
global v theta  Gbus  Bbus n 



derivative=-v(i)^2*Bbus(i,i);
for k=1:n
derivative = derivative+v(i)*v(k)*(-Gbus(i,k)*sin(theta(i)-theta(k))+(Bbus(i,k))*cos(theta(i)-theta(k)));   %dpi/dTi
end


derivative = v(i)*v(j)*(Gbus(i,j)*sin(theta(i)-theta(j))-(Bbus(i,j))*cos(theta(i)-theta(j)));   %dPi/dTj
