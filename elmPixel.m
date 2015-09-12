function [ x, y ] = elmPixel( initX, initY, cOrdre, cElm )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Find the coordinates of a pixel around an other pixel.

x = 0;
y = 0;

if (cElm >= 1 && cElm <= (2*cOrdre + 1))
    x = initX + (cElm - (cOrdre+1));
    y = initY + cOrdre;
elseif (cElm > (2*cOrdre + 1) && cElm <= (4*cOrdre + 1))
    x = initX + cOrdre;
    y = initY - (cElm - cOrdre - (2*cOrdre + 1));
elseif (cElm > (4*cOrdre + 1) && cElm <= (6*cOrdre + 1))
    x = initX - (cElm - cOrdre - (4*cOrdre + 1));
    y = initY - cOrdre;
elseif (cElm > (6*cOrdre + 1) && cElm < (8*cOrdre + 1))
    x = initX - cOrdre;
    y = initY + (cElm - cOrdre - (6*cOrdre + 1));
end

end
