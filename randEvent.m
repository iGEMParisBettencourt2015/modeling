function [data] = randEvent(cellType, data, index)
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Generate the next random event.

time1 = 0;
time2 = 0;
time3 = 0;

if cellType == 1    % For a mother cell there is a competition between two events
    
    data.cTime1 = data.cTime1 + 1;
    data.cTime2 = data.cTime2 + 1;
    
    % Events time
    if data.cell.lastTime1(index)>0
        time1 = data.time1Array(data.cTime1)*(1 - (data.cell.lastTime2(index))/(2*data.cell.lastTime1(index)));
    else
        time1 = data.time1Array(data.cTime1);
    end
    
    if time1<0
                disp('shit');
        time1 = 0;
    end
    
    time2 = data.time2Array(data.cTime2);
    if time2<0
        time2 = 0;
    end
    
    % Competition between the two events
    if time1 < time2
        nextEvent = 1;
        timeEvent = time1;
    elseif time1 > time2
        nextEvent = 2;
        timeEvent = time2;
    end
    
elseif cellType == 2
    
    data.cTime3 = data.cTime3 + 1;

    % Event time
    % Last time parameters can be used to take into account
    % the fact that a differentiate cell have the duplication material
    % before the differentiation.
    
    if data.cell.lastTime2(index) >0
        time3 = data.time3Array(data.cTime3)*(1 - (data.cell.lastTime1(index))/(data.cell.lastTime2(index)));
    else
        time3 = data.time3Array(data.cTime3);
    end
    
    if time3<0
        time3 = 0;
    end
    
    nextEvent = 3;
    timeEvent = time3;
    
end

data.nextEvent = nextEvent;
data.timeNextEvent = timeEvent;

data.cell.lastTime1(index) = time1;
data.cell.lastTime2(index) = time2;

end
