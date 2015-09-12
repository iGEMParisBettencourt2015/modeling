function [data] = checkInput(input, constantRate, simulationTime, action, folderName, data)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Check the input and show an error message if the input is not good.

% Check the input
if (size(input,2) == 4)
    
    data.mc0 = input(1);
    data.dc0 = input(2);
    sizeMatCell = input(3);
    sizeMat = input(4);
    
    if(sizeMatCell > sizeMat)
        errorProgramm('the cells distribution size is larger than the box size !');
    elseif isPositiveInteger(data.mc0, 0) == 0
        errorProgramm('the initial mother cells concentration is not a positive integer !');
    elseif isPositiveInteger(data.dc0, 0) == 0
        errorProgramm('the initial differentiate cells concentration is not a positive integer !');
    elseif isPositiveInteger(sizeMatCell, 1) == 0
        errorProgramm('the cell distribution size is not a strictly positive integer !');
    elseif isPositiveInteger(sizeMat, 1) == 0
        errorProgramm('the box size is not a strictly positive integer !');
    elseif (data.mc0==0 && data.dc0 ==0)
        errorProgramm('you must have at least one cell !');
    end
    
    
elseif isstr(input) == 1
    
    matrixImage = imageToMatrix(input);
    listOfMC = find(matrixImage == 1);
    listOfDC = find(matrixImage == 2);
    data.mc0 = size(listOfMC, 1);
    data.dc0 = size(listOfDC, 1);
    
    if(size(matrixImage,2) ~= size(matrixImage,1))
        errorProgramm('the input image is not a square !');
    elseif (data.mc0==0 && data.dc0 ==0)
        errorProgramm('you must have at least one cell, the input image is not correctly defined !');
    end
    
else
    errorProgramm('the input array is not correctly defined !');
end

% Check the fermentation period
if isPositiveInteger(simulationTime, 1) == 0
    errorProgramm('the simulation time is not a positive integer !');
end

% Check the action
if (size(action,2) ~= 3)
    errorProgramm('the action array is not correctly defined !');
elseif isBinary(action(1)) == 0
    errorProgramm('the first action array variable is not a boolean !');
elseif isBinary(action(2)) == 0
    errorProgramm('the second action array variable is not a boolean !');
elseif isBinary(action(3)) == 0
    errorProgramm('the third action array variable is not a boolean !');
end

% Check the rate constants
if (size(constantRate,2) ~= 7)
    errorProgramm('the constant rate array is not correctly defined !');
end

% Check the folder name
if (isstr(folderName)==0 && action(1)==1 )
    errorProgramm('the folder name is not correctly defined !');
end

end
