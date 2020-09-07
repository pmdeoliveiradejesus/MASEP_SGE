function [derivative] = dPijdVj(i,j)
global v theta  Gbus  Bbus
derivative = v(i)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j)));   %dpij/dVj
