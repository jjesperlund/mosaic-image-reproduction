
%% Create database

%createDatabase('/Users/jesperlund/Documents/SKOLA/?K4/TNM097 Bildreproduktion/database');
createDatabase('../database');

%% Read image to reproduce

% Read and resize input image
image = imread('images/strykjarnet.jpg');

[r, c, ~] = size(image);
if r > c
  image_resized = imresize(image, (256/2) / r);
elseif c > r
  image_resized = imresize(image, (256/2) / c);
else
  image_resized = imresize(image, [(256/2), (256/2)]);
end


tic
result = mosaic_reproduce(image_resized);
result = imresize(result, [r, c]);
result = imgaussfilt(result, 2);
toc
figure
imshow(image);
figure
imshow(result);

% The program should be independent of image size,
% scale input image if necessary