function timeEvolutionDeterministic(simulationTime)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Show the time evolution by numerical calculus and equations.

close all;
tic

timeStep = 0.01;

k1 = 0.207;
k2 = 0.66;
k3 = 0.33;
k4 = 1;
mc0 = 5;
dc0 = 0;

timeRange = 0:timeStep:simulationTime;
arraySize = round(simulationTime/timeStep)+1;

% preallocation
timeMC = zeros(1,arraySize);
timeDC = zeros(1,arraySize);
timeVitamin = zeros(1,arraySize);

timeMC = mc0*exp((k2-k1)*timeRange);

if k1 ~= k2-k3
    timeDC = dc0*exp(k3*timeRange) + mc0*(k1/(k2-k1-k3))*(exp((k2-k1)*timeRange)-exp(k3*timeRange));
    timeVitamin = dc0*(k4/k3)*(exp(k3*timeRange)-1) + mc0*((k4*k1)/((k2-k1-k3)*(k2-k1)))*(exp((k2-k1)*timeRange)-1) + mc0*((k4*k1)/((k2-k1-k3)*k3))*(1-exp(k3*timeRange));
else
    timeDC = (mc0*(k2-k3)*timeRange + dc0).*exp(k3*timeRange);
    timeVitamin = dc0*(k4/k3)*(exp(k3*timeRange)-1) + mc0*(k4/k3)*(k3*timeRange-1)*((k2/k3)-1).*exp(k3*timeRange) + mc0*(k4/k3)*((k2/k3)-1);
end

maxDC = round(max(timeDC));
maxMC = round(max(timeMC));
maxVitamin = round(max(timeVitamin));

figure;
hold on;
plot(timeRange,timeMC);
plot(timeRange,timeDC);
plot(timeRange,timeVitamin);
title(sprintf('Processed by equations. \n\n $MC_{0} = %d$ (cells) \n $DC_{0} = %d$ (cells) \n $Fermentation$ $period = %d$ (hours) \n $k_{1} = %4f$ (hours$^{-1}$) \n $k_{2} = %4f$ (hours$^{-1}$) \n $k_{3} = %4f$ (hours$^{-1}$) \n $k_{4} = %4f$ (hours$^{-1}$) \n\n Max $MC = %d$ (cells) \n Max $DC  = %d$ (cells) \n Max $Vitamin  = %d$ (vitamins)', mc0, dc0, simulationTime, k1, k2, k3, k4, maxMC, maxDC, maxVitamin), 'Interpreter', 'latex');
thisLegend = legend('$MC$ number', '$DC$ number', '$Vitamin$ number', 'Location', 'best');
set(thisLegend, 'Interpreter', 'latex');
xlabel('time (hours)', 'Interpreter', 'latex');
ylabel('cells and vitamins number (a.u.)', 'Interpreter', 'latex');
axis([0 simulationTime 0 inf]);
hold off;

toc

end
