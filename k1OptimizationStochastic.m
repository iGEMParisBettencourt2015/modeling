function [infos, mc0, dc0, averageNumber, k1Range, fermentationPeriod, k1Min, k1Max, k1Step] = k1OptimizationStochastic()
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Calcul the number of differenciated cells and vitamin with different k1 in a stochastic way.

% Start the parallel computing
if isempty(gcp('nocreate')) == 1
    fprintf('\nNo parallel pool detected. We will try to start one with the default configuration. Please wait.\n\n');
    parpool;
    if isempty(gcp('nocreate')) == 0
        fprintf('\nThe parallel pool has been successfully created. The program will start as soon as possible.\n\n');
        
    else
        fprintf('\nThe parallel pool can not start. Please delete the parfor loop and use a for loop instead.\n\n');
    end
else
    fprintf('\nA parallel pool has been detected. The program will start as soon as possible.\n\n');
end


newTic = tic;

% Random initial position
mc0 = 5;                    % initial number of mother cell
dc0 = 0;                    % initial number of differentiate cell
sizeMatCell = 100;          % cell box size
sizeMat = 250;              % real box size

% Non random initial position
imageName = 'igemImg.png';

% Rate constants
muT1 = 1;
sigmaT1 = 0.1;
muT2 = 1.0502;
sigmaT2 = 0.1;
muT3 = 2.1004;
sigmaT3 = 0.1;
k4 = 1;

% Fermentation period
fermentationPeriod = 5;

% Action
createFolder = 0;           % 1 : create a folder to save informations
showAnimation = 0;          % 1 : show the poulation animation (DANGER : long computation time and unuseful here)
plotGraph = 0;              % 1 : plot the results in graphs

% Folder name
folderName = 'Results';

% Simulation parameters
k1Min = 0;
k1Max = 1.5;
k1Step = 0.1;
averageNumber = 5;

% Use the random or non random initial position
input = [mc0,dc0,sizeMatCell,sizeMat];
% input = imageName;

constantRate = [muT1, sigmaT1, muT2, sigmaT2, muT3, sigmaT3, k4];
action = [createFolder,showAnimation,plotGraph];

k1Range = [k1Min:k1Step:k1Max];
arraySize = round((k1Max-k1Min)/k1Step)+1;

% Preallocate
dc = zeros(1,arraySize);
vitamin = zeros(1,arraySize);
averageDC = zeros(1,averageNumber);
averageVitamin = zeros(1,averageNumber);

% Loop for different k1
for k1 = k1Range
    
    index = find(k1Range == k1);
    constantRate(1) = log(2)/k1;
    k1
    
    % Loop for averaging
    parfor cAverage = 1:averageNumber
        data = timeEvolutionStochastic(input, constantRate, fermentationPeriod, action, folderName);
        averageDC(cAverage) = data.maxDC;
        averageVitamin(cAverage) = data.maxVitamin;
    end
    
    dc(index) = mean(averageDC);
    vitamin(index) = mean(averageVitamin);
    
end

maxDC = max(dc);
maxK1forMaxDC = k1Range(find(dc == maxDC, 1));
muTIDC = log(2)/maxK1forMaxDC;
maxVitamin = max(vitamin);
maxK1forMaxVitamin = k1Range(find(vitamin == maxVitamin, 1));
muTIVitamin = log(2)/maxK1forMaxVitamin;

figure;
hold on;
plot(k1Range,dc);
plot(k1Range,vitamin);
title(sprintf('Processed by stochastic algorithm. \n\n $MC_{0} = %d$ (cells) \n $DC_{0} = %d$ (cells) \n $Averaging$ $number = %d$ \n $Fermentation$ $period = %d$ (hours) \n\n Max $DC  = %d$ (cells) for $k_{1} = %4f$ (hours$^{-1}$) ie $\\mu_{1} = %4f$ (hours) \n Max $Vitamin  = %d$ (vitamins) for $k_{1} = %4f$ (hours$^{-1}$) ie $\\mu_{1} = %4f$ (hours)', mc0, dc0, averageNumber, fermentationPeriod, round(maxDC), maxK1forMaxDC, muTIDC, round(maxVitamin), maxK1forMaxVitamin, muTIVitamin), 'Interpreter', 'latex');
xlabel('$k_{1}$ (hours$^{-1}$)', 'Interpreter', 'latex');
ylabel('cells and vitamins number (a.u.)', 'Interpreter', 'latex');
thisLegend = legend('Number of $DC$', 'Number of $Vitamin$', 'Location', 'best');
set(thisLegend, 'Interpreter', 'latex');
axis([k1Min k1Max 0 inf]);
hold off;

infos(1,:) = dc;
infos(2,:) = vitamin;

toc(newTic)

end
