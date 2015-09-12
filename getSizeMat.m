function [ data ] = getSizeMat(data)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Find the matrice size.

if(size(data.input,2) == 4 )
    
    sizeMat = data.input(4);
    
elseif isstr(data.input) == 1
    
    matrixImage = imageToMatrix(data.input);
    sizeMat = size(matrixImage,2);
    
end

data.sizeMat = sizeMat;

end
