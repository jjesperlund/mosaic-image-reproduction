
%% Create database

%createDatabase('/Users/jesperlund/Documents/SKOLA/?K4/TNM097 Bildreproduktion/database');
createDatabase('../database');

%% Read image to reproduce

% Read and resize input image
image = imread('images/strykjarnet.jpg');

[r, c, ~] = size(image);

% Warn user if input image is too small
if r < 128 || c < 128
    disp('Warning: The image is too small and will be magnified, which will affect the resulting image.');
end

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
