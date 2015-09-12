function [ matrix ] = imageToMatrix( linkImage )
% By Constant Bourdeloux - IGEM Paris-Bettencourt 2015
% Convert an image into a matrix.

% 255 --> 0 (no cell)
% 0 --> 1   (mother cell)
% 128 --> 2 (differenciated cell)

% Import the image
matrixImage = imread(linkImage); % XxYx3 --> 3 because R,G and B
matrix = matrixImage(:,:,1);     % 255 and 0 matrix (red matrix)

% Preallocate matrix
matrixMC = zeros(size(matrix, 1), size(matrix, 2));
matrixDC = zeros(size(matrix, 1), size(matrix, 2));

% Create the matrix
matrixMC(matrix == 0) = 1;
matrixDC(matrix == 128) = 2;

% Final matrix
matrix = matrixMC + matrixDC;

end
