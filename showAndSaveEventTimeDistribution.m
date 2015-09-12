function showAndSaveEventTimeDistribution( data )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Show and save the event time probability distribution.

if data.plotGraph == 1
    timeDistributionFigure = figure;
    hold on;
    x1 = 0:data.pasDistributionTimeEvent:2*data.muT1;
    y1 = normpdf(x1,data.muT1,data.sigmaT1);
    plot(x1, y1);
    x2 = 0:data.pasDistributionTimeEvent:2*data.muT2;
    y2 = normpdf(x2,data.muT2,data.sigmaT2);
    plot(x2, y2);
    x3 = 0:data.pasDistributionTimeEvent:2*data.muT3;
    y3 = normpdf(x3,data.muT3,data.sigmaT3);
    plot(x3, y3);
    title(sprintf('Distribution of event time probability. \n\n $\\mu_{1} = %4f$ (hours) - $\\sigma_{1} = %4f$ (hours) \n $\\mu_{2} = %4f$ (hours) - $\\sigma_{2} = %4f$ (hours) \n $\\mu_{3} = %4f$ (hours) - $\\sigma_{3} = %4f$ (hours) \n $k_{4} = %4f$ (hours$^{-1}$)', data.muT1, data.sigmaT1, data.muT2, data.sigmaT2, data.muT3, data.sigmaT3, data.k4), 'Interpreter', 'latex');
    thisLegend = legend('$MC \rightarrow DC$', '$MC \rightarrow 2.MC$', '$DC \rightarrow 2.DC$', 'Location', 'best');
    set(thisLegend, 'Interpreter', 'latex');
    xlabel('time (hours)', 'Interpreter', 'latex');
    ylabel('time probability (hours$^{-1}$)', 'Interpreter', 'latex');
    axis([0 inf 0 inf]);
    
    if data.createFolder == 1
        saveas(timeDistributionFigure,sprintf('%s/eventTimeDistribution.%s',data.folderName,data.imgType));
    end
    
end

end
