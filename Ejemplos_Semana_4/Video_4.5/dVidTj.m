function [derivative] = dVidTk(i,k)
derivative = 0;   %dVi/dTj
if i==k
derivative = 0;   %dVi/dTi
end