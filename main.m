
%% Create database

%createDatabase('/Users/jesperlund/Documents/SKOLA/?K4/TNM097 Bildreproduktion/database');
createDatabase('../database');

%% Read image to reproduce

% Read and resize input image
image = imread('images/strykjarnet.jpg');
[rows cols channels] = size(image);
s = rows * cols;
image = imresize(image, 1000000/s, 'nearest');

%imshow(image)

result = mosaic_reproduce(image);

%imshow(result)

% The program should be independent of image size,
% scale input image if necessary