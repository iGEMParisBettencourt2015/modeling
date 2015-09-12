function [ x ] = isPositiveInteger( y, strictPositiveInteger )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Check if a number is a positive integer (1) or not (0).

if strictPositiveInteger == 0
    x = (y>=0)&(mod(y,1)==0);
elseif strictPositiveInteger == 1
    x = (y>0)&(mod(y,1)==0);
else
    errorProgramm('false argument in the isPositiveInteger function.');
end

end
