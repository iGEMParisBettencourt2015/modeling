function saveInitialParameters( data )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Save the initial parameters in a text file.

if data.createFolder == 1
    writeParameters(data, 'SIMULATION PARAMETERS');
    writeParameters(data, '\n');
    writeParameters(data, 'Software by Constant Bourdeloux - ESPCI ParisTech - IGEM Paris-Bettencourt - 2015');
    
    writeParameters(data, '\n\n');
    writeParameters(data, 'GENERAL');
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Date : %s', datestr(datetime('now'))));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Computer name : %s', getComputerName()));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Folder : %s', data.folderName));
    
    writeParameters(data, '\n\n');
    writeParameters(data, 'SIMULATION INITIALIZATION');
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Initial number of mother cells : %d', data.mc0));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Initial number of differenciate cells : %d', data.dc0));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Fermentation time : %4f', data.simulationTime));
    
    writeParameters(data, '\n\n');
    writeParameters(data, 'RATE CONSTANTS');
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Mu T1 : %4f', data.muT1));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Sigma T1 : %4f', data.sigmaT1));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Mu T2 : %4f', data.muT2));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Sigma T2 : %4f', data.sigmaT2));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Mu T3 : %4f', data.muT3));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Sigma T3 : %4f', data.sigmaT3));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('k4 : %4f', data.k4));
    
    writeParameters(data, '\n\n');
    writeParameters(data, 'GRAPHS AND POPULATION ANIMATION');
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Time event probability distribution graph pitch : %4f', data.pasDistributionTimeEvent));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Population animation frame rate : %4f', data.frameRate));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Simulation time between two animations : %4f', data.timeShowPopulation));
    
    writeParameters(data, '\n\n');
    writeParameters(data, 'ACTION');
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Create a folder : %d', data.createFolder));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Show the population animation  : %d', data.showPopulationBool ));
    writeParameters(data, '\n');
    writeParameters(data, sprintf('Plot the graphs : %d', data.plotGraph));
    
end

end
