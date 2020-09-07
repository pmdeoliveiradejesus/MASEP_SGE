function [derivative] = dPidVk(i,j,k)
global v theta  Gbus  Bbus n








derivative=v(i)*Gbus(i,i);
for k=1:n
derivative = derivative+v(k)*(Gbus(i,k)*cos(theta(i)-theta(k))+(Bbus(i,k))*sin(theta(i)-theta(k)));   %dpi/dVi
end






derivative = v(i)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j)));   %dpi/dVj
