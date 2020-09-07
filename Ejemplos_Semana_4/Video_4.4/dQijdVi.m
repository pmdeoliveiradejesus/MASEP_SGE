function [derivative] = dQijdVi(i,j)
global v theta  Gbus  Bbus
derivative = v(j)*(Gbus(i,j)*sin(theta(i)-theta(j))-(Bbus(i,j))*cos(theta(i)-theta(j)))+2*v(i)*(Bbus(i,j)-0);   %dpij/dVi
