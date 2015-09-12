function [ x, y, cOrdre] = randPosition(indexNextEvent, data)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Find a free position for a cell.

% Initialization
cOrdre = 0;
listeEmplacementLibresX = [];

% Initial cell position
initX = data.cell.positionX(indexNextEvent);
initY = data.cell.positionY(indexNextEvent);
initOrdre = data.cell.ordre(indexNextEvent);

% Do the free pixels list
[ listeEmplacementLibresX, listeEmplacementLibresY, cOrdre ] = freePosition(initX, initY, data.sizeMat, initOrdre, data);

% Choose a random position in the free pixels list
nbrElmListe = size(listeEmplacementLibresX,2);
randNbr = round(1 + (nbrElmListe-1)*rand(1));

x = listeEmplacementLibresX(randNbr);
y = listeEmplacementLibresY(randNbr);

end
