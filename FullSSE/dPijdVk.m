function [derivative] = dPijdVk(i,j,k)
global v theta  Gbus  Bbus
derivative =0;
if i==k
derivative = v(j)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j)))-2*Gbus(i,j)*v(i);   %dpij/dVi
end
if j==k
derivative = v(i)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j)));   %dpij/dVj
%derivative = v(i)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j)));   %dpij/dVj
end