function [derivative] = dPijdTj(i,j)
global v theta  Gbus  Bbus
derivative = v(i)*v(j)*(Gbus(i,j)*sin(theta(i)-theta(j))-(Bbus(i,j))*cos(theta(i)-theta(j)));   %dpij/dthetaj
