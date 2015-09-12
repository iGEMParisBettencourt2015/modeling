function writeParameters( data, infoString )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Write a text file with the parameters.

if data.createFolder == 1
    fprintf(data.parametersDoc, infoString);
end

end
