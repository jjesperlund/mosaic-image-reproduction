
%% Create database

%createDatabase('/Users/jesperlund/Documents/SKOLA/?K4/TNM097 Bildreproduktion/database');
createDatabase('../database');

%% (Optional) Optimize the database
clc;
% Deletes one of the images if 2 images is closer in the CIELAB color space
% than a set threshold
threshold = 4;
optimizeDB('db_200_new_2.mat', threshold); 

%% Read image to reproduce
clc;
% Read and resize input image
image = imread('images/strykjarnet.jpg');

% Database images are 30x30 px
patch_size = 30;
[r, c, ~] = size(image);

% The mosaic input image must be dividable with patch size. Calculating
% margin which is used when resizing the image below.
margin_rows = rem(r,patch_size);
margin_cols = rem(c, patch_size);

% Number of mosaic patches per dimension
patches_y = r / patch_size;
patches_x = c / patch_size;

% Warn user if input image is too small
% (minimum patches/mosaic plates per dimension is 30)

if patches_x < 30 || patches_y < 30
    disp('Warning: The image is too small and will be magnified, which will affect the resulting image.');
    image_resized = imresize(image, [(r - margin_rows) * 3, (c - margin_cols) * 3]);
elseif patches_x > 120 || patches_y > 120
    disp('Warning: The image is large and will take a few moments to process.')
    image_resized = imresize(image, [r - margin_rows, c - margin_cols]);
else
    image_resized = imresize(image, [r - margin_rows, c - margin_cols]);  
end

% Create mosaic reproduction
tic
result = mosaic_reproduce2(image_resized, 'db_optimized_new_2.mat');
%result = imgaussfilt(result, 2);
toc

% Show reproduced mosaic image
%figure
%imshow(image_resized);
figure
imshow(result);
