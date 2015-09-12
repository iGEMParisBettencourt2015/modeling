function [ data ] = initTimeEvent( data )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Calcul the different time (vectorized) ~ preallocation.

nbrCellMax = data.sizeMat*data.sizeMat;

% Preallocate
data.time1Array = zeros(1,nbrCellMax);
data.time2Array = zeros(1,nbrCellMax);
data.time3Array = zeros(1,nbrCellMax);

% Vectorized calculus of even time distribution
data.time1Array = normrnd(data.muT1, data.sigmaT1, [1,nbrCellMax]);
data.time2Array = normrnd(data.muT2, data.sigmaT2, [1,nbrCellMax]);
data.time3Array = normrnd(data.muT3, data.sigmaT3, [1,nbrCellMax]);
end
