function [data] = showPopulation( data )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Show the cells matrix.

if data.showPopulationBool == 1
    
    nbrCells = size(data.cell.type,2);
    matrix = zeros(data.sizeMat, data.sizeMat);
    
    for cCell = 1:nbrCells
        
        if data.cell.type(cCell) == 1
            matrix(data.cell.positionY(cCell), data.cell.positionX(cCell)) = 1;
        elseif data.cell.type(cCell) == 2
            matrix(data.cell.positionY(cCell), data.cell.positionX(cCell)) = 2;
        end
        
    end
    
    data.cellMatrix = matrix;
    
    % Show the population evolution
    if(data.frameRate ~= 0)
        
        imagesc(matrix);
        title(sprintf('Population evolution. \n\n $Fermentation$ $period = %4f$ (hours)', data.time), 'Interpreter', 'latex');
        pause(data.frameRate);
        
    end
    
    % Save the images
    if data.createFolder == 1
        
        m8 = uint8(matrix);
        rgbImage = ind2rgb(m8, lines);
        imageName = sprintf('%s/%4f.%s',data.folderName,data.time,data.imgType);
        imwrite(rgbImage, imageName, data.imgType);
        
    end
    
end

end
