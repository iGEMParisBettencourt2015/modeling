function [data] = launchStochasticProgramm( )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Launch the stochastic time evoluation simulation.

newTic = tic;

% Random initial position
mc0 = 5;                    % initial number of mother cell
dc0 = 0;                    % initial number of differentiate cell
sizeMatCell = 100;          % cell box size
sizeMat = 250;              % real box size

% Non random initial position
imageName = 'igemImg.png';

% Rate constants
muT1 = 1.5;
sigmaT1 = 0.1;
muT2 = 1.0;
sigmaT2 = 0.1;
muT3 = 2.0;
sigmaT3 = 0.1;
k4 = 1;

% Fermentation period
fermentationPeriod = 10;

% Action
createFolder = 1;           % 1 : create a folder to save informations
showAnimation = 1;          % 1 : show the poulation animation (DANGER : long computation time)
plotGraph = 0;              % 1 : plot the results in graphs

% Folder name
folderName = 'Results';

% Use the random or non random initial position
% input = [mc0,dc0,sizeMatCell,sizeMat];
input = imageName;

constantRate = [muT1, sigmaT1, muT2, sigmaT2, muT3, sigmaT3, k4];
action = [createFolder,showAnimation,plotGraph];

data = timeEvolutionStochastic(input, constantRate, fermentationPeriod, action, folderName);

toc(newTic)

end
