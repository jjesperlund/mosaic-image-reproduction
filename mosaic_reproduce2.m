function [ reproduced_image ] = mosaic_reproduce2( image )

    load('db_200.mat')

    [rows cols channels] = size(image);
    image = rgb2lab(image);
    a = db{1,1};
    reproduced_image = zeros(rows, cols, channels);
    stepSize = size(db{1,1}, 1);
    
    % L,a,b mean of each database image
    for d = 1:size(db, 2)
        current = db{1,d};
        meanL = mean2(current(:,:,1));
        meanA = mean2(current(:,:,2));
        meanB = mean2(current(:,:,3));
        means(d,:) = [meanL, meanA, meanB];
    end
    
    for r = 1:stepSize:rows
        
        for c = 1:stepSize:cols

           sub_image = image(r:r+stepSize-1, c:c+stepSize-1, :);
           meanL_image = mean2(sub_image(:,:,1));
           meanA_image = mean2(sub_image(:,:,2));
           meanB_image = mean2(sub_image(:,:,3));
           % + (1 - ssim(sub_image(:,:,1), db{1,a}(:,:,1)))^2
           
           for a = 1:size(db, 2)
               distances(1,a) = sqrt( (means(a,1) - meanL_image)^2 + (means(a,2) - meanA_image)^2 + (means(a,3) - meanB_image)^2 );
           end

           [value, index] = min(distances);
           reproduced_image(r:r+stepSize-1, c:c+stepSize-1, :) = db{1,index};
     
        end
       
    end

    reproduced_image = lab2rgb(reproduced_image);

end

