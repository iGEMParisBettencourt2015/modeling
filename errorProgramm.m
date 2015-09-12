function errorProgramm( message )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Display an error and stop the programm.

fprintf('\n');
fprintf('__________________________________________________________________');
fprintf('\n');
fprintf('\n');

fprintf(sprintf('Error : %s', message));

fprintf('\n');
fprintf('__________________________________________________________________');
fprintf('\n');
fprintf('\n');

error(sprintf('Error : %s', message));

end
