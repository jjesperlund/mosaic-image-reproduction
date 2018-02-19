function [ reproduced_image ] = mosaic_reproduce( image )

    load('db_19.mat')

    [rows cols channels] = size(image);
    image = rgb2lab(image);
    
    reproduced_image = zeros(rows * size(db{1,1}, 1), cols * size(db{1,1}, 1), channels);
    
    % L,a,b mean of each database image
    for d = 1:19
        current = db{1,d};
        meanL = mean2(current(:,:,1));
        meanA = mean2(current(:,:,2));
        meanB = mean2(current(:,:,3));
        means(d,:) = [meanL, meanA, meanB];
    end
    
    stepY = 0;
    for r = 1:rows
        
        stepX = 0;
        for c = 1:cols
           imgL = image(r,c,1);
           imgA = image(r,c,2);
           imgB = image(r,c,3);
           
           for a = 1:size(db, 2)
               distances(1,a) = sqrt( (means(a,1) - imgL)^2 + (means(a,2) - imgA)^2 + (means(a,3) - imgB)^2 );
           end

           [value, index] = min(distances);
           reproduced_image(r+stepY:r+stepY+30-1, c+stepX:c+stepX+30-1, :) = db{1,index};
           stepX = stepX + 30;
        end
        stepY = stepY + 30;
    end

    reproduced_image = lab2rgb(reproduced_image);

end

