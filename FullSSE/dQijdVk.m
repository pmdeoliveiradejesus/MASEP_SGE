function [derivative] = dQijdVk(i,j,k)
global v theta  Gbus  Bbus su 

derivative =0;
if i==k
derivative = v(j)*(Gbus(i,j)*sin(theta(i)-theta(j))-(Bbus(i,j))*cos(theta(i)-theta(j)))+...
    2*v(i)*(Bbus(i,j)-imag(su(i,j)))*v(i)*v(i);%dQij/dVi
end
if j==k
derivative = v(i)*(Gbus(i,j)*sin(theta(i)-theta(j))-(Bbus(i,j))*cos(theta(i)-theta(j)));   %dQij/dVj
end

