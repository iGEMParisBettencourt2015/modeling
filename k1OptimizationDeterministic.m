function [infos] = k1OptimizationDeterministic()
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Calcul the number of differenciated cells with differents k1 in a deterministic way.


tic

simulationTime = 5;

k2 = log(2)/1.0502;              % 1/temps
k3 = log(2)/2.1004;              % 1/temps
k4 = 1;                 % 1/temps
timeStep = 1;
mc0 = 5;              % number of non differenciated cells
dc0 = 0;              % number of non differenciated cells

k1Min = 0;              % 1/temps
k1Max = 1.5;             % 1/temps
k1Step = 0.1;         % time step

k1Range = [k1Min:k1Step:k1Max];             % k1 variation between k1Min and k1Max
arraySize = round((k1Max-k1Min)/k1Step)+1;
dc = zeros(1,arraySize);                    % preallocate memory
vitamin = zeros(1,arraySize);               % preallocate memory

% loop ifor k1 (not vectorized)
for k1 = k1Range
    
    index = find(k1Range == k1);
    
    % dc and vitamin
    if k1 ~= k2-k3
        dc(index) = dc0*exp(k3*simulationTime) + mc0*(k1/(k2-k1-k3))*(exp((k2-k1)*simulationTime)-exp(k3*simulationTime));
        vitamin(index) = dc0*(k4/k3)*(exp(k3*simulationTime)-1) + mc0*((k4*k1)/((k2-k1-k3)*(k2-k1)))*(exp((k2-k1)*simulationTime)-1) + mc0*((k4*k1)/((k2-k1-k3)*k3))*(1-exp(k3*simulationTime));
    else
        dc(index) = (mc0*(k2-k3)*simulationTime + dc0)*exp(k3*simulationTime);
        vitamin(index) = dc0*(k4/k3)*(exp(k3*simulationTime)-1) + mc0*(k4/k3)*(k3*simulationTime-1)*((k2/k3)-1)*exp(k3*simulationTime) + mc0*(k4/k3)*((k2/k3)-1);
    end
        
end

maxDC = max(dc);
maxK1forMaxDC = k1Range(find(dc == maxDC, 1));
maxVitamin = max(vitamin);
maxK1forMaxVitamin = k1Range(find(vitamin == maxVitamin, 1));

figure;
hold on;
plot(k1Range,dc);
plot(k1Range,vitamin);
title(sprintf('Processed by deterministic algorithm. \n\n $MC_{0} = %d$ (cells) \n $DC_{0} = %d$ (cells) \n $k_{2} = %4f$ (hours$^{-1}$) \n $k_{3} = %4f$ (hours$^{-1}$) \n $k_{4} = %4f$ (hours$^{-1}$) \n $Fermentation$ $period = %d$ (hours) \n\n Max $DC = %d$ for $k_{1} = %4f$ (hours$^{-1}$) \n Max $Vitamin  = %d$ for $k_{1} = %4f$ (hours$^{-1}$)', mc0, dc0, k2, k3, k4, simulationTime, round(maxDC), maxK1forMaxDC, round(maxVitamin), maxK1forMaxVitamin), 'Interpreter', 'latex');
xlabel('$k_{1}$ (hours$^{-1}$)', 'Interpreter', 'latex');
ylabel('cells and vitamins number (a.u.)', 'Interpreter', 'latex');
thisLegend = legend('Number of $DC$', 'Number of $Vitamin$', 'Location', 'best');
set(thisLegend, 'Interpreter', 'latex');
axis([k1Min k1Max 0 inf]);
hold off;

toc

infos(1,:) = dc;
infos(2,:) = vitamin;

end

