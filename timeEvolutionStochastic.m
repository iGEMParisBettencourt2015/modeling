function [data] = timeEvolutionStochastic(input, constantRate, simulationTime, action, folderName)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Main function to calcul the time evolution using a stochastic algorithm.

data.mainTic = tic;

% Initiate the programm
data = checkInput(input, constantRate, simulationTime, action, folderName, data);
data = initVariables(input, constantRate, simulationTime, action, folderName, data);
data = initialization(data);


% Continue the simulation during all the fermentation period
while data.time < data.simulationTime
    
    data.counterEvent = data.counterEvent + 1;

    % Initialisation
    newPositionX = 0;
    newPositionY = 0;
    ordre = 0;
    nbrCells = size(data.cell.type,2);

    % Choose the next event
    nextTimeEventCell = min(data.cell.timeEvent);
    
    % Showing the population animation is consider as an event
    if data.showPopulationBool == 1
        nextTimeEvent = min(data.timerShow, nextTimeEventCell);
    else
        nextTimeEvent = nextTimeEventCell;
    end
    
    % Modified the next event time
    data.cell.timeEvent = data.cell.timeEvent - nextTimeEvent;
    
    % If the next event concern a cell (and not an animation)
    if nextTimeEvent == nextTimeEventCell
        
        % Find the index of the next event to do
        indexNextEvent = find(min(data.cell.timeEvent) == data.cell.timeEvent);
        typeNextEvent = data.cell.nextEvent(indexNextEvent);
        
        % Do an action with the concerned cell
        if typeNextEvent == 1

            % A mother cell become a differenciate cell
            data = makeCells( 2, data, 0, 0, data.cell.ordre(indexNextEvent), indexNextEvent);
            
        elseif typeNextEvent == 2
            
            % Add a mother cell
            if data.showPopulationBool == 1
                [newPositionX, newPositionY, ordre] = randPosition(indexNextEvent, data);
            end
            data.cell.lastTime1(nbrCells+1) = 0;
            data.cell.lastTime2(nbrCells+1) = 0;
            data = makeCells( 1, data, newPositionX, newPositionY, 1, nbrCells+1);
            
            % New events for the ancient mother cell
            data = makeCells( 1, data, 0, 0, ordre, indexNextEvent);
            
        elseif typeNextEvent == 3
            
            % Add a differenciate cell
            if data.showPopulationBool == 1
                [newPositionX, newPositionY, ordre] = randPosition(indexNextEvent, data);
            end
            data.cell.lastTime1(nbrCells+1) = 0;
            data.cell.lastTime2(nbrCells+1) = 0;
            data = makeCells( 2, data, newPositionX, newPositionY, 1, nbrCells+1);
            
            % New events for the ancient differentiate cell
            data = makeCells( 2, data, 0, 0, ordre, indexNextEvent);
            
        end
        
        % Update the timer for the animation
        if data.showPopulationBool == 1
            data.timerShow = data.timerShow - nextTimeEvent;
        end
        
    else % If the next event is the animation
        
        % Set the data.timerShow with is default value
        data.timerShow = data.timeShowPopulation;
        data = showPopulation(data);
        
    end
    
    nbrMC = sum(data.cell.type == 1);
    nbrDC = sum(data.cell.type == 2);
    
    % Numerical integration to obtain the vitamin number
    data.cVitamin = data.cVitamin + data.k4*nbrDC*nextTimeEvent;
    
    % Update the simulation time
    data.time = data.time + nextTimeEvent;
    
    % Save the evolution data
    data.saveTime(data.counterEvent) = data.time;
    data.saveNbrMC(data.counterEvent) = nbrMC;
    data.saveNbrDC(data.counterEvent) = nbrDC;
    saveNbrEvent(data.counterEvent) = data.counterEvent;
    data.saveNbrVitamin(data.counterEvent) = data.cVitamin;
    
end

data = showPopulation(data);
data = saveResult(data);

end
