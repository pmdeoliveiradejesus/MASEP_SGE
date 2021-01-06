function [derivative] = dQijdTk(i,j,k)
global v theta  Gbus  Bbus
derivative =0;
if i==k
derivative = v(i)*v(j)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j))); %dqij/dthetai
end
if j==k
derivative = -v(i)*v(j)*(Gbus(i,j)*cos(theta(i)-theta(j))+(Bbus(i,j))*sin(theta(i)-theta(j)));   %dqij/dthetaj
end

