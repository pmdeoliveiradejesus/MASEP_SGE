function [derivative] = dVidVk(i,k)
  
if i==k
derivative = 1;   %dVi/dTi
else
derivative = 0; %dVi/dTj
end
