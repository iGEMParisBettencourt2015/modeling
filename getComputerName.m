function [ name ] = getComputerName()
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Get the computer name.

[status, name] = system('hostname');
name = strrep(name, sprintf('\n'), '');
end
