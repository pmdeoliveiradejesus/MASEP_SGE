function [derivative] = dTidVk(i,k)
  
if i==k
derivative = 0;   %dVi/dTi
else
derivative = 0; %dVi/dTj
end
