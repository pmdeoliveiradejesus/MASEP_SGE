function [calc] = Qi(i)
global v theta  Gbus  Bbus n
calc =0;
for k=1:n
calc=calc+v(i)*v(k)*(Gbus(i,k)*sin(theta(i)-theta(k))-Bbus(i,k)*cos(theta(i)-theta(k)));
end