function [ data ] = initVariables( input, constantRate, simulationTime, action, folderName, data)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Variables initialization.

% These values can be changed
data.pasDistributionTimeEvent = 0.01;   % resolution for the graph time event distribution plot
data.frameRate = 0.01;                  % population animation framerate
data.timeShowPopulation = 0.1;          % simulation time between two animations (unit : 1/constant rate)

% These values should not be changed
data.simulationTime = simulationTime;
data.resultFolderName = folderName;

data.muT1 = constantRate(1);             % (1) : mc --> dc
data.sigmaT1 = constantRate(2);
data.muT2 = constantRate(3);             % (2) : mc --> 2*mc
data.sigmaT2 = constantRate(4);
data.muT3 = constantRate(5);             % (3) : dc --> 2*dc
data.sigmaT3 = constantRate(6);
data.k4 = constantRate(7);               % (4) : dc --> dc + vitamin

data.cVitamin = 0;
data.time = 0;

data.createFolder = action(1);
data.showPopulationBool = action(2);
data.plotGraph = action(3);
data.input = input;

data.cTime1 = 1;
data.cTime2 = 1;
data.cTime3 = 1;
data.counterEvent = 1;
data.timerShow = 0;

end
