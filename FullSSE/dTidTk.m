function [derivative] = dTidTk(i,k)
if i==k
derivative = 1;%dTi/dTi
else
derivative = 0; %dTi/dTj
end