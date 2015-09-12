function [data] = saveResult(data)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Save and plot the results.

data.maxMC = round(max(data.saveNbrMC));
data.maxDC = round(max(data.saveNbrDC));
data.maxVitamin = round(max(data.saveNbrVitamin));

data.timeSpent = toc(data.mainTic);

if data.plotGraph == 1
    
    imgTitle = sprintf('Processed by stochastic algorithm. \n\n $Computation$ $time = %4f$ (seconds) \n\n $Fermentation$ $period = %4f$ (hours) \n $MC_{0} = %d$ (cells) \n $DC_{0} = %d$ (cells) \n $\\mu_{1} = %4f$ (hours) - $\\sigma_{1} = %4f$ (hours) \n $\\mu_{2} = %4f$ (hours) - $\\sigma_{2} = %4f$ (hours) \n $\\mu_{3} = %4f$ (hours) - $\\sigma_{3} = %4f$ (hours) \n $k_{4} = %d$ (hours$^{-1}$)\n\n Max $MC = %d$ (cells)\n Max $DC = %d$ (cells)\n Max $Vitamin = %d$ (vitamins)', data.timeSpent, data.time, data.mc0, data.dc0, data.muT1, data.sigmaT1, data.muT2, data.sigmaT2, data.muT3, data.sigmaT3, data.k4, data.maxMC, data.maxDC, data.maxVitamin);
    finalFigure = figure;
    hold on;
    plot(data.saveTime, data.saveNbrMC);
    plot(data.saveTime, data.saveNbrDC);
    plot(data.saveTime, data.saveNbrVitamin);
    title(imgTitle, 'Interpreter', 'latex');
    thisLegend = legend('Number of $MC$', 'Number of $DC$', 'Number of $Vitamin$', 'Location', 'best');
    set(thisLegend, 'Interpreter', 'latex');
    xlabel('time (hours)', 'Interpreter', 'latex');
    ylabel('cells and vitamins number (a.u.)', 'Interpreter', 'latex');
    axis([0 inf 0 inf]);
    hold off;
    
    if data.createFolder == 1
        saveas(finalFigure,sprintf('%s/result.%s',data.folderName,data.imgType));
    end
    
end


if data.createFolder == 1
    
    writeParameters(data, '\n\n');
    writeParameters(data, 'SIMULATION RESULTS');    
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Final number of mother cells : %d', data.maxMC));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Final number of differenciate cells : %d', data.maxDC));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Final number of vitamin : %d', data.maxVitamin));
    writeParameters(data, '\n\n');
    writeParameters(data, sprintf('Execution time (in seconds) : %4f', data.timeSpent));
    writeParameters(data, '\n');
    
    fclose(data.parametersDoc);
    
    dataFileName = sprintf('%s/data.mat',data.folderName);
    save(dataFileName, 'data');
    
end

end
