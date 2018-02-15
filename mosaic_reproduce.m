function [ reproduced_image ] = mosaic_reproduce( image )

    load('db_19.mat')

    [rows cols channels] = size(image);
    image = rgb2lab(image);
    
    for d = 1:19
        current = db{1,d};
        meanL = mean2(current(:,:,1));
        meanA = mean2(current(:,:,2));
        meanB = mean2(current(:,:,2));
        means(d,:) = [meanL, meanA, meanB];
    end
    
    for r = 1:rows
        for c = 1:cols
           
        end
    end
    %{
    %}
    
    image = lab2rgb(image);
    reproduced_image = image;

end

