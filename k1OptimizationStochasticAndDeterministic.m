function k1OptimizationStochasticAndDeterministic()
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Superimpose the deterministic and stochastic models.

newTic = tic;

% Danger : make sure that the parameters are the same in k1OptimizationStochastic and k1OptimizationDeterministic
infosDeterministic = k1OptimizationDeterministic();
dcDeterministic = infosDeterministic(1,:);
vitaminDeterministic = infosDeterministic(2,:);

[infosStochastic, mc0, dc0, averageNumber, k1Range, fermentationTime, k1Min, k1Max, k1Step] = k1OptimizationStochastic();
dc = infosStochastic(1,:);
vitamin = infosStochastic(2,:);

% Stochastic informations
maxDC = max(dc);
maxK1forMaxDC = k1Range(find(dc == maxDC, 1));
muTIDC = log(2)/maxK1forMaxDC;
maxVitamin = max(vitamin);
maxK1forMaxVitamin = k1Range(find(vitamin == maxVitamin, 1));
muTIVitamin = log(2)/maxK1forMaxVitamin;

% Deterministic informations
maxDCDeterministic = max(dcDeterministic);
maxK1forMaxDCDeterministic = k1Range(find(dcDeterministic == maxDCDeterministic, 1));
muTIDCDeterministic = log(2)/maxK1forMaxDCDeterministic;
maxVitaminDeterministic = max(vitaminDeterministic);
maxK1forMaxVitaminDeterministic = k1Range(find(vitaminDeterministic == maxVitaminDeterministic, 1));
muTIVitaminDeterministic = log(2)/maxK1forMaxVitaminDeterministic;

% Cross-correlation
xcorrDC = xcorr(dc, dcDeterministic);
xcorrVitamin = xcorr(vitamin, vitaminDeterministic);

% Correlation coefficient
correlationCoeffDC = corr2(dc,dcDeterministic);
correlationCoeffVitamin = corr2(vitamin,vitaminDeterministic);

% Cross-correlation
figure;
hold on;
plot(k1Range,dc);
plot(k1Range,dcDeterministic);
plot(k1Range,vitamin);
plot(k1Range,vitaminDeterministic);
title(sprintf('Processed by stochastic and deterministic algorithm. \n\n $MC_{0} = %d$ (cells)\n $DC_{0} = %d$ (cells) \n $Averaging$ $number = %d$ \n $Fermentation$ $period = %d$ (hours) \n\n Stochastic results \n Max $DC  = %d$ (cells) for $k_{1} = %4f$ (hours$^{-1}$) ie $\\mu_{1} = %4f$ (hours) \n Max $Vitamin  = %d$ (vitamins) for $k_{1} = %4f$ (hours$^{-1}$) ie $\\mu_{1} = %4f$ (hours) \n\n Deterministic results \n Max $DC  = %d$ for $k_{1} = %4f$ (hours$^{-1}$) ie $\\mu_{1} = %4f$ (hours) \n Max $Vitamin  = %d$ (vitamins) for $k_{1} = %4f$ (hours$^{-1}$) ie $\\mu_{1} = %4f$ (hours)', mc0, dc0, averageNumber, fermentationTime, round(maxDC), maxK1forMaxDC, muTIDC, round(maxVitamin), maxK1forMaxVitamin, muTIVitamin, round(maxDCDeterministic), maxK1forMaxDCDeterministic, muTIDCDeterministic, round(maxVitaminDeterministic), maxK1forMaxVitaminDeterministic, muTIVitaminDeterministic),'Interpreter','latex');
xlabel('$k_{1}$', 'Interpreter', 'latex');
ylabel('cells and vitamins number (a.u.)', 'Interpreter', 'latex');
thisLegend1 = legend('Number of $DC$ (Stochastic)', 'Number of $DC$ (Deterministic)',  'Number of $Vitamin$ (Stochastic)', 'Number of $Vitamin$ (Deterministic)', 'Location', 'best');
set(thisLegend1, 'Interpreter', 'latex');
axis([k1Min k1Max 0 inf]);
hold off;

% Correlation coefficient
figure;
hold on;
plot(xcorrDC);
plot(xcorrVitamin);
xlabel('$k_{1}''$ (hours$^{-1}$)', 'Interpreter', 'latex');
ylabel('$cross-correlation$ $coefficient$ (a.u.)', 'Interpreter', 'latex');
thisLegend2 = legend('$DC$ $cross-correlation$', '$Vitamin$ $cross-correlation$', 'Location', 'best');
set(thisLegend2, 'Interpreter', 'latex');
title(sprintf('Deterministic and stochastic cross-correlation. \n\n $DC$ $correlation$ $coefficient = %4f$ \n $Vitamin$ $correlation$ $coefficient = %4f$', correlationCoeffDC, correlationCoeffVitamin), 'Interpreter', 'latex');
hold off;

toc(newTic)

end
