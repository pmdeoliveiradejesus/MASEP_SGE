function [calc] = PFij(i,j)
global v theta  Gbus  Bbus
% i
% j
% v(i)
% v(j)
% theta(i)
% theta(j)
% Gbus(i,j)
% Bbus(i,j)
% pause
calc = (v(i)^2*-Gbus(i,j)-v(i)*v(j)*(-Gbus(i,j)*cos(theta(i)-theta(j))+-Bbus(i,j)*sin(theta(i)-theta(j))));


