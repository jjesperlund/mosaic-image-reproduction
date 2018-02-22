
%% Create database

%createDatabase('/Users/jesperlund/Documents/SKOLA/?K4/TNM097 Bildreproduktion/database');
createDatabase('../database');

%% (Optional) Optimize the database

% Deletes one of the images if 2 images is closer in the CIELAB color space
% than a set threshold
optimizeDB('db_200.mat');

%% Read image to reproduce
clc;
% Read and resize input image
image = imread('images/kangaroo.jpg');

[r, c, ~] = size(image);

% Warn user if input image is too small
if r < 128 || c < 128
    disp('Warning: The image is too small and will be magnified, which will affect the resulting image.');
end

%{
if r > c
  image_resized = imresize(image, (256/2) / r);
elseif c > r
  image_resized = imresize(image, (256/2) / c);
else
  image_resized = imresize(image, [(256/2), (256/2)]);
end
%}

if c == r
  image_resized = imresize(image, [1080, 1920]);
else
  image_resized = imresize(image, (1080) / r);
  image_resized = imresize(image, (1920) / c);
end

tic
result = mosaic_reproduce2(image_resized);
%result = imresize(result, [r, c]);
%result = imgaussfilt(result, 2);
toc

%figure
%imshow(image_resized);
figure
imshow(result);
