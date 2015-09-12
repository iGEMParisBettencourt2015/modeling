function [ data ] = initialization( data )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Initialization of the programm.

% Get the matrix size
data = getSizeMat(data);

% Calcul all the time event distribution (is preloaded for fast calculus)
data = initTimeEvent( data );

% Create the first cells
data = initCells(data);

% Initialization of the output data
data.saveTime(data.counterEvent) = 0;
data.saveNbrMC(data.counterEvent) = data.mc0;
data.saveNbrDC(data.counterEvent) = data.dc0;
data.saveNbrVitamin(data.counterEvent) = 0;
data.folderName = sprintf('%s/%s',data.resultFolderName,datestr(datetime('now'), 'dd-mm-yyyy_HH-MM-SS-FFF'));
data.imgType = 'png';

data.parametersFileName = '';
data.parametersDoc = 0;

if data.createFolder == 1
    % Create a folder to save the results
    mkdir(data.folderName);
    % Open a file
    data.parametersFileName = 'parameters.txt';
    data.parametersDoc = fopen(sprintf('%s/%s',data.folderName,data.parametersFileName) , 'w');
    
end

% Write the informations
saveInitialParameters( data );

% Show and save the event time distribution
showAndSaveEventTimeDistribution( data );

% Create a new figure if the user want to show the animation
if data.showPopulationBool == 1
    animationFigure = figure;
end

% First animation
data = showPopulation(data);

end
