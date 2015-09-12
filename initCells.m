function [ data ] = initCells( data )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Initialization of the cells.

% initialization
data.cell.type = [];

% Random initial position or not
if(size(data.input,2) == 4 )
    
    data.mc0 = data.input(1);
    data.dc0 = data.input(2);
    data.sizeMatCell = data.input(3);
    data.sizeMat = data.input(4);
    marginSpace = round((data.sizeMat - data.sizeMatCell)/2);
    
    % Mother cell initialization
    for cInitMC = 1:data.mc0
        data.cell.lastTime1(cInitMC) = 0;
        data.cell.lastTime2(cInitMC) = 0;
        data = makeCells(1, data, marginSpace + round(data.sizeMatCell*rand(1)), marginSpace + round(data.sizeMatCell*rand(1)), 1, size(data.cell.type,2)+1);
    end
    
    % Differentiate cell initialization
    for cInitDC = 1:data.dc0
        data.cell.lastTime1(cInitDC+data.mc0) = 0;
        data.cell.lastTime2(cInitDC+data.mc0) = 0;
        data = makeCells(2, data, marginSpace + round(data.sizeMatCell*rand(1)), marginSpace + round(data.sizeMatCell*rand(1)), 1, size(data.cell.type,2)+1);
    end
    
elseif isstr(data.input) == 1
    
    matrixImage = transpose(imageToMatrix(data.input));
    matrixSize = size(matrixImage,2);
    
    listOfMC = find(matrixImage == 1);
    listOfDC = find(matrixImage == 2);
    
    data.mc0 = size(listOfMC, 1);
    data.dc0 = size(listOfDC, 1);
    data.sizeMatCell = matrixSize;
    data.sizeMat = matrixSize;
    marginSpace = 0;
    
    % Mother cell initialization
    for cInitMC = 1:data.mc0
        [x, y] = ind2sub(matrixSize,listOfMC(cInitMC));
        data.cell.lastTime1(cInitMC) = 0;
        data.cell.lastTime2(cInitMC) = 0;
        data = makeCells(1, data, x, y, 1, cInitMC);
    end
    
    % Differentiate cell initialization
    for cInitDC = 1:data.dc0
        [x, y] = ind2sub(matrixSize,listOfDC(cInitDC));
        data.cell.lastTime1(cInitDC+data.mc0) = 0;
        data.cell.lastTime2(cInitDC+data.mc0) = 0;
        data = makeCells(2, data, x, y, 1, cInitDC + data.mc0);
    end
    
end

end
