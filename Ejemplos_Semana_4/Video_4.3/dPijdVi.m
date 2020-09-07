function [derivative] = dPijdVi(i,j)
global v theta  Gbus  Bbus
derivative = v(j)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j)))-2*Gbus(i,j)*v(i);   %dpij/dVi
