function [calc] = QFij(i,j)
global v theta  Gbus  Bbus su
calc = (-v(i)^2*(-Bbus(i,j)+imag(su(i,j)))-...
v(i)*v(j)*(-Gbus(i,j)*sin(theta(i)-theta(j))-(-Bbus(i,j))*cos(theta(i)-theta(j))));

