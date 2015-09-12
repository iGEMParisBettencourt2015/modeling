function [ data ] = makeCells( type, data, positionX, positionY, ordre, index)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Make the cells.

nbrCells = size(data.cell.type,2);

data = randEvent(type, data, index);
data.cell.type(index) = type;
data.cell.nextEvent(index) = data.nextEvent;
data.cell.timeEvent(index) = data.timeNextEvent;

if(positionX ~= 0 && positionY ~=0)
    data.cell.positionX(index) = positionX;
    data.cell.positionY(index) = positionY;
end

data.cell.ordre(index) = ordre;

end
