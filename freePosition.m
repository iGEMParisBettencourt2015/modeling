function [ listeEmplacementLibresX, listeEmplacementLibresY, cOrdre ] = freePosition(initX, initY, sizeMat, initOrdre, data)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Create a list of free pixels around one pixel.

positionOk = 0;
cOrdre = initOrdre - 1;
pixelNotFree = 0;
listeEmplacementLibresX = [];
listeEmplacementLibresY = [];

while size(listeEmplacementLibresX,2) == 0
    
    cOrdre = cOrdre + 1;
    nbrVoisins = 8*cOrdre;
    
    for cElm = 1:nbrVoisins
        
        pixelNotFree = 0;
        
        % Find the pixel
        [x, y] = elmPixel( initX, initY, cOrdre, cElm );
        
        % Verify if the pixel is free
        if data.cellMatrix(y,x) > 0
            pixelNotFree = 1;
        end
        
        % If there is no one, we save the position
        if (pixelNotFree == 0 && x > 0 && x <= sizeMat && y > 0 && y <= sizeMat)
            listeEmplacementLibresX(size(listeEmplacementLibresX,2)+1) = x;
            listeEmplacementLibresY(size(listeEmplacementLibresY,2)+1) = y;
        end
        
    end
    
end

end
