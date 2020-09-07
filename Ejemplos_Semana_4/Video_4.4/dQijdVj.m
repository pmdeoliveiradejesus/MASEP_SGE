function [derivative] = dQijdVj(i,j)
global v theta  Gbus  Bbus
derivative = v(i)*(Gbus(i,j)*sin(theta(i)-theta(j))-(Bbus(i,j))*cos(theta(i)-theta(j)));   %dpij/dthetaj
